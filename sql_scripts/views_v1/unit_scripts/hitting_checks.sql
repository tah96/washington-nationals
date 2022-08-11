--June 20, July 23, May 11, May 9, June 8, Sept 10 G,  June 19 G, July 1 G, June 15 G, April 27 G, May 13 G, May 9 G

SELECT *
FROM hitting_stats as hs2
WHERE hs2."gameID" IN (
	SELECT sq1."gameID"
	FROM (
		SELECT
			COUNT(*) as num_players,
			hs1."gameID"
		FROM hitting_stats as hs1
		GROUP BY hs1."gameID"
	) as sq1
	WHERE sq1.num_players = 9
);