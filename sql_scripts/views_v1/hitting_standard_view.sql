SELECT
	hs."playerID",
	plyr."teamID",
	SUM(hs."pPlateApp") as "pPlateApps",
	SUM(hs."pAtBats") as "pAtBats"
FROM hitting_stats AS hs
INNER JOIN player as plyr
	ON hs."playerID" = plyr."playerID"
GROUP BY hs."playerID",plyr."teamID"
ORDER BY CAST(plyr."teamID" as INT) DESC
;

--Something seems off with At Bats calculation