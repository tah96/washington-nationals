--CREATE OR REPLACE VIEW public.hitting_saber_szn
-- AS

SELECT
	hs."playerID",
	plyr."teamID",
	SUM(hs."pPlateApps") as "pPlateApps",
	SUM(hs."pAtBats") as "pAtBats",
	SUM(hs."pBB") as "pBBs",
	SUM(hs."pStrikeouts") as "pStrikeouts",
	CASE
		WHEN SUM(hs."pPlateApps") > 0 THEN ROUND(CAST((SUM(hs."pBB")/SUM(hs."pPlateApps")) as numeric),2)
		ELSE 0.0
	END AS "BB%"
	/* SUM(hs."pHits") as "pHits",
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
	*/
FROM hitting_stats AS hs
INNER JOIN player as plyr
	ON hs."playerID" = plyr."playerID"
GROUP BY hs."playerID",plyr."teamID"
ORDER BY CAST(plyr."teamID" as INT) DESC 

--ALTER TABLE public.hitting_saber_szn
--    OWNER TO postgres;

