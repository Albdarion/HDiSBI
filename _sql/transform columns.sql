SELECT 
	ID,
	CASE
		WHEN Total_Hours = Engine_1_Hours THEN 1
		ELSE 0
	END AS OriginalEngine,
	CASE
		WHEN Total_Hours = Prop_1_Hours THEN 1
		ELSE 0
	END AS OriginalProp,
	CASE
		WHEN Engine_1_Hours = NULL THEN 0
		WHEN PATINDEX('%[^0123456789]%', Engine_1_Hours) = 0 THEN Engine_1_Hours
		ELSE SUBSTRING(Engine_1_Hours, 1, PATINDEX('%[^0123456789]%', Engine_1_Hours) - 1)
	END AS Engine1InUse,
	CASE
		WHEN Engine_2_Hours = NULL THEN 0
		WHEN PATINDEX('%[^0123456789]%', Engine_2_Hours) = 0 THEN Engine_2_Hours
		ELSE SUBSTRING(Engine_2_Hours, 1, PATINDEX('%[^0123456789]%', Engine_2_Hours) - 1)
	END AS Engine2InUse,
	CASE
		WHEN Prop_1_Hours = NULL THEN 0
		WHEN PATINDEX('%[^0123456789]%', Prop_1_Hours) = 0 THEN Prop_1_Hours
		ELSE SUBSTRING(Prop_1_Hours, 1, PATINDEX('%[^0123456789]%', Prop_1_Hours) - 1)
	END AS Prop1InUse,
	CASE
		WHEN Prop_2_Hours = NULL THEN 0
		WHEN PATINDEX('%[^0123456789]%', Prop_2_Hours) = 0 THEN Prop_2_Hours
		ELSE SUBSTRING(Prop_2_Hours, 1, PATINDEX('%[^0123456789]%', Prop_2_Hours) - 1)
	END AS Prop2InUse,
	CASE
		WHEN Total_Hours = NULL THEN 0
		WHEN PATINDEX('%[^0123456789]%', Total_Hours) = 0 THEN Total_Hours
		ELSE SUBSTRING(Total_Hours, 1, PATINDEX('%[^0123456789]%', Total_Hours) - 1)
	END AS TotalInUse,
	CASE
		WHEN Year = '-' OR Year = 'Not Listed' THEN NULL
		ELSE CAST(Year AS BIGINT)
	END AS ProductionYear
FROM
	General_Aircraft_Pricing;

SELECT DISTINCT
	Year
FROM
	General_Aircraft_Pricing;

select
	CAST(REPLACE(TRANSLATE(SUBSTRING(Price, PATINDEX('%[0123456789]%', Price), LEN(Price) - PATINDEX('%[0123456789]%', Price) + 1), 'qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM.,', SPACE(54)), ' ', '') AS FLOAT) AS ActualPrice
from
	General_Aircraft_Pricing;

