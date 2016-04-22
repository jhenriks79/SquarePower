IF OBJECT_ID( 'dbo.SquarePayments' ) IS NOT NULL
BEGIN
    DROP EXTERNAL TABLE dbo.SquarePayments;
END;
GO

CREATE EXTERNAL TABLE dbo.SquarePayments(
  AdditiveTaxMoneyAmount                      VARCHAR(400) NULL,
  AdditiveTaxMoneyCurrencyCode                VARCHAR(100) NULL,
  CreatedAt                                   VARCHAR(400) NULL,
  CreatorId                                   VARCHAR(400) NULL,
  DeviceName                                  VARCHAR(400) NULL,
  DiscountMoneyAmount                         VARCHAR(400) NULL,
  DiscountMoneyCurrencyCode                   VARCHAR(400) NULL,
  Id                                          VARCHAR(100) NOT NULL,
  InclusiveTaxMoneyAmount                     VARCHAR(800) NULL,
  InclusiveTaxMoneyCurrencyCode               VARCHAR(100) NULL,
  LocationAccountType                         VARCHAR(400) NULL,
  BusinessAddressAddressLine1                 VARCHAR(800) NULL,
  BusinessAddressAdministrativeDistrictLevel1 VARCHAR(800) NULL,
  BusinessAddressLocality                     VARCHAR(800) NULL,
  BusinessAddressPostalCode                   VARCHAR(800) NULL,
  LocationBusinessName                        VARCHAR(800) NULL,
  BusinessPhoneCallingCode                    VARCHAR(800) NULL,
  BusinessPhoneNumber                         VARCHAR(800) NULL,
  LocationBusinessType                        VARCHAR(800) NULL,
  LocationCountryCode                         VARCHAR(800) NOT NULL,
  LocationCurrencyCode                        VARCHAR(800) NULL,
  LocationEmail                               VARCHAR(800) NOT NULL,
  LocationId                                  VARCHAR(800) NOT NULL,
  LocationLanguageCode                        VARCHAR(800) NULL,
  LocationDetailsNickname                     VARCHAR(800) NULL,
  LocationMarketUrl                           VARCHAR(800) NULL,
  LocationName                                VARCHAR(800) NOT NULL,
  ShippingAddressAddressLine1                 VARCHAR(800) NULL,
  ShippingAddressLocality                     VARCHAR(800) NULL,
  ShippingAddressAdministrativeDistrictLevel1 VARCHAR(800) NULL,
  ShippingAddressPostalCode                   VARCHAR(800) NULL,
  MerchantId                                  VARCHAR(800) NOT NULL,
  NetTotalMoneyAmount                         VARCHAR(800) NULL,
  NetTotalMoneyCurrencyCode                   VARCHAR(800) NULL,
  PaymentUrl                                  VARCHAR(800) NULL,
  ProcessingFeeMoneyAmount                    VARCHAR(800) NULL,
  ProcessingFeeMoneyCurrencyCode              VARCHAR(800) NULL,
  RefundedMoneyAmount                         VARCHAR(800) NULL,
  RefundedMoneyCurrencyCode                   VARCHAR(800) NULL,
  TaxMoneyAmount                              VARCHAR(800) NULL,
  TaxMoneyCurrencyCode                        VARCHAR(800) NULL,
  TipMoneyAmount                              VARCHAR(800) NULL,
  TipMoneyCurrencyCode                        VARCHAR(800) NULL,
  TotalCollectedMoneyAmount                   VARCHAR(800) NULL,
  TotalCollectedMoneyCurrencyCode             VARCHAR(800) NULL ) WITH( LOCATION='payments/', DATA_SOURCE=AzureStorageSquarePoc, FILE_FORMAT=TextFilePipe, REJECT_TYPE=VALUE, REJECT_VALUE=100000 );