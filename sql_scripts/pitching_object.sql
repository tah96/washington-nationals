DROP TABLE IF EXISTS pitching_stats;

CREATE TABLE pitching_stats (
    "gameID" varchar(255)   NOT NULL,
    "playerID" varchar(10)   NOT NULL,
    "spFlag" int   NOT NULL,
    "pInnPit" float   NOT NULL,
    "oppHits" int   NOT NULL,
    "oppRuns" int   NOT NULL,
    "oppEarnRuns" int   NOT NULL,
    "oppBB" int   NOT NULL,
    "oppStrikeouts" int   NOT NULL,
    "oppHR" int   NOT NULL,
    "pitchesThrown" int   NOT NULL,
    "strikesThrown" int   NOT NULL,
    "oppGB" int   NOT NULL,
    "oppFB" int   NOT NULL,
    "oppLD" int   NOT NULL,
    "wpa" float   NOT NULL,
    "cwpa" varchar(255)   NOT NULL,
    "oppHBP" int   NOT NULL,
    "oppIBB" int   NOT NULL,
    "winFlag" int   NOT NULL,
    "lossFlag" int   NOT NULL,
    "holdFlag" int   NOT NULL,
    "saveFlag" int   NOT NULL,
    "blownSaveFlag" int   NOT NULL,
    CONSTRAINT "pk_Pitching_Stats" PRIMARY KEY (
        "gameID","playerID"
     )
);