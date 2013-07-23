Title: Hardkodowe poprawki w SharePoint 2010
Autor: Mateusz Świetlicki
CreateDate: 2010-08-2 12:26
Tags: 	Blog
		PL
		SharePoint

Napiszę tu pewnie kiedyś kilka słów wstępu. Teraz jednak przejdę odrazu to rzeczy.

Aby dokonać zmian w bazie danych sharepointa trzeba się tam na początek dostać.

Zainstalować SQL Management Studio

![SQL Management Studio](/files/sql_managament.png)

Dalej gdy będzie taka możliwość wybieramy nową instancję, ponieważ nie można rozszerzyć istniejącej.

Następnie w ekranie połączania wpisać:

- \\.\pipe\mssql$microsoft##ssee\sql\query (dla WSS 3.0 lub SP 2007)
- \\.\pipe\mssql$sharepoint\sql\quer lub <servername>\sharepoint (dla  SP 2010)

Autentykacja niech zostanie na “Windows”.

Możecie też potrzebować wyszukać konkretnego tekstu w bazię. Powinna pomóc tak funkcja:

```sql
CREATE PROCEDURE FindMyData_String 
    @DataToFind NVARCHAR(4000), 
    @ExactMatch BIT = 0 
AS
SET NOCOUNT ON
   
DECLARE @Temp TABLE(RowId INT IDENTITY(1,1), SchemaName sysname, TableName sysname, ColumnName SysName, DataType VARCHAR(100), DataFound BIT) 
   
    INSERT  INTO @Temp(TableName,SchemaName, ColumnName, DataType) 
    SELECT  C.Table_Name,C.TABLE_SCHEMA, C.Column_Name, C.Data_Type 
    FROM    Information_Schema.Columns AS C 
            INNER Join Information_Schema.Tables AS T 
                ON C.Table_Name = T.Table_Name 
        AND C.TABLE_SCHEMA = T.TABLE_SCHEMA 
    WHERE   Table_Type = 'Base Table'
            And Data_Type In ('ntext','text','nvarchar','nchar','varchar','char') 
   
   
DECLARE @i INT
DECLARE @MAX INT
DECLARE @TableName sysname 
DECLARE @ColumnName sysname 
DECLARE @SchemaName sysname 
DECLARE @SQL NVARCHAR(4000) 
DECLARE @PARAMETERS NVARCHAR(4000) 
DECLARE @DataExists BIT
DECLARE @SQLTemplate NVARCHAR(4000) 
   
SELECT  @SQLTemplate = CASE WHEN @ExactMatch = 1 
                            THEN 'If Exists(Select * 
                                          From   ReplaceTableName 
                                          Where  Convert(nVarChar(4000), [ReplaceColumnName]) 
                                                       = ''' + @DataToFind + ''' 
                                          ) 
                                     Set @DataExists = 1 
                                 Else 
                                     Set @DataExists = 0'
                            ELSE 'If Exists(Select * 
                                          From   ReplaceTableName 
                                          Where  Convert(nVarChar(4000), [ReplaceColumnName]) 
                                                       Like ''%' + @DataToFind + '%'' 
                                          ) 
                                     Set @DataExists = 1 
                                 Else 
                                     Set @DataExists = 0'
                            END, 
        @PARAMETERS = '@DataExists Bit OUTPUT', 
        @i = 1 
   
SELECT @i = 1, @MAX = MAX(RowId) 
FROM   @Temp
   
WHILE @i <= @MAX
    BEGIN
        SELECT  @SQL = REPLACE(REPLACE(@SQLTemplate, 'ReplaceTableName', QUOTENAME(SchemaName) + '.' + QUOTENAME(TableName)), 'ReplaceColumnName', ColumnName) 
        FROM    @Temp
        WHERE   RowId = @i 
   
   
        PRINT @SQL 
        EXEC SP_EXECUTESQL @SQL, @PARAMETERS, @DataExists = @DataExists OUTPUT
   
        IF @DataExists =1 
            UPDATE @Temp SET DataFound = 1 WHERE RowId = @i 
   
        SET @i = @i + 1 
    END
   
SELECT  SchemaName,TableName, ColumnName 
FROM    @Temp
WHERE   DataFound = 1 
GO
```

I wywołanie:

```sql
EXEC FindMyData_string 'microsoft', 0
```
Więcej o szukaniu można znaleźć na <http://blogs.lessthandot.com/index.php/DataMgmt/DataDesign/the-ten-most-asked-sql-server-questions--1>