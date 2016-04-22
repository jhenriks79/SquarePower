using Newtonsoft.Json;
using SquareApiConsumer.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Threading.Tasks;

namespace SquareApiConsumer.Common
{
    public class SquareConnectApi
    {
        private const string LocationUrl = "https://connect.squareup.com/v1/me/locations";

        private const string PaymentUrl =
            "https://connect.squareup.com/v1/{2}/payments?begin_time={0:yyyy-MM-dd}T00:00:00Z&end_time={1:yyyy-MM-dd}T00:00:00Z";

        private static List<Location> _locations = new List<Location>();
        private readonly object _resourceLock = new object();

        public async Task<List<Payment>> GetPaymentsAsync(int id, DateTime startDate)
        {
            var client = new HttpClient();
            client.DefaultRequestHeaders.Add("Authorization", String.Format("Bearer {0}", ConfigHelper.ApiKey));
            client.DefaultRequestHeaders.Add("Accept", "application/json");
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

            // Only get locations once
            if (_locations.Count == 0)
            {
                lock (_resourceLock)
                {
                    Console.WriteLine("{0} - Getting locations...", id);

                    string locationResponse = client.GetStringAsync(LocationUrl).Result;
                    _locations = JsonConvert.DeserializeObject<List<Location>>(locationResponse);
                }
            }

            var payments = new List<Payment>();

            foreach (string locationId in _locations.Select(x => x.Id).Distinct().ToList())
            {
                string paymentUrl = string.Format(PaymentUrl, startDate.Date, startDate.AddDays(1).Date, locationId);
                Location location = _locations.FirstOrDefault(y => y.Id == locationId);
                bool isNext;
                int index = 0;

                do
                {
                    Console.WriteLine("{2} - Getting payments for {0}.{1}...", locationId, index++, id);

                    HttpResponseMessage responseMessage = await client.GetAsync(paymentUrl);
                    string responseContent = await responseMessage.Content.ReadAsStringAsync();
                    var tempPayments = JsonConvert.DeserializeObject<List<Payment>>(responseContent);

                    // Populate locations and itemizations in payments
                    tempPayments.ForEach(x => x.Location = location);
                    tempPayments.ForEach(x => x.Itemizations.ForEach(y =>
                    {
                        y.PaymentId = x.Id;
                        if (!string.IsNullOrWhiteSpace(y.Notes)) y.Notes = y.Notes.Replace("\r\n", "<CRLF>").Replace("\n", "<CRLF>");
                    }));
                    tempPayments.ForEach(
                        x => x.Itemizations.ForEach(y => y.Discounts.ForEach(z => z.ItemizationId = y.ItemizationId)));
                    tempPayments.ForEach(
                        x => x.Itemizations.ForEach(y => y.Modifiers.ForEach(z => z.ItemizationId = y.ItemizationId)));
                    payments.AddRange(tempPayments);

                    // Check if more results
                    isNext = false;
                    if (!responseMessage.Headers.Contains("link")) continue;

                    KeyValuePair<string, IEnumerable<string>> paginationHeader =
                        responseMessage.Headers.FirstOrDefault(
                            x => x.Key.Equals("link", StringComparison.OrdinalIgnoreCase));

                    if (!paginationHeader.Value.Any(x => x.Contains("rel='next'"))) continue;

                    // Extract the next batch URL from the header.
                    // Pagination headers have the following format:
                    // <https://connect.squareup.com/v1/MERCHANT_ID/payments?batch_token=BATCH_TOKEN>;rel='next'
                    // This line extracts the URL from the angle brackets surrounding it.
                    paymentUrl = paginationHeader.Value.First().Split(new[] { '<' })[1].Split(new[] { '>' })[0];
                    isNext = true;
                } while (isNext);
            }

            return payments;
        }
    }
}