﻿/*
 S4m backup script. 
 Thank you for used.
 */
 CREATE PROC [dbo].[ZZ_BACKUPSCRIPT](
	@DB_PATH NVARCHAR(100)
)
AS
BEGIN
	CREATE TABLE #TABLE(
		SIRA INT,
		DB_ADI NVARCHAR(100),
		DURUM CHAR(20),
		BACKUP_YOLU NVARCHAR(100)
	) 
	DECLARE @DB_id INT = (SELECT COUNT(*) FROM sys.databases)
	DECLARE @SAYAC INT = 1
	DECLARE @DB_NAME NVARCHAR(100)
	DECLARE @QUERY NVARCHAR(MAX)

	WHILE @SAYAC <= @DB_id
		BEGIN
			SET @DB_NAME = (SELECT name FROM sys.databases WHERE database_id = @SAYAC)
			SET @QUERY = 'BACKUP DATABASE '+@DB_NAME+' TO DISK='''+@DB_PATH+@DB_NAME+'.bak'''
			IF @DB_NAME <> 'tempdb'
			BEGIN
				EXECUTE sp_Executesql  @QUERY
				INSERT INTO #TABLE (SIRA,DB_ADI,DURUM,BACKUP_YOLU) VALUES (@SAYAC, @DB_NAME, 'OLUŞTURULDU',@DB_PATH)
			END
			SET @SAYAC = @SAYAC +1
		END;
	SELECT * FROM #TABLE
END

