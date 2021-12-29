SELECT
	ps."playerID",
	COUNT(*) FILTER (WHERE ps."spFlag" != 1 AND ps."wpa" > 0.06) AS shutdowns,
	COUNT(*) FILTER (WHERE ps."spFlag" != 1 AND ps."wpa" < -0.06) AS meltdowns
FROM pitching_stats as ps
GROUP BY ps."playerID"
ORDER BY shutdowns DESC
;