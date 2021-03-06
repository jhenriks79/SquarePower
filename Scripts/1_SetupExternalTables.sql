CREATE DATABASE SCOPED CREDENTIAL AzureStorageCredentialSquarePoc
WITH 
    IDENTITY = 'user', 
    SECRET = '<YOUR AZURE STORAGE KEY>';

CREATE EXTERNAL DATA SOURCE AzureStorageSquarePoc
WITH (  
    TYPE = Hadoop, 
    LOCATION = '<YOUR AZURE STORAGE ACCOUNT>',
    CREDENTIAL = AzureStorageCredentialSquarePoc
);

CREATE EXTERNAL FILE FORMAT TextFilePipe
WITH (
    FORMAT_TYPE = DelimitedText, 
    FORMAT_OPTIONS (
		FIELD_TERMINATOR = '|'
	)
);

CREATE EXTERNAL FILE FORMAT TextFilePipeWithStringDelim
WITH (
    FORMAT_TYPE = DelimitedText, 
    FORMAT_OPTIONS (
		FIELD_TERMINATOR = '|',
		STRING_DELIMITER = '"'
		)
);

CREATE EXTERNAL FILE FORMAT TextFileComma
WITH (
    FORMAT_TYPE = DelimitedText, 
    FORMAT_OPTIONS (FIELD_TERMINATOR = ',')
);