DECLARE @StartDate As DateTime = '2022-02-01'
DECLARE @EndDate As DateTime = '2022-02-'
DECLARE @Mall As VARCHAR(50) = 'Northmead' -- name of mall to compare
DECLARE @First_Entrance As INT = 1 --1st entrance to compare 
DECLARE @Second_Entrance As INT = 3 --2nd entrance to compare

DECLARE @Daily_Ratio AS FLOAT = 0 
DECLARE @IMEI AS VARCHAR(50) = (SELECT IMEI FROM Logger WHERE Customer = 'Northmead' AND SiteId = 4) --we are adjusting this entrance
DECLARE @Ratio_00 AS FLOAT = 0.6
DECLARE @Ratio_01 AS FLOAT = 0.4
DECLARE @Ratio_02 AS FLOAT = 0.4
DECLARE @Ratio_03 AS FLOAT = 0.2
DECLARE @Ratio_04 AS FLOAT = 0.5
DECLARE @Ratio_05 AS FLOAT = 0.77
DECLARE @Ratio_06 AS FLOAT = 1.5
DECLARE @Ratio_07 AS FLOAT = 3.3
DECLARE @Ratio_08 AS FLOAT = 6.75
DECLARE @Ratio_09 AS FLOAT = 8.08
DECLARE @Ratio_10 AS FLOAT = 7.3
DECLARE @Ratio_11 AS FLOAT = 8.7
DECLARE @Ratio_12 AS FLOAT = 10.2
DECLARE @Ratio_13 AS FLOAT = 9.8
DECLARE @Ratio_14 AS FLOAT = 8.9
DECLARE @Ratio_15 AS FLOAT = 8.3
DECLARE @Ratio_16 AS FLOAT = 9.5
DECLARE @Ratio_17 AS FLOAT = 7
DECLARE @Ratio_18 AS FLOAT = 4.3
DECLARE @Ratio_19 AS FLOAT = 1.2
DECLARE @Ratio_20 AS FLOAT = 0.6
DECLARE @Ratio_21 AS FLOAT = 0.4
DECLARE @Ratio_22 AS FLOAT = 0.3
DECLARE @Ratio_23 AS FLOAT = 0.3

--**********************************************************************************
--Calculate the ratio between entrances over the last 3 months.
SET @Daily_Ratio = (SELECT CAST((
SELECT (sum(No_Dups.Battery) + sum(No_Dups.Voltage))/2
FROM No_Dups 
INNER JOIN Logger ON No_Dups.IMEI = Logger.IMEI
WHERE Logger.IMEI = @IMEI AND
	substring(CONVERT(VARCHAR,No_Dups.DateTime,120), 1, 7) 
		BETWEEN substring(CONVERT(VARCHAR,DATEADD(MONTH, -3, @EndDate),120), 1, 7)  
		AND substring(CONVERT(VARCHAR,DATEADD(MONTH, -1, @EndDate),120), 1, 7) 
)AS FLOAT)
/
CAST((
SELECT (sum(No_Dups.Battery) + sum(No_Dups.Voltage))/2
FROM No_Dups 
INNER JOIN Logger ON No_Dups.IMEI = Logger.IMEI
WHERE Logger.Customer = @Mall AND Logger.SiteId IN (@First_Entrance, @Second_Entrance) AND
	substring(CONVERT(VARCHAR,No_Dups.DateTime,120), 1, 7) 
		BETWEEN substring(CONVERT(VARCHAR,DATEADD(MONTH, -3, GETDATE()),120), 1, 7)  
		AND substring(CONVERT(VARCHAR,DATEADD(MONTH, -1, GETDATE()),120), 1, 7) 
)AS FLOAT))
--***********************************************************************************

DECLARE @DayTotal AS FLOAT = 0
DECLARE @Days AS INT = DATEDIFF(Day, @StartDate, @EndDate) + 1
Declare @Hour AS INT = 0


WHILE @EndDate >= @StartDate	
	BEGIN
	SET @DayTotal = (
		SELECT (sum(No_Dups.Battery) + sum(No_Dups.Voltage))/2
		FROM No_Dups 
		INNER JOIN Logger ON No_Dups.IMEI = Logger.IMEI
		WHERE Logger.Customer = @Mall AND Logger.SiteId IN (@First_Entrance, @Second_Entrance) AND 
		substring(CONVERT(VARCHAR,No_Dups.DateTime,120), 1, 10) = @StartDate
		) * @Daily_Ratio * (RAND()/10+1)
		
	SET @Hour = 0
	WHILE @Hour < 24
		BEGIN
		INSERT INTO LoggerData (IMEI, SessionId, MemLoc, DateTime, Battery, Voltage)
		VALUES (@IMEI, 0, 0,		
			DATEADD(Hour,@Hour,@StartDate),  @DayTotal /100 * 
			CASE @Hour
				WHEN 0 THEN @Ratio_00
				WHEN 1 THEN @Ratio_01
				WHEN 2 THEN @Ratio_02
				WHEN 3 THEN @Ratio_03
				WHEN 4 THEN @Ratio_04
				WHEN 5 THEN @Ratio_05
				WHEN 6 THEN @Ratio_06
				WHEN 7 THEN @Ratio_07
				WHEN 8 THEN @Ratio_08
				WHEN 9 THEN @Ratio_09
				WHEN 10 THEN @Ratio_10
				WHEN 11 THEN @Ratio_11
				WHEN 12 THEN @Ratio_12
				WHEN 13 THEN @Ratio_13
				WHEN 14 THEN @Ratio_14
				WHEN 15 THEN @Ratio_15
				WHEN 16 THEN @Ratio_16
				WHEN 17 THEN @Ratio_17
				WHEN 18 THEN @Ratio_18
				WHEN 19 THEN @Ratio_19
				WHEN 20 THEN @Ratio_20
				WHEN 21 THEN @Ratio_21
				WHEN 22 THEN @Ratio_22
				WHEN 23 THEN @Ratio_23
				END,
		@DayTotal /100 * 
			CASE @Hour
				WHEN 0 THEN @Ratio_00
				WHEN 1 THEN @Ratio_01
				WHEN 2 THEN @Ratio_02
				WHEN 3 THEN @Ratio_03
				WHEN 4 THEN @Ratio_04
				WHEN 5 THEN @Ratio_05
				WHEN 6 THEN @Ratio_06
				WHEN 7 THEN @Ratio_07
				WHEN 8 THEN @Ratio_08
				WHEN 9 THEN @Ratio_09
				WHEN 10 THEN @Ratio_10
				WHEN 11 THEN @Ratio_11
				WHEN 12 THEN @Ratio_12
				WHEN 13 THEN @Ratio_13
				WHEN 14 THEN @Ratio_14
				WHEN 15 THEN @Ratio_15
				WHEN 16 THEN @Ratio_16
				WHEN 17 THEN @Ratio_17
				WHEN 18 THEN @Ratio_18
				WHEN 19 THEN @Ratio_19
				WHEN 20 THEN @Ratio_20
				WHEN 21 THEN @Ratio_21
				WHEN 22 THEN @Ratio_22
				WHEN 23 THEN @Ratio_23
				END)
		SET @Hour = @Hour + 1
		END
	SET @StartDate = DATEADD(day,1,@StartDate)
END

