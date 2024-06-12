SELECT
	x.ID,
	CASE
		WHEN CHARINDEX(',', Location, x.pos + 1) != 0 THEN TRIM(SUBSTRING(Location, CHARINDEX(',', Location, x.pos + 1) + 1, LEN(Location) - CHARINDEX(',', Location, x.pos + 1)))
		WHEN x.pos != 0 THEN TRIM(SUBSTRING(Location, x.pos + 1, LEN(Location) - x.pos))
		ELSE TRIM(Location)
	END
FROM
	(SELECT
		ID,
		[Location],
		CHARINDEX(',', Location) AS pos
	FROM
		[HISBI].[dbo].[Airplane_Crashes]) x