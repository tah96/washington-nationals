SELECT
	tm."teamLeague",
	ROUND(CAST(SUM(ltps."oppEarnRuns")/(SUM(FLOOR(ltps."innPitch")*3 + ROUND(CAST(ltps."innPitch" - FLOOR(ltps."innPitch") as numeric),1)*10)/3)*9 as numeric),2) as lg_era,
	ROUND(CAST((((SUM(ltps."oppHomeRuns")*13 + SUM(ltps."oppBB" + ltps."oppHBP")*3 - SUM(ltps."pStrikeouts")*2) /(SUM(FLOOR(ltps."innPitch")*3 + ROUND(CAST(ltps."innPitch" - FLOOR(ltps."innPitch") as numeric),1)*10)/3)) + 3.169)as numeric),2) as lg_fip
FROM league_team_pitch_stats as ltps
INNER JOIN team as tm
	ON ltps."teamID" = tm."teamID"
GROUP BY tm."teamLeague"
;