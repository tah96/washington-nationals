SELECT
	ps."playerID",
	SUM(ps."spFlag") as games_started,
	COUNT(ps."playerID") as games_appear,
	SUM(FLOOR(ps."pInnPit")*3 + ROUND(CAST(ps."pInnPit" - FLOOR(ps."pInnPit") as numeric),1)*10)/3 as p_Inn_Pitch,
	CASE
		WHEN SUM(ps."oppEarnRuns") > 0 THEN ROUND(CAST(SUM(ps."oppEarnRuns")/(SUM(FLOOR(ps."pInnPit")*3 + ROUND(CAST(ps."pInnPit" - FLOOR(ps."pInnPit") as numeric),1)*10)/3)*9 as numeric),2) 
		WHEN SUM(ps."oppEarnRuns") = 0 THEN 0.00
	END as era,
	--((13*HR)+(3*(BB+HBP))-(2*K))/IP + constant
	(((SUM(ps."oppHR")*13 + SUM(ps."oppBB" + ps."oppHBP")*3 - SUM(ps."oppStrikeouts")*2) /(SUM(FLOOR(ps."pInnPit")*3 + ROUND(CAST(ps."pInnPit" - FLOOR(ps."pInnPit") as numeric),1)*10)/3)) + 3.169) as fip,
	SUM(ps."oppGB") as gb,
	SUM(ps."oppFB") as fb,
	SUM(ps."oppLD") as ld,
	ROUND((CAST(SUM(ps."oppGB") as numeric) / CAST(SUM(ps."oppGB" + ps."oppFB" + ps."oppLD") as numeric)),4)  as gbper,
	ROUND((CAST(SUM(ps."oppFB") as numeric) / CAST(SUM(ps."oppGB" + ps."oppFB" + ps."oppLD") as numeric)),4)  as fbper,
	ROUND((CAST(SUM(ps."oppLD") as numeric) / CAST(SUM(ps."oppGB" + ps."oppFB" + ps."oppLD") as numeric)),4)  as ldper,
	plyr."teamID"
FROM pitching_stats as ps
INNER JOIN player as plyr
	ON ps."playerID" = plyr."playerID"
JOIN game as gm
	ON ps."gameID" = gm."gameID"
	JOIN saberconst_lov as sbr
		ON gm."gameYear" = sbr."year"
GROUP BY ps."playerID", plyr."teamID"
;