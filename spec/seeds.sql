-- items

DROP TABLE IF EXISTS "public"."items";

CREATE SEQUENCE IF NOT EXISTS items_id_seq;

CREATE TABLE "public"."items" (
    "id" SERIAL,
    "name" text,
    "unitprice" text,
    "quantity" text,
    PRIMARY KEY ("id")
);

INSERT INTO "public"."items" ("name", "unitprice", "quantity") VALUES
('Super Shark Vacuum Cleaner', 99, 30),
('Makerspresso Coffee Machine', 69, 15);

-- orders

DROP TABLE IF EXISTS "public"."orders";

CREATE SEQUENCE IF NOT EXISTS orders_id_seq;

CREATE TABLE "public"."orders" (
    "id" SERIAL,
    "item" int,
    "customername" text,
    "date" text,
    PRIMARY KEY ("id")
);

INSERT INTO "public"."orders" ("item", "customername", "date") VALUES
(1, 'John Doe', '1666117807');