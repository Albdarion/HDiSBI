SELECT
	ID,
	a._year + a._month + a._day as ActualDate
FROM
	(SELECT
		ID,
		CAST(YEAR(Date) AS varchar) as _year,
		CASE
			WHEN MONTH(Date) < 10 THEN '0' + CAST(MONTH(Date) AS varchar)
			ELSE CAST(MONTH(Date) AS varchar)
		END as _month,
		CASE
			WHEN DAY(Date) < 10 THEN '0' + CAST(DAY(Date) AS varchar)
			ELSE CAST(DAY(Date) AS varchar)
		END as _day
	FROM
		Airplane_Crashes) AS a;


SELECT
	ac.ID,
	dpm.ModelKey
FROM
	(SELECT
		*,
		CAST(RAND(ROW_NUMBER() OVER (ORDER BY (SELECT 1)) * (SELECT COUNT(*) FROM HISBI_dwh.dbo.DimPlaneModel) ) * (SELECT COUNT(*) FROM HISBI_dwh.dbo.DimPlaneModel) AS BIGINT) randid
	FROM
		HISBI.dbo.Airplane_Crashes) as ac
JOIN (SELECT
		ModelKey,
		CAST(ROW_NUMBER() OVER (ORDER BY (SELECT 1)) AS BIGINT) AS number
	FROM
		HISBI_dwh.dbo.DimPlaneModel) as dpm ON dpm.number = ac.randid;


SELECT
	ID,
	CAST(Operator AS varchar(50)) as Operator,
	CASE
		WHEN Aboard = 'NULL' THEN NULL
		ELSE CAST(Aboard as int)
	END as Aboard,
	CASE
		WHEN Aboard_Passangers = 'NULL' THEN NULL
		ELSE CAST(Aboard_Passangers as int)
	END as Aboard_Passangers,
	CASE
		WHEN Aboard_Crew = 'NULL' THEN NULL
		ELSE CAST(Aboard_Crew as int)
	END as Aboard_Crew,
	CASE
		WHEN Fatalities = 'NULL' THEN NULL
		ELSE CAST(Fatalities as int)
	END as Fatalities,
	CASE
		WHEN Fatalities_Passangers = 'NULL' THEN NULL
		ELSE CAST(Fatalities_Passangers as int)
	END as Fatalities_Passangers,
	CASE
		WHEN Fatalities_Crew = 'NULL' THEN NULL
		ELSE CAST(Fatalities_Crew as int)
	END as Fatalities_Crew,
	CASE
		WHEN Ground = 'NULL' THEN NULL
		ELSE CAST(Ground as bit)
	END as Ground
FROM
	Airplane_Crashes;