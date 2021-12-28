CREATE VIEW pitching_standard_szn AS
	SELECT
		ps."playerID",
		SUM(ps."winFlag") as wins,
		SUM(ps."lossFlag") as losses,
		SUM(ps."holdFlag") as holds,
		SUM(ps."saveFlag") as saves,
		SUM(ps."blownSaveFlag") as blown_saves,
		SUM(ps."spFlag") as games_started,
		COUNT(ps."playerID") as games_appear,
		SUM(FLOOR(ps."pInnPit")*3 + ROUND(CAST(ps."pInnPit" - FLOOR(ps."pInnPit") as numeric),1)*10)/3 as p_Inn_Pitch,
		(SUM(ps."oppHits"))/(SUM(FLOOR(ps."pInnPit")*3 + ROUND(CAST(ps."pInnPit" - FLOOR(ps."pInnPit") as numeric),1)*10)/3)*9 as hits_9,
		(SUM(ps."oppHR"))/(SUM(FLOOR(ps."pInnPit")*3 + ROUND(CAST(ps."pInnPit" - FLOOR(ps."pInnPit") as numeric),1)*10)/3)*9 as homeRuns_9,
		(SUM(ps."oppBB"))/(SUM(FLOOR(ps."pInnPit")*3 + ROUND(CAST(ps."pInnPit" - FLOOR(ps."pInnPit") as numeric),1)*10)/3)*9 as walks_9,
		(SUM(ps."oppStrikeouts"))/(SUM(FLOOR(ps."pInnPit")*3 + ROUND(CAST(ps."pInnPit" - FLOOR(ps."pInnPit") as numeric),1)*10)/3)*9 as strikeouts_9,
		(SUM(ps."oppRuns"))/(SUM(FLOOR(ps."pInnPit")*3 + ROUND(CAST(ps."pInnPit" - FLOOR(ps."pInnPit") as numeric),1)*10)/3)*9 as runs_9,
		CASE 
		  WHEN SUM(ps."oppEarnRuns") > 0 THEN ROUND(CAST(SUM(ps."oppEarnRuns")/(SUM(FLOOR(ps."pInnPit")*3 + ROUND(CAST(ps."pInnPit" - FLOOR(ps."pInnPit") as numeric),1)*10)/3)*9 as numeric),2) 
		  WHEN SUM(ps."oppEarnRuns") = 0 THEN 0.00
		END as era,
		(SUM(ps."oppHits")+SUM(ps."oppBB"))/(SUM(FLOOR(ps."pInnPit")*3 + ROUND(CAST(ps."pInnPit" - FLOOR(ps."pInnPit") as numeric),1)*10)/3) as whip,
		plyr."teamID"
	FROM pitching_stats AS ps
	INNER JOIN player as plyr
		ON ps."playerID" = plyr."playerID"
	GROUP BY ps."playerID", plyr."teamID"
	ORDER BY games_appear DESC
	;