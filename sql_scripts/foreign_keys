ALTER TABLE game ADD CONSTRAINT "fk_Game_gameYear" FOREIGN KEY("gameYear")
REFERENCES saberconst_lov ("year");

ALTER TABLE parkfactors_lov ADD CONSTRAINT "fk_parkfactors_team" FOREIGN KEY("team")
REFERENCES team ("teamID");

CONSTRAINT FK_BandMember_Band FOREIGN KEY (BandId) REFERENCES Band(BandId),

ALTER TABLE player ADD CONSTRAINT "fk_Player_teamID" FOREIGN KEY("teamID")
REFERENCES team ("teamID");

ALTER TABLE pitching_stats ADD CONSTRAINT "fk_Pitching_Stats_gameID" FOREIGN KEY("gameID")
REFERENCES game ("gameID");

ALTER TABLE pitching_stats ADD CONSTRAINT "fk_Pitching_Stats_playerID" FOREIGN KEY("playerID")
REFERENCES player ("playerID");

ALTER TABLE hitting_stats ADD CONSTRAINT "fk_Hitting_Stats_gameID" FOREIGN KEY("gameID")
REFERENCES game ("gameID");

ALTER TABLE hitting_stats ADD CONSTRAINT "fk_Hitting_Stats_playerID" FOREIGN KEY("playerID")
REFERENCES player ("playerID");