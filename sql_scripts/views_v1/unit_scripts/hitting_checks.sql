--June 20 solved

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