select Logger.IMEI, Logger.Description, client_description, Sims.Tel_No, Sims.Status, Max(LoggerConfig.LogDate) AS 'Last Update' 
from LoggerConfig
INNER JOIN Logger ON LoggerConfig.IMEI = Logger.IMEI
INNER JOIN Sims ON Logger.Installed_Sim = Sims.Id
 where LogDate > '2022-03-07 06:00'
 GROUP BY Logger.Description, client_description, Logger.IMEI, Sims.Tel_No, Sims.Status
 ORDER BY Logger.Description
