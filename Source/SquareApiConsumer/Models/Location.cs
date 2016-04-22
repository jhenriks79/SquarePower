using Newtonsoft.Json;

namespace SquareApiConsumer.Models
{
    public class BusinessAddress
    {
        [JsonProperty("address_line_1")]
        public string AddressLine1 { get; set; }

        [JsonProperty("administrative_district_level_1")]
        public string AdministrativeDistrictLevel1 { get; set; }

        [JsonProperty("locality")]
        public string Locality { get; set; }

        [JsonProperty("postal_code")]
        public string PostalCode { get; set; }
    }

    public class BusinessPhone
    {
        [JsonProperty("calling_code")]
        public string CallingCode { get; set; }

        [JsonProperty("number")]
        public string Number { get; set; }
    }

    public class Location
    {
        [JsonProperty("account_type")]
        public string AccountType { get; set; }

        [JsonProperty("business_address")]
        public BusinessAddress BusinessAddress { get; set; }

        [JsonProperty("business_name")]
        public string BusinessName { get; set; }

        [JsonProperty("business_phone")]
        public BusinessPhone BusinessPhone { get; set; }

        [JsonProperty("business_type")]
        public string BusinessType { get; set; }

        [JsonProperty("country_code")]
        public string CountryCode { get; set; }

        [JsonProperty("currency_code")]
        public string CurrencyCode { get; set; }

        [JsonProperty("email")]
        public string Email { get; set; }

        [JsonProperty("id")]
        public string Id { get; set; }

        [JsonProperty("language_code")]
        public string LanguageCode { get; set; }

        [JsonProperty("location_details")]
        public LocationDetails LocationDetails { get; set; }

        [JsonProperty("market_url")]
        public string MarketUrl { get; set; }

        [JsonProperty("name")]
        public string Name { get; set; }

        [JsonProperty("shipping_address")]
        public ShippingAddress ShippingAddress { get; set; }
    }

    public class LocationDetails
    {
        [JsonProperty("nickname")]
        public string Nickname { get; set; }
    }

    public class ShippingAddress
    {
        [JsonProperty("address_line_1")]
        public string AddressLine1 { get; set; }

        [JsonProperty("administrative_district_level_1")]
        public string AdministrativeDistrictLevel1 { get; set; }

        [JsonProperty("locality")]
        public string Locality { get; set; }

        [JsonProperty("postal_code")]
        public string PostalCode { get; set; }
    }
}