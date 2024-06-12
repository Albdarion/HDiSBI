SELECT
	ID,
	CASE
		WHEN a3.a1pos = 0 THEN a3.HP_or_lbs_thr_ea_engine
		WHEN a3.a2pos = 0 THEN SUBSTRING(a3.HP_or_lbs_thr_ea_engine, 1, a3.a1pos - 1) + a3.substr
		ELSE SUBSTRING(a3.HP_or_lbs_thr_ea_engine, 1, a3.a1pos - 1)
	END as EngineThrust,
	MaxSpeed,
	WingsSpan,
	Length,
	AllRateOfClimb,
	Landing
FROM
	(SELECT
		ID,
		a2.HP_or_lbs_thr_ea_engine,
		a2.a1pos,
		a2.substr,
		PATINDEX('%[^0123456789]%', a2.substr) as a2pos,
		MaxSpeed,
		WingsSpan,
		Length,
		AllRateOfClimb,
		Landing
	FROM
		(SELECT
			ID,
			HP_or_lbs_thr_ea_engine,
			a1.pos as a1pos,
			SUBSTRING(HP_or_lbs_thr_ea_engine, a1.pos + 1, LEN(HP_or_lbs_thr_ea_engine) - a1.pos + 1) as substr,
			a1.MaxSpeed,
			CASE
				WHEN a1.wingsPos = 0 THEN a1.Wing_span_ft_in
				ELSE CAST(SUBSTRING(a1.Wing_span_ft_in, 1, a1.wingsPos - 1) AS INT) * 12 + CAST(SUBSTRING(a1.Wing_span_ft_in, a1.wingsPos + 1, LEN(a1.Wing_span_ft_in) - a1.wingsPos) AS INT)
			END AS WingsSpan,
			CASE
				WHEN a1.lengthPos = 0 THEN a1.Length_ft_in
				ELSE CAST(SUBSTRING(a1.Length_ft_in, 1, a1.lengthPos - 1) AS INT) * 12 + CAST(SUBSTRING(a1.Length_ft_in, a1.lengthPos + 1, LEN(a1.Length_ft_in) - a1.lengthPos) AS INT)
			END AS Length,
			CASE
				WHEN a1.AllEngPos = 0 THEN REPLACE(TRANSLATE(a1.All_eng_rate_of_climb, ',', SPACE(1)), ' ', '')
				ELSE REPLACE(TRANSLATE(SUBSTRING(a1.All_eng_rate_of_climb, 1, a1.AllEngPos), ',', SPACE(1)), ' ', '')
			END as AllRateOfClimb,
			CASE
				WHEN a1.Landing_over_50ft = '' THEN NULL
				ELSE a1.Landing_over_50ft
			END as Landing
		FROM 
			(SELECT
				ID,
				HP_or_lbs_thr_ea_engine,
				PATINDEX('%[^0123456789]%', HP_or_lbs_thr_ea_engine) as pos,
				REPLACE(TRANSLATE(Max_speed_Knots, 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ,.', SPACE(54)), ' ', '') as MaxSpeed,
				CASE
					WHEN PATINDEX('%[^0123456789/]%', Wing_span_ft_in) != 0 THEN NULL
					ELSE Wing_span_ft_in
				END AS Wing_span_ft_in,
				PATINDEX('%[/.]%', Wing_span_ft_in) as wingsPos,
				CASE
					WHEN PATINDEX('%[^0123456789/]%', Length_ft_in) != 0 THEN NULL
					ELSE Length_ft_in
				END AS Length_ft_in,
				PATINDEX('%[/.]%', Length_ft_in) as lengthPos,
				All_eng_rate_of_climb,
				CHARINDEX(' ', All_eng_rate_of_climb) as AllEngPos,
				REPLACE(TRANSLATE(Landing_over_50ft, 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ,.', SPACE(54)), ' ', '') AS Landing_over_50ft
			FROM
				Technical_Airplane_Pricing) AS a1) AS a2) AS a3