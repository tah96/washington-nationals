DROP TABLE IF EXISTS parkfactors_lov;

CREATE TABLE parkfactors_lov (
    "year" int   NOT NULL,
    "team" varchar(2)   NOT NULL,
    "basic" int   NOT NULL,
    "park1B" int   NOT NULL,
    "park2B" int   NOT NULL,
    "park3B" int   NOT NULL,
    "parkHR" int   NOT NULL,
    "parkSO" int   NOT NULL,
    "parkBB" int   NOT NULL,
    "parkGB" int   NOT NULL,
    "parkFB" int   NOT NULL,
    "parkLD" int   NOT NULL,
    "parkIFPP" int   NOT NULL,
    "parkFIP" int   NOT NULL,
    CONSTRAINT "pk_ParkFactors_LOV" PRIMARY KEY (
        "year","team"
     )
);