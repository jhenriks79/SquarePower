IF(OBJECT_ID('dbo.SquareLocationSummariesStaging') IS NOT NULL)
    BEGIN
        DROP TABLE dbo.SquareLocationSummariesStaging;
    END;
GO

IF OBJECT_ID( 'dbo.SquareItemizationsMaster' ) IS NOT NULL
BEGIN
    DROP TABLE dbo.SquareItemizationsMaster;
END;
GO

IF OBJECT_ID( 'dbo.SquareItemizations' ) IS NOT NULL
BEGIN
    DROP EXTERNAL TABLE dbo.SquareItemizations;
END;
GO

IF OBJECT_ID( 'dbo.SquarePaymentsMaster' ) IS NOT NULL
BEGIN
    DROP TABLE dbo.SquarePaymentsMaster;
END;
GO

IF OBJECT_ID( 'dbo.SquarePayments' ) IS NOT NULL
BEGIN
    DROP EXTERNAL TABLE dbo.SquarePayments;
END;
GO

IF(OBJECT_ID('AzureStorageSquarePoc') IS NOT NULL)
    BEGIN
		DROP EXTERNAL DATA SOURCE AzureStorageSquarePoc;
    END;
GO

IF(OBJECT_ID('TextFilePipe') IS NOT NULL)
    BEGIN
		DROP EXTERNAL FILE FORMAT TextFilePipe;
    END;
GO

IF(OBJECT_ID('TextFilePipeWithStringDelim') IS NOT NULL)
    BEGIN
		DROP EXTERNAL FILE FORMAT TextFilePipeWithStringDelim;
    END;
GO

IF(OBJECT_ID('TextFileComma') IS NOT NULL)
    BEGIN
		DROP EXTERNAL FILE FORMAT TextFileComma;
    END;
GO

IF(OBJECT_ID('AzureStorageCredentialSquarePoc') IS NOT NULL)
    BEGIN
		DROP DATABASE SCOPED CREDENTIAL AzureStorageCredentialSquarePoc;
    END;
GO