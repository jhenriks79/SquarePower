IF(OBJECT_ID('dbo.SquareLocationSummariesStaging') IS NOT NULL)
    BEGIN
        DROP TABLE dbo.SquareLocationSummariesStaging;
    END;
GO

CREATE TABLE dbo.SquareLocationSummariesStaging
(LocationBusinessName          VARCHAR(100) NOT NULL,
 YearMonth                     INT,
 FactNetTotalMoneyAmount       DECIMAL(12, 2),
 FactTotalCollectedMoneyAmount DECIMAL(12, 2)
);
GO

TRUNCATE TABLE SquareLocationSummariesStaging;
GO

INSERT INTO SquareLocationSummariesStaging
       SELECT LocationBusinessName,
              DimYearMonth,
              SUM(FactNetTotalMoneyAmount),
              SUM(FactTotalCollectedMoneyAmount)
       FROM dbo.SquarePaymentsMaster
       -- where 
       -- LocationBusinessName = 'King Creole' --and CreatedAtDate = '10/05/2015'
       GROUP BY LocationBusinessName,
                DimYearMonth;
GO

IF(OBJECT_ID('dbo.SquareLocationSummariesMaster') IS NOT NULL)
    BEGIN
        DROP TABLE dbo.SquareLocationSummariesMaster;
    END;
GO

CREATE TABLE dbo.SquareLocationSummariesMaster
(LocationBusinessName                               VARCHAR(100) NOT NULL,
 YearMonth                                          INT,
 YearMonthDate                                      DATETIME,
 FactNetTotalMoneyAmount                            DECIMAL(12, 2),
 FactTotalCollectedMoneyAmount                      DECIMAL(12, 2),
 FactNetTotalMoneyAmountPreviousMonth               DECIMAL(12, 2),
 FactTotalCollectedMoneyAmountPreviousMonth         DECIMAL(12, 2),
 FactNetTotalMoneyAmountPreviousThreeMonthAvg       DECIMAL(12, 2),
 FactTotalCollectedMoneyAmountPreviousThreeMonthAvg DECIMAL(12, 2)
);
GO

TRUNCATE TABLE dbo.SquareLocationSummariesMaster;
GO

INSERT INTO dbo.SquareLocationSummariesMaster
       SELECT DISTINCT
              summary.LocationBusinessName,
              summary.YearMonth,
              CONVERT( DATETIME, (CONVERT(VARCHAR, summary.YearMonth)+'01')),
              summary.FactNetTotalMoneyAmount,
              summary.FactTotalCollectedMoneyAmount,
              -- previous month
              summary2.FactNetTotalMoneyAmount,
              summary2.FactTotalCollectedMoneyAmount,
              -- rolling 3 month average
              avg(summary3.FactNetTotalMoneyAmount),
              AVG(summary3.FactTotalCollectedMoneyAmount)
       FROM -- retrieve previous month
       dbo.SquareLocationSummariesStaging summary
       LEFT OUTER JOIN dbo.SquareLocationSummariesStaging summary2 ON(summary.LocationBusinessName = summary2.LocationBusinessName)
                                                                     AND (CONVERT( DATETIME, (CONVERT(VARCHAR, summary.YearMonth)+'01')) = DATEADD(month, 1, CONVERT(DATETIME, (CONVERT(VARCHAR, summary2.YearMonth)+'01')))) -- rolling 3 months
       LEFT OUTER JOIN dbo.SquareLocationSummariesStaging summary3 ON((summary.LocationBusinessName = summary3.LocationBusinessName)
                                                                      AND (CONVERT(DATETIME, (CONVERT(VARCHAR, summary.YearMonth)+'01'))) BETWEEN DATEADD(month, -3, CONVERT(DATETIME, (CONVERT(VARCHAR, summary3.YearMonth)+'01'))) AND(CONVERT(DATETIME, (CONVERT(VARCHAR, summary3.YearMonth)+'01'))))
       GROUP BY summary.LocationBusinessName,
                summary.YearMonth,
                CONVERT( DATETIME, (CONVERT(VARCHAR, summary.YearMonth)+'01')),
                summary.FactNetTotalMoneyAmount,
                summary.FactTotalCollectedMoneyAmount,
                -- previous month
                summary2.FactNetTotalMoneyAmount,
                summary2.FactTotalCollectedMoneyAmount
       ORDER BY LocationBusinessName,
                YearMonth;