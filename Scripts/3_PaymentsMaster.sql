IF OBJECT_ID( 'dbo.SquarePaymentsMaster' ) IS NOT NULL
BEGIN
    DROP TABLE dbo.SquarePaymentsMaster;
END;
GO

CREATE TABLE dbo.SquarePaymentsMaster
(
  Id                              VARCHAR(50) NOT NULL,
  AdditiveTaxMoneyAmount          INT NOT NULL,
  AdditiveTaxMoneyCurrencyCode    VARCHAR(10) NULL,
  CreatedAt                       DATETIME NOT NULL,
  CreatedAtDate                   DATE NOT NULL,
  CreatedAtTime                   TIME NOT NULL,
  CreatedAtBucket                 INT NOT NULL,
  CreatedAtDayOfWeek              VARCHAR(12) NOT NULL,
  DeviceName                      VARCHAR(400) NULL,
  DiscountMoneyAmount             INT NOT NULL,
  DiscountMoneyCurrencyCode       VARCHAR(10) NULL,
  InclusiveTaxMoneyAmount         INT NULL,
  InclusiveTaxMoneyCurrencyCode   VARCHAR(10) NULL,
  LocationBusinessName            VARCHAR(100) NOT NULL,
  LocationEmail                   VARCHAR(100) NOT NULL,
  LocationId                      VARCHAR(100) NOT NULL,
  LocationName                    VARCHAR(100) NOT NULL,
  MerchantId                      VARCHAR(100) NOT NULL,
  NetTotalMoneyAmount             INT NOT NULL,
  NetTotalMoneyCurrencyCode       VARCHAR(10) NULL,
  ProcessingFeeMoneyAmount        INT NOT NULL,
  ProcessingFeeMoneyCurrencyCode  VARCHAR(10) NULL,
  RefundedMoneyAmount             INT NOT NULL,
  RefundedMoneyCurrencyCode       VARCHAR(10) NULL,
  TaxMoneyAmount                  INT NOT NULL,
  TaxMoneyCurrencyCode            VARCHAR(10) NULL,
  TipMoneyAmount                  INT NOT NULL,
  TipMoneyCurrencyCode            VARCHAR(10) NULL,
  TotalCollectedMoneyAmount       INT NOT NULL,
  TotalCollectedMoneyCurrencyCode VARCHAR(10) NULL,
  -- Calculated Columns
  FactDiscountMoneyAmount         DECIMAL(12, 2) NULL,
  FactNetTotalMoneyAmount         DECIMAL(12, 2) NULL,
  FactRefundedMoneyAmount         DECIMAL(12, 2) NULL,
  FactTotalCollectedMoneyAmount   DECIMAL(12, 2) NULL,
  FactTipMoneyAmount              DECIMAL(12, 2) NULL,
  DimYearMonth                    INT NOT NULL)
WITH
  ( 
    DISTRIBUTION = HASH (Id), 
    CLUSTERED COLUMNSTORE INDEX
);
GO

TRUNCATE TABLE dbo.SquarePaymentsMaster;
GO

SET NOCOUNT ON;

INSERT INTO dbo.SquarePaymentsMaster
       SELECT --top 10000
       Id,
       AdditiveTaxMoneyAmount,
       AdditiveTaxMoneyCurrencyCode,
       CreatedAt,
       CONVERT( DATE, CreatedAt ),
       CAST( CreatedAt AS     TIME ),
       CASE
         WHEN CAST( CreatedAt AS     TIME )<    ='01:00:00.0000000'
         THEN 1
         WHEN CAST( CreatedAt AS TIME )<='02:00:00.0000000'
         THEN 2
         WHEN CAST( CreatedAt AS TIME )<='03:00:00.0000000'
         THEN 3
         WHEN CAST( CreatedAt AS TIME )<='04:00:00.0000000'
         THEN 4
         WHEN CAST( CreatedAt AS TIME )<='05:00:00.0000000'
         THEN 5
         WHEN CAST( CreatedAt AS TIME )<='06:00:00.0000000'
         THEN 6
         WHEN CAST( CreatedAt AS TIME )<='07:00:00.0000000'
         THEN 7
         WHEN CAST( CreatedAt AS TIME )<='08:00:00.0000000'
         THEN 8
         WHEN CAST( CreatedAt AS TIME )<='09:00:00.0000000'
         THEN 9
         WHEN CAST( CreatedAt AS TIME )<='10:00:00.0000000'
         THEN 10
         WHEN CAST( CreatedAt AS TIME )<='11:00:00.0000000'
         THEN 11
         WHEN CAST( CreatedAt AS TIME )<='12:00:00.0000000'
         THEN 12
         WHEN CAST( CreatedAt AS TIME )<='13:00:00.0000000'
         THEN 13
         WHEN CAST( CreatedAt AS TIME )<='14:00:00.0000000'
         THEN 14
         WHEN CAST( CreatedAt AS TIME )<='15:00:00.0000000'
         THEN 15
         WHEN CAST( CreatedAt AS TIME )<='16:00:00.0000000'
         THEN 16
         WHEN CAST( CreatedAt AS TIME )<='17:00:00.0000000'
         THEN 17
         WHEN CAST( CreatedAt AS TIME )<='18:00:00.0000000'
         THEN 18
         WHEN CAST( CreatedAt AS TIME )<='19:00:00.0000000'
         THEN 19
         WHEN CAST( CreatedAt AS TIME )<='20:00:00.0000000'
         THEN 20
         WHEN CAST( CreatedAt AS TIME )<='21:00:00.0000000'
         THEN 21
         WHEN CAST( CreatedAt AS TIME )<='22:00:00.0000000'
         THEN 22
         WHEN CAST( CreatedAt AS TIME )<='23:00:00.0000000'
         THEN 23
         WHEN CAST( CreatedAt AS TIME )<='23:59:59.0000000'
         THEN 24
         ELSE 'Other'
       END,
       DATENAME( dw, CAST( CreatedAt AS DATETIME ) ),
       DeviceName,
       DiscountMoneyAmount,
       DiscountMoneyCurrencyCode,
       InclusiveTaxMoneyAmount,
       InclusiveTaxMoneyCurrencyCode,
       LocationBusinessName,
       LocationEmail,
       LocationId,
       LocationName,
       MerchantId,
       NetTotalMoneyAmount,
       NetTotalMoneyCurrencyCode,
       ProcessingFeeMoneyAmount,
       ProcessingFeeMoneyCurrencyCode,
       RefundedMoneyAmount,
       RefundedMoneyCurrencyCode,
       TaxMoneyAmount,
       TaxMoneyCurrencyCode,
       TipMoneyAmount,
       TipMoneyCurrencyCode,
       TotalCollectedMoneyAmount,
       TotalCollectedMoneyCurrencyCode,
       -- Calculated Columns (Facts)
       CONVERT( DECIMAL, DiscountMoneyAmount )/100,
       CONVERT( DECIMAL, NetTotalMoneyAmount )/100,
       CONVERT( DECIMAL, RefundedMoneyAmount )/100,
       CONVERT( DECIMAL, TotalCollectedMoneyAmount )/100,
       CONVERT( DECIMAL, TipMoneyAmount )/100,
       CONVERT( VARCHAR, DATEPART( year, CONVERT( DATE, CreatedAt ) ) )+CASE
                                                                          WHEN LEN( CONVERT( VARCHAR, DATEPART( month, CONVERT( DATE, CreatedAt ) ) ) )=1
                                                                          THEN '0'+CONVERT( VARCHAR, DATEPART( month, CONVERT( DATE, CreatedAt ) ) )
                                                                          ELSE CONVERT( VARCHAR, DATEPART( month, CONVERT( DATE, CreatedAt ) ) )
                                                                        END
       FROM dbo.SquarePayments
       WHERE Id!='id'; -- DO NOT INCLUDE HEADER COLUMNS