SELECT
	hs."playerID",
	plyr."teamID",
	SUM(hs."pPlateApps") as "pPlateApps",
	SUM(hs."pAtBats") as "pAtBats",
	SUM(hs."pHits") as "pHits",
	SUM(hs."pStrikeouts") as "pStrikeouts",
	SUM(hs."pBB") as "pBBs",
	SUM(hs."pRuns") as "pRuns",
	(SUM(hs."pHits") - SUM(hs."p2B" + hs."p3B" + hs."pHR")) as "pSingles",
	SUM(hs."p2B") as "pDoubles",
	SUM(hs."p3B") as "pTriples",
	SUM(hs."pHR") as "pHomeRuns",
	SUM(hs."pTB") as "pTotalBases",
	SUM(hs."pSF") as "pSacFlys",
	SUM(hs."pHBP") as "pHBPs",
	SUM(hs."pIntBB") as "pIBBs",
	ROUND(CAST(SUM(hs."pHits")as numeric)/CAST(SUM(hs."pAtBats")as numeric),3) as "pBatAvg",
	ROUND(CAST(SUM(hs."pTB")as numeric)/CAST(SUM(hs."pAtBats")as numeric),3) as "pSlugPer",
	ROUND(CAST(SUM(hs."pHits" + hs."pBB" + hs."pHBP")as numeric)/CAST(SUM(hs."pPlateApps")as numeric),3) as "pOBP"
FROM hitting_stats AS hs
INNER JOIN player as plyr
	ON hs."playerID" = plyr."playerID"
GROUP BY hs."playerID",plyr."teamID"
ORDER BY CAST(plyr."teamID" as INT) DESC
;

--Issue where games in which player hit more than 1 of an XBH is not counting in appropriate column. Example: May 14, Jun 6 and Jul 5 for Victor Robles.
--April 10, July 16 and July 19 examples for games where Juan Soto hit more than 1 HR in a game.
--