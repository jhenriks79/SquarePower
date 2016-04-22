using CsvHelper;
using SquareApiConsumer.Common;
using SquareApiConsumer.Models;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Threading.Tasks;

namespace SquareApiConsumer
{
    public class Program
    {
        private static void Main(string[] args)
        {
            Console.WriteLine("Processing main...");

            MainAsync().Wait();

            Console.WriteLine("Main complete...");
            Console.ReadLine();
        }

        private static async Task MainAsync()
        {
            const int taskCount = 10;
            var tasks = new Task[taskCount];
            var startDate = new DateTime(2015, 1, 1);
            double totalDays = (DateTime.UtcNow.Date - startDate).TotalDays;

            int remainder = (int)totalDays % taskCount;
            int numOfDays = (int)totalDays / taskCount;

            // For each item, queue transfer and add to progress tracker
            for (int i = 0; i < taskCount; i++)
            {
                if (i == taskCount - 1)
                {
                    tasks[i] = RunAsync(i, startDate.AddDays(i * numOfDays),
                        startDate.AddDays(((i + 1) * numOfDays) + remainder));
                    continue;
                }

                tasks[i] = RunAsync(i, startDate.AddDays(i * numOfDays), startDate.AddDays((i + 1) * numOfDays));
            }

            await Task.WhenAll(tasks);
        }

        private static async Task RunAsync(int id, DateTime startDate, DateTime endDate)
        {
            Console.WriteLine("{2} - Processing for {0} to {1}...", startDate, endDate, id);

            var connectApi = new SquareConnectApi();

            while (startDate.Date < endDate)
            {
                Console.WriteLine("{1} - Fetching payments for {0}...", startDate, id);

                string paymentsFileName = string.Format("payments/payments_{0:yyyyMMdd}.csv", startDate);
                string itemizationsFileName = string.Format("itemizations/itemizations_{0:yyyyMMdd}.csv", startDate);
                string discountsFileName = string.Format("discounts/discounts_{0:yyyyMMdd}.csv", startDate);
                string modifiersFileName = string.Format("modifiers/modifiers_{0:yyyyMMdd}.csv", startDate);

                List<Payment> payments = await connectApi.GetPaymentsAsync(id, startDate);
                List<Itemization> itemizations = payments.SelectMany(x => x.Itemizations).ToList();
                List<Discount> discounts = itemizations.SelectMany(x => x.Discounts).ToList();
                List<Modifier> modifiers = itemizations.SelectMany(x => x.Modifiers).ToList();

                var tasks = new Task[4];
                tasks[0] = WriteFile(id, "data", paymentsFileName, payments);
                tasks[1] = WriteFile(id, "data", itemizationsFileName, itemizations);
                tasks[2] = WriteFile(id, "data", discountsFileName, discounts);
                tasks[3] = WriteFile(id, "data", modifiersFileName, modifiers);

                await Task.WhenAll(tasks);

                startDate = startDate.AddDays(1).Date;
            }
        }

        private static void RunFindMissingFiles()
        {
            var blobWriter = new BlobWriter(ConfigHelper.StorageConnectionString);
            var startDate = new DateTime(2015, 1, 1);
            var list = new List<DateTime>();

            while (startDate < DateTime.UtcNow.Date)
            {
                string blobName = string.Format("itemizations/itemizations_{0:yyyyMMdd}.csv", startDate);
                Console.WriteLine("Checking {0}...", blobName);

                try
                {
                    var blob = blobWriter.Read("data", blobName);
                    blob.FetchAttributes();
                }
                catch (Exception exc)
                {
                    Console.WriteLine("Missing {0}...", blobName);
                    list.Add(startDate);
                }

                startDate = startDate.AddDays(1);
            }
        }

        private static async Task WriteFile<T>(int id, string container, string blobName, T items) where T : IEnumerable
        {
            // Write temp file
            Console.WriteLine("{0} - Writing temporary file...", id);

            var fileInfo = new FileInfo(Path.Combine(ConfigurationManager.AppSettings["TempPath"], blobName));
            Debug.Assert(fileInfo.DirectoryName != null, "fileInfo.DirectoryName != null");
            Directory.CreateDirectory(fileInfo.DirectoryName);

            using (var textWriter = new StreamWriter(fileInfo.FullName))
            {
                using (var csv = new CsvWriter(textWriter))
                {
                    csv.Configuration.PrefixReferenceHeaders = true;
                    csv.Configuration.Delimiter = "|";

                    csv.WriteRecords(items);
                }
            }

            // Upload to Blob storage
            Console.WriteLine("{0} - Uploading to blob storage...", id);

            var blobWriter = new BlobWriter(ConfigHelper.StorageConnectionString);
            await blobWriter.WriteAsync(fileInfo.FullName, container, blobName);
        }
    }
}