IF OBJECT_ID( 'dbo.SquareItemizationsMaster' ) IS NOT NULL
BEGIN
    DROP TABLE dbo.SquareItemizationsMaster;
END;
GO

CREATE TABLE dbo.SquareItemizationsMaster
(
  PaymentId                     VARCHAR(50) NOT NULL,
  ItemDetailCategoryName        VARCHAR(100) NULL,
  ItemDetailItemId              VARCHAR(40) NULL,
  ItemDetailItemVariationId     VARCHAR(40) NULL,
  ItemVariationName             VARCHAR(800) NULL,
  Name                          VARCHAR(800) NULL,
  SingleQuantityMoneyAmount     INT NOT NULL,
  TotalMoneyAmount              INT NOT NULL,
  DiscountMoneyAmount           INT NOT NULL,
  GrossSalesMoneyAmount         INT NOT NULL,
  NetSalesMoneyAmount           INT NOT NULL,
  Notes                         VARCHAR(800) NULL,
  -- Calculated Columns
  FactSingleQuantityMoneyAmount DECIMAL(12, 2),
  FactTotalMoneyAmount          DECIMAL(12, 2),
  FactGrossSalesMoneyAmount     DECIMAL(12, 2),
  FactNetSalesMoneyAmount       DECIMAL(12, 2))
WITH
  ( 
    DISTRIBUTION = HASH (PaymentId), 
    CLUSTERED COLUMNSTORE INDEX
  );
GO

TRUNCATE TABLE SquareItemizationsMaster;
GO

SET NOCOUNT ON;

INSERT INTO dbo.SquareItemizationsMaster
       SELECT -- top 5000
       PaymentId,
       ItemDetailCategoryName,
       ItemDetailItemId,
       ItemDetailItemVariationId,
       ItemVariationName,
       Name,
       SingleQuantityMoneyAmount,
       TotalMoneyAmount,
       DiscountMoneyAmount,
       GrossSalesMoneyAmount,
       NetSalesMoneyAmount,
       Notes,
       -- Calculated Columns
       CONVERT( DECIMAL, SingleQuantityMoneyAmount )/100,
       CONVERT( DECIMAL, TotalMoneyAmount )/100,
       CONVERT( DECIMAL, GrossSalesMoneyAmount )/100,
       CONVERT( DECIMAL, NetSalesMoneyAmount )/100
       FROM dbo.SquareItemizations
       WHERE PaymentId!='PaymentId';