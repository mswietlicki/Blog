

Adding column if not exist
--------------------------

```sql
IF COL_LENGTH('[dbo].[TableName]','ServicePartnerType') IS NULL
BEGIN 
	ALTER TABLE [dbo].[TableName]
		ADD ServicePartnerType NVARCHAR(255) NULL
END
```