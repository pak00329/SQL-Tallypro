DECLARE @WHERE AS VARCHAR(50)
SET @WHERE = 'Northmead'
	
SELECT Total.Date, Total.Total, 
	Col1.Total AS Northmead1, 
	Col2.Total AS Northmead2, 
	Col3.Total AS Northmead3, 
	Col4.Total AS Northmead4, 
	Col5.Total AS Northmead5, 
	Col6.Total AS Northmead6, 
	Col7.Total AS Northmead7
	FROM	
	(
	SELECT 
	substring(CONVERT(VARCHAR,No_Dups.DateTime,120), 1, 10) as Date,
	(sum(No_Dups.Battery) + sum(No_Dups.Voltage))/2 as 'Total'
	
	FROM No_Dups 
	INNER JOIN Logger ON No_Dups.IMEI = Logger.IMEI
	WHERE Logger.Customer = @WHERE AND 
	Logger.SiteId IN (1,2,3,4,5,6,7)AND
	DateTime <= GETDATE()
	GROUP BY substring(CONVERT(VARCHAR,No_Dups.DateTime,120), 1, 10)
	) AS Total
	LEFT OUTER JOIN 
	(
	SELECT 
	substring(CONVERT(VARCHAR,No_Dups.DateTime,120), 1, 10) as Date,
	(sum(No_Dups.Battery) + sum(No_Dups.Voltage))/2 as 'Total'
	
	FROM No_Dups 
	INNER JOIN Logger ON No_Dups.IMEI = Logger.IMEI
	WHERE Logger.Customer = @WHERE AND 
	Logger.SiteId = 1 AND
	DateTime <= GETDATE()
	GROUP BY substring(CONVERT(VARCHAR,No_Dups.DateTime,120), 1, 10)
	) AS Col1 ON Total.Date = Col1.Date
	LEFT OUTER JOIN 
	(
	SELECT 
	substring(CONVERT(VARCHAR,No_Dups.DateTime,120), 1, 10) as Date,
	(sum(No_Dups.Battery) + sum(No_Dups.Voltage))/2 as 'Total'
	
	FROM No_Dups 
	INNER JOIN Logger ON No_Dups.IMEI = Logger.IMEI
	WHERE Logger.Customer = @WHERE AND 
	Logger.SiteId = 2 AND
	DateTime <= GETDATE()
	GROUP BY substring(CONVERT(VARCHAR,No_Dups.DateTime,120), 1, 10)
	) AS Col2 ON Total.Date = Col2.Date
	LEFT OUTER JOIN 
	(
	SELECT 
	substring(CONVERT(VARCHAR,No_Dups.DateTime,120), 1, 10) as Date,
	(sum(No_Dups.Battery) + sum(No_Dups.Voltage))/2 as 'Total'
	
	FROM No_Dups 
	INNER JOIN Logger ON No_Dups.IMEI = Logger.IMEI
	WHERE Logger.Customer = @WHERE AND 
	Logger.SiteId = 3 AND
	DateTime <= GETDATE()
	GROUP BY substring(CONVERT(VARCHAR,No_Dups.DateTime,120), 1, 10)
	) AS Col3 ON Total.Date = Col3.Date
	LEFT OUTER JOIN 
	(
	SELECT 
	substring(CONVERT(VARCHAR,No_Dups.DateTime,120), 1, 10) as Date,
	(sum(No_Dups.Battery) + sum(No_Dups.Voltage))/2 as 'Total'
	
	FROM No_Dups 
	INNER JOIN Logger ON No_Dups.IMEI = Logger.IMEI
	WHERE Logger.Customer = @WHERE AND 
	Logger.SiteId = 4 AND
	DateTime <= GETDATE()
	GROUP BY substring(CONVERT(VARCHAR,No_Dups.DateTime,120), 1, 10)
	) AS Col4 ON Total.Date = Col4.Date
	LEFT OUTER JOIN 
	(
	SELECT 
	substring(CONVERT(VARCHAR,No_Dups.DateTime,120), 1, 10) as Date,
	(sum(No_Dups.Battery) + sum(No_Dups.Voltage))/2 as 'Total'
	
	FROM No_Dups 
	INNER JOIN Logger ON No_Dups.IMEI = Logger.IMEI
	WHERE Logger.Customer = @WHERE AND 
	Logger.SiteId = 5 AND
	DateTime <= GETDATE()
	GROUP BY substring(CONVERT(VARCHAR,No_Dups.DateTime,120), 1, 10)
	) AS Col5 ON Total.Date = Col5.Date
	LEFT OUTER JOIN 
	(
	SELECT 
	substring(CONVERT(VARCHAR,No_Dups.DateTime,120), 1, 10) as Date,
	(sum(No_Dups.Battery) + sum(No_Dups.Voltage))/2 as 'Total'
	
	FROM No_Dups 
	INNER JOIN Logger ON No_Dups.IMEI = Logger.IMEI
	WHERE Logger.Customer = @WHERE AND 
	Logger.SiteId = 6 AND
	DateTime <= GETDATE()
	GROUP BY substring(CONVERT(VARCHAR,No_Dups.DateTime,120), 1, 10)
	) AS Col6 ON Total.Date = Col6.Date
	LEFT OUTER JOIN 
	(
	SELECT 
	substring(CONVERT(VARCHAR,No_Dups.DateTime,120), 1, 10) as Date,
	(sum(No_Dups.Battery) + sum(No_Dups.Voltage))/2 as 'Total'
	
	FROM No_Dups 
	INNER JOIN Logger ON No_Dups.IMEI = Logger.IMEI
	WHERE Logger.Customer = @WHERE AND 
	Logger.SiteId = 7 AND
	DateTime <= GETDATE()
	GROUP BY substring(CONVERT(VARCHAR,No_Dups.DateTime,120), 1, 10)
	) AS Col7 ON Total.Date = Col7.Date
	
ORDER BY Date
