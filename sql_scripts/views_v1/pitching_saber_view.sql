SELECT
	pgam.*,
	ROUND(100*(pgam."era"+(pgam."era"-(pgam."era"*pfac."basic"/100)))/ lgera."lg_era",2) as era_minus,
	ROUND(100*(pgam."fip"+(pgam."fip"-(pgam."fip"*pfac."basic"/100)))/ lgera."lg_fip",2) as fip_minus
FROM
	(SELECT
		ps."playerID",
		SUM(ps."spFlag") as games_started,
		COUNT(ps."playerID") as games_appear,
		ROUND(CAST(SUM(FLOOR(ps."pInnPit")*3 + ROUND(CAST(ps."pInnPit" - FLOOR(ps."pInnPit") as numeric),1)*10)/3 as numeric),2) as p_Inn_Pitch,
		CASE
			WHEN SUM(ps."oppEarnRuns") > 0 THEN ROUND(CAST(SUM(ps."oppEarnRuns")/(SUM(FLOOR(ps."pInnPit")*3 + ROUND(CAST(ps."pInnPit" - FLOOR(ps."pInnPit") as numeric),1)*10)/3)*9 as numeric),2) 
			WHEN SUM(ps."oppEarnRuns") = 0 THEN 0.00
		END as era,
		ROUND(CAST((((SUM(ps."oppHR")*13 + SUM(ps."oppBB" + ps."oppHBP")*3 - SUM(ps."oppStrikeouts")*2) /(SUM(FLOOR(ps."pInnPit")*3 + ROUND(CAST(ps."pInnPit" - FLOOR(ps."pInnPit") as numeric),1)*10)/3)) + 3.169)as numeric),2) as fip,
		ROUND((CAST(SUM(ps."oppGB") as numeric) / CAST(SUM(ps."oppGB" + ps."oppFB") as numeric)),4)  as gbper,
		ROUND((CAST(SUM(ps."oppFB"-ps."oppLD") as numeric) / CAST(SUM(ps."oppGB" + ps."oppFB") as numeric)),4)  as fbper,
		ROUND((CAST(SUM(ps."oppLD") as numeric) / CAST(SUM(ps."oppGB" + ps."oppFB") as numeric)),4)  as ldper,
		COUNT(*) FILTER (WHERE ps."spFlag" != 1 AND ps."wpa" > 0.06) AS shutdowns,
		COUNT(*) FILTER (WHERE ps."spFlag" != 1 AND ps."wpa" < -0.06) AS meltdowns,
		ROUND(CAST(SUM(ps."wpa")as numeric),2) as wpa,
		ROUND(SUM(CAST(RTRIM(ps."cwpa",'%')as numeric)),2) as cwpa,
		-- ERA- = (ERA+(ERA - (ERAxPF))x100)/(AL or NL ERA)
		plyr."teamID"
	FROM pitching_stats as ps
	INNER JOIN player as plyr
		ON ps."playerID" = plyr."playerID"
	JOIN game as gm
		ON ps."gameID" = gm."gameID"
		JOIN saberconst_lov as sbr
			ON gm."gameYear" = sbr."year"
	GROUP BY ps."playerID", plyr."teamID") as pgam,
	(SELECT
		basic
	FROM parkfactors_lov
	WHERE team = '30') as pfac,
	(SELECT
		tm."teamLeague",
		ROUND(CAST(SUM(ltps."oppEarnRuns")/(SUM(FLOOR(ltps."innPitch")*3 + ROUND(CAST(ltps."innPitch" - FLOOR(ltps."innPitch") as numeric),1)*10)/3)*9 as numeric),2) as lg_era,
	 	ROUND(CAST((((SUM(ltps."oppHomeRuns")*13 + SUM(ltps."oppBB" + ltps."oppHBP")*3 - SUM(ltps."pStrikeouts")*2) /(SUM(FLOOR(ltps."innPitch")*3 + ROUND(CAST(ltps."innPitch" - FLOOR(ltps."innPitch") as numeric),1)*10)/3)) + 3.169)as numeric),2) as lg_fip
	FROM league_team_pitch_stats as ltps
	INNER JOIN team as tm
		ON ltps."teamID" = tm."teamID"
	WHERE tm."teamLeague" = 'NL'
	GROUP BY tm."teamLeague") as lgera
	
--In future there should be a joins statement for team, league and player to adjust for era dynamically
--	instead of hardcording.

--Need to figure out how to get FIP Constant from 2021 into calculations
;