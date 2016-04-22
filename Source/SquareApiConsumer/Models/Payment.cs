using Newtonsoft.Json;
using System;
using System.Collections.Generic;

namespace SquareApiConsumer.Models
{
    public class AdditiveTax
    {
        [JsonProperty("applied_money")]
        public AppliedMoney AppliedMoney { get; set; }

        [JsonProperty("inclusion_type")]
        public string InclusionType { get; set; }

        [JsonProperty("name")]
        public string Name { get; set; }

        [JsonProperty("rate")]
        public string Rate { get; set; }
    }

    public class AdditiveTaxMoney
    {
        [JsonProperty("amount")]
        public int Amount { get; set; }

        [JsonProperty("currency_code")]
        public string CurrencyCode { get; set; }
    }

    public class AppliedMoney
    {
        [JsonProperty("amount")]
        public int Amount { get; set; }

        [JsonProperty("currency_code")]
        public string CurrencyCode { get; set; }
    }

    public class Device
    {
        [JsonProperty("name")]
        public string Name { get; set; }
    }

    public class Discount
    {
        [JsonProperty("applied_money")]
        public AppliedMoney AppliedMoney { get; set; }

        [JsonProperty("discount_id")]
        public string DiscountId { get; set; }

        [JsonIgnore]
        public Guid ItemizationId { get; set; }

        [JsonProperty("name")]
        public string Name { get; set; }
    }

    public class DiscountMoney
    {
        [JsonProperty("amount")]
        public int Amount { get; set; }

        [JsonProperty("currency_code")]
        public string CurrencyCode { get; set; }
    }

    public class GrossSalesMoney
    {
        [JsonProperty("amount")]
        public int Amount { get; set; }

        [JsonProperty("currency_code")]
        public string CurrencyCode { get; set; }
    }

    public class InclusiveTaxMoney
    {
        [JsonProperty("amount")]
        public int Amount { get; set; }

        [JsonProperty("currency_code")]
        public string CurrencyCode { get; set; }
    }

    public class ItemDetail
    {
        [JsonProperty("category_name")]
        public string CategoryName { get; set; }

        [JsonProperty("item_id")]
        public string ItemId { get; set; }

        [JsonIgnore]
        public Guid ItemizationId { get; set; }

        [JsonProperty("item_variation_id")]
        public string ItemVariationId { get; set; }

        [JsonProperty("sku")]
        public string Sku { get; set; }
    }

    public class Itemization
    {
        public Itemization()
        {
            ItemizationId = Guid.NewGuid();
        }

        [JsonProperty("discount_money")]
        public DiscountMoney DiscountMoney { get; set; }

        [JsonProperty("discounts")]
        public List<Discount> Discounts { get; set; }

        [JsonProperty("gross_sales_money")]
        public GrossSalesMoney GrossSalesMoney { get; set; }

        [JsonProperty("item_detail")]
        public ItemDetail ItemDetail { get; set; }

        [JsonIgnore]
        public Guid ItemizationId { get; set; }

        [JsonProperty("item_variation_name")]
        public string ItemVariationName { get; set; }

        [JsonProperty("modifiers")]
        public List<Modifier> Modifiers { get; set; }

        [JsonProperty("name")]
        public string Name { get; set; }

        [JsonProperty("net_sales_money")]
        public NetSalesMoney NetSalesMoney { get; set; }

        [JsonProperty("notes")]
        public string Notes { get; set; }

        [JsonIgnore]
        public string PaymentId { get; set; }

        [JsonProperty("quantity")]
        public string Quantity { get; set; }

        [JsonProperty("single_quantity_money")]
        public SingleQuantityMoney SingleQuantityMoney { get; set; }

        [JsonProperty("taxes")]
        public List<Tax> Taxes { get; set; }

        [JsonProperty("total_money")]
        public TotalMoney TotalMoney { get; set; }
    }

    public class Modifier
    {
        [JsonProperty("applied_money")]
        public AppliedMoney AppliedMoney { get; set; }

        [JsonIgnore]
        public Guid ItemizationId { get; set; }

        [JsonProperty("modifier_option_id")]
        public string ModifierOptionId { get; set; }

        [JsonProperty("name")]
        public string Name { get; set; }
    }

    public class NetSalesMoney
    {
        [JsonProperty("amount")]
        public int Amount { get; set; }

        [JsonProperty("currency_code")]
        public string CurrencyCode { get; set; }
    }

    public class NetTotalMoney
    {
        [JsonProperty("amount")]
        public int Amount { get; set; }

        [JsonProperty("currency_code")]
        public string CurrencyCode { get; set; }
    }

    public class Payment
    {
        [JsonProperty("additive_tax")]
        public List<AdditiveTax> AdditiveTax { get; set; }

        [JsonProperty("additive_tax_money")]
        public AdditiveTaxMoney AdditiveTaxMoney { get; set; }

        [JsonProperty("created_at")]
        public DateTime CreatedAt { get; set; }

        [JsonProperty("creator_id")]
        public string CreatorId { get; set; }

        [JsonProperty("device")]
        public Device Device { get; set; }

        [JsonProperty("discount_money")]
        public DiscountMoney DiscountMoney { get; set; }

        [JsonProperty("id")]
        public string Id { get; set; }

        [JsonProperty("inclusive_tax")]
        public List<object> InclusiveTax { get; set; }

        [JsonProperty("inclusive_tax_money")]
        public InclusiveTaxMoney InclusiveTaxMoney { get; set; }

        [JsonProperty("itemizations")]
        public List<Itemization> Itemizations { get; set; }

        [JsonIgnore]
        public Location Location { get; set; }

        [JsonProperty("merchant_id")]
        public string MerchantId { get; set; }

        [JsonProperty("net_total_money")]
        public NetTotalMoney NetTotalMoney { get; set; }

        [JsonProperty("payment_url")]
        public string PaymentUrl { get; set; }

        [JsonProperty("processing_fee_money")]
        public ProcessingFeeMoney ProcessingFeeMoney { get; set; }

        [JsonProperty("refunded_money")]
        public RefundedMoney RefundedMoney { get; set; }

        [JsonProperty("refunds")]
        public List<object> Refunds { get; set; }

        [JsonProperty("tax_money")]
        public TaxMoney TaxMoney { get; set; }

        [JsonProperty("tender")]
        public List<Tender> Tender { get; set; }

        [JsonProperty("tip_money")]
        public TipMoney TipMoney { get; set; }

        [JsonProperty("total_collected_money")]
        public TotalCollectedMoney TotalCollectedMoney { get; set; }
    }

    public class ProcessingFeeMoney
    {
        [JsonProperty("amount")]
        public int Amount { get; set; }

        [JsonProperty("currency_code")]
        public string CurrencyCode { get; set; }
    }

    public class RefundedMoney
    {
        [JsonProperty("amount")]
        public int Amount { get; set; }

        [JsonProperty("currency_code")]
        public string CurrencyCode { get; set; }
    }

    public class SingleQuantityMoney
    {
        [JsonProperty("amount")]
        public int Amount { get; set; }

        [JsonProperty("currency_code")]
        public string CurrencyCode { get; set; }
    }

    public class Tax
    {
        [JsonProperty("applied_money")]
        public AppliedMoney AppliedMoney { get; set; }

        [JsonProperty("fee_id")]
        public string FeeId { get; set; }

        [JsonProperty("inclusion_type")]
        public string InclusionType { get; set; }

        [JsonProperty("name")]
        public string Name { get; set; }

        [JsonProperty("rate")]
        public string Rate { get; set; }
    }

    public class TaxMoney
    {
        [JsonProperty("amount")]
        public int Amount { get; set; }

        [JsonProperty("currency_code")]
        public string CurrencyCode { get; set; }
    }

    public class Tender
    {
        [JsonProperty("card_brand")]
        public string CardBrand { get; set; }

        [JsonProperty("entry_method")]
        public string EntryMethod { get; set; }

        [JsonProperty("name")]
        public string Name { get; set; }

        [JsonProperty("pan_suffix")]
        public string PanSuffix { get; set; }

        [JsonProperty("total_money")]
        public TotalMoney TotalMoney { get; set; }

        [JsonProperty("type")]
        public string Type { get; set; }
    }

    public class TipMoney
    {
        [JsonProperty("amount")]
        public int Amount { get; set; }

        [JsonProperty("currency_code")]
        public string CurrencyCode { get; set; }
    }

    public class TotalCollectedMoney
    {
        [JsonProperty("amount")]
        public int Amount { get; set; }

        [JsonProperty("currency_code")]
        public string CurrencyCode { get; set; }
    }

    public class TotalMoney
    {
        [JsonProperty("amount")]
        public int Amount { get; set; }

        [JsonProperty("currency_code")]
        public string CurrencyCode { get; set; }
    }
}