-- createing database
CREATE database aravind;
----------------------------------------------------------------------

-- before creating database scop cred , create database master key
CREATE MASTER KEY ENCRYPTION BY
PASSWORD = 'Ai@304491';

----------------------------------------------------------------------------------------------------------------------------------------------------------
--- before careating external data source , give credential to access data continer 
CREATE DATABASE SCOPED CREDENTIAL databasecred1
WITH 
IDENTITY = 'SHARED ACCESS SIGNATURE',
SECRET = 'sp=rl&st=2024-06-30T05:26:43Z&se=2024-06-30T13:26:43Z&spr=https&sv=2022-11-02&sr=c&sig=%2BB2VNKCkRFnGtbSKsAN%2FuACM04Xjki9nLd0nK5wOks0%3D'

-------------------------------------------------------------------------------------------------------------------------------------------------------- --

--- creating storage source for azure datalake  
CREATE EXTERNAL DATA SOURCE extdatasource2
WITH(
    LOCATION = 'https://aa4491synapsstorage.blob.core.windows.net/csv', --- location for continer
    CREDENTIAL = databasecred1
);

------------------------------------------------------------------------------------------------------------

-- create external file formate for csv/parquet/json,etc,,,,.,

CREATE EXTERNAL FILE FORMAT csvfileformate
WITH(
    FORMAT_TYPE = DELIMITEDTEXT,
    FORMAT_OPTIONS(
        FIELD_TERMINATOR = ',',
        FIRST_ROW = 2 --first row as header
    )
);

----------------------------------------------------------------------------------------

-- creating external serverless table(Built-in serverless pool)

CREATE EXTERNAL TABLE aravindlogdata1
(
    [CorrelationId] NVARCHAR(36),
    [OperationName] NVARCHAR(255),
    [Status] NVARCHAR(50),
    [EventCategory] NVARCHAR(50),
    [Level] NVARCHAR(50),
    [Time] DATETIME2,
    [Subscription] NVARCHAR(50),
    [EventInitiatedBy] NVARCHAR(255),
    [ResourceType] NVARCHAR(255),
    [ResourceGroup] NVARCHAR(255),
    [Resource] NVARCHAR(500)
)
WITH(
    LOCATION = 'Log.csv', --file name
    DATA_SOURCE = extdatasource2,
    FILE_FORMAT = csvfileformate
);



SELECT * FROM aravindlogdata1;





 


