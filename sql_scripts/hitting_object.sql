DROP TABLE public.hitting_stats;

CREATE TABLE public.hitting_stats
(
    "gameID" character varying(255) COLLATE pg_catalog."default" NOT NULL,
    "playerID" character varying(10) COLLATE pg_catalog."default" NOT NULL,
    "playerPos" character varying(10) COLLATE pg_catalog."default" NOT NULL,
	"pAtBats" integer NOT NULL,
	"pRuns" integer NOT NULL,
	"pHits" integer NOT NULL,
    "pRBI" integer NOT NULL,
	"pBB" integer NOT NULL,
    "pStrikeouts" integer NOT NULL,
	"pPlateApps" integer NOT NULL,
    "p2B" integer NOT NULL,
    "p3B" integer NOT NULL,
    "pHR" integer NOT NULL,
    "pTB" integer NOT NULL,
	"pHBP" integer NOT NULL,
    "pIntBB" integer NOT NULL,
    "pSF" integer NOT NULL,
    CONSTRAINT "pk_Hitting_Stats" PRIMARY KEY ("gameID", "playerID"),
    CONSTRAINT "fk_Hitting_Stats_gameID" FOREIGN KEY ("gameID")
        REFERENCES public.game ("gameID") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "fk_Hitting_Stats_playerID" FOREIGN KEY ("playerID")
        REFERENCES public.player ("playerID") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE public.hitting_stats
    OWNER to postgres;