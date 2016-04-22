IF OBJECT_ID( 'dbo.SquareItemizations' ) IS NOT NULL
BEGIN
    DROP EXTERNAL TABLE dbo.SquareItemizations;
END;
GO

CREATE EXTERNAL TABLE dbo.SquareItemizations(
  DiscountMoneyAmount             VARCHAR(800) NULL,
  DiscountMoneyCurrencyCode       VARCHAR(800) NULL,
  GrossSalesMoneyAmount           VARCHAR(800) NULL,
  GrossSalesMoneyCurrencyCode     VARCHAR(800) NULL,
  ItemDetailCategoryName          VARCHAR(800) NULL,
  ItemDetailItemId                VARCHAR(800) NULL,
	ItemDetailItemizationId varchar(800) NULL,
  ItemDetailItemVariationId       VARCHAR(800) NULL,
  ItemDetailSku                   VARCHAR(800) NULL,
	ItemizationId varchar(800) NULL, -- 10
  ItemVariationName               VARCHAR(800) NULL,
  Name                            VARCHAR(800) NULL,
  NetSalesMoneyAmount             VARCHAR(800) NULL,
  NetSalesMoneyCurrencyCode       VARCHAR(800) NULL,
  Notes                           VARCHAR(800) NULL,
  PaymentId                       VARCHAR(800) NULL,
  Quantity                        VARCHAR(800) NULL,
  SingleQuantityMoneyAmount       VARCHAR(800) NULL,
  SingleQuantityMoneyCurrencyCode VARCHAR(800) NULL,
  TotalMoneyAmount                VARCHAR(800) NULL,
  TotalMoneyCurrencyCode          VARCHAR(800) NULL ) WITH( LOCATION='itemizations/', DATA_SOURCE=AzureStorageSquarePoc, FILE_FORMAT=TextFilePipe, REJECT_TYPE=VALUE, REJECT_VALUE=100000 -- about 20,000 rows don't load, carriage returns
);