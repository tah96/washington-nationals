SELECT
	tm."teamLeague",
	ROUND(CAST(SUM(ltps."oppEarnRuns")/(SUM(FLOOR(ltps."innPitch")*3 + ROUND(CAST(ltps."innPitch" - FLOOR(ltps."innPitch") as numeric),1)*10)/3)*9 as numeric),2)
FROM league_team_pitch_stats as ltps
INNER JOIN team as tm
	ON ltps."teamID" = tm."teamID"
GROUP BY tm."teamLeague";