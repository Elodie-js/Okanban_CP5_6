/* Première table : List */

-- On démarre une transaction afin de s'assurer de la cohérence gloabale de la BDD
BEGIN;

--  on supprime les table 'si elle existe"
DROP TABLE IF EXISTS "list", "card", "tag", "card_has_tag";

CREATE TABLE "list" (
  "id" SERIAL PRIMARY KEY,
  "name" TEXT NOT NULL DEFAULT '',
  "position" INTEGER NOT NULL DEFAULT 0,
 
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  "updated_at" TIMESTAMPTZ
);


/* 2ème table : Card */

CREATE TABLE "card" (
  "id" SERIAL PRIMARY KEY,
  "content" TEXT NOT NULL DEFAULT '',
  "color" TEXT NOT NULL DEFAULT '#FFF', 
  
  "list_id" INTEGER NOT NULL REFERENCES list("id") ON DELETE CASCADE,
  "position" INTEGER NOT NULL DEFAULT 0,
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  "updated_at" TIMESTAMPTZ
);

/* 3ème table : Tag */

CREATE TABLE "tag" (
  "id" SERIAL PRIMARY KEY,
  "name" TEXT NOT NULL DEFAULT '',
  "color" TEXT NOT NULL DEFAULT '#FFF' ,
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  "updated_at" TIMESTAMPTZ
);

/*  table de liaison ! */

CREATE TABLE "card_has_tag" (
  "id" SERIAL PRIMARY KEY,
  
  "card_id" INTEGER NOT NULL REFERENCES card("id") ON DELETE CASCADE,
  "tag_id" INTEGER NOT NULL REFERENCES tag("id") ON DELETE CASCADE,
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW()
);


INSERT INTO "list" ("name")
VALUES ('Première liste' );

INSERT INTO "card" ("content", "color", "list_id")
VALUES ('Carte 1', '#FF00FF', 1), -- id 1
       ('2ème carte', '#c1e7ff', 1); -- id 2

INSERT INTO "tag" ("name", "color")
VALUES ('Urgent', '#F00'); -- id 1

INSERT INTO "card_has_tag" ("card_id", "tag_id")
VALUES (1,1); -- Carte 1, Urgent

COMMIT;

