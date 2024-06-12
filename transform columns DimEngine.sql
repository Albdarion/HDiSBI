SELECT
	ID,
	CASE
		WHEN a3.a1pos = 0 THEN a3.HP_or_lbs_thr_ea_engine
		WHEN a3.a2pos = 0 THEN SUBSTRING(a3.HP_or_lbs_thr_ea_engine, 1, a3.a1pos - 1) + a3.substr
		ELSE SUBSTRING(a3.HP_or_lbs_thr_ea_engine, 1, a3.a1pos - 1)
	END as EngineThrust
FROM
	(SELECT
		ID,
		a2.HP_or_lbs_thr_ea_engine,
		a2.a1pos,
		a2.substr,
		PATINDEX('%[^0123456789]%', a2.substr) as a2pos
	FROM
		(SELECT
			ID,
			HP_or_lbs_thr_ea_engine,
			a1.pos as a1pos,
			SUBSTRING(HP_or_lbs_thr_ea_engine, a1.pos + 1, LEN(HP_or_lbs_thr_ea_engine) - a1.pos + 1) as substr
		FROM 
			(SELECT
				ID,
				HP_or_lbs_thr_ea_engine,
				PATINDEX('%[^0123456789]%', HP_or_lbs_thr_ea_engine) as pos
			FROM
				Technical_Airplane_Pricing) AS a1) AS a2) AS a3

