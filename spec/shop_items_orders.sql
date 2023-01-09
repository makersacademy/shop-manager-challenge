DROP TABLE IF EXISTS "public"."items";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS items_id_seq;

-- Table Definition

CREATE TABLE "public"."items" (
  "id" SERIAL,
  "item_name" text,
  "unit_price" int,
  "item_quantity" int,
  PRIMARY KEY ("id")
);

DROP TABLE IF EXISTS "public"."items_orders";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Table Definition
CREATE TABLE "public"."items_orders" (
    "item_id" int4,
    "customer_name" text,
    "order_id" int4
);

DROP TABLE IF EXISTS "public"."orders";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS orders_id_seq;

-- Table Definition
CREATE TABLE "public"."orders" (
    "id" SERIAL,
    "customer_name" text,
    "order_date" date,
    PRIMARY KEY ("id")
);

INSERT INTO "public"."items" ("id", "item_name", "unit_price", "item_quantity") VALUES
(1, 'Super Shark Vacuum Cleaner', '99', '30'),
(2, 'Makerspresso Coffee Machine', '69', '15'),
(3, 'Bush Smart HD TV', '75', '10'),
(4, 'Bosh Food Processor', '60', '20'),
(5, 'Nutribullet Juicer', '80', '30'),
(6, 'Bush Smart HD TV', '75', '10');

INSERT INTO "public"."items_orders" ("item_id", "order_id") VALUES
(1, 001),
(2, 002),
(3, 003),
(4, 004),
(5, 001),
(6, 001);

INSERT INTO "public"."orders" ("id", "customer_name", "order_date") VALUES
 (1, 'Ana', '01/01/2023'),
 (2, 'Sam', '02/01/2023'),
 (3, 'Jane', '03/01/2023'),
 (4, 'Carol', '04/01/2023');

ALTER TABLE "public"."items_orders" ADD FOREIGN KEY ("order_id") REFERENCES "public"."orders"("id");
ALTER TABLE "public"."items_orders" ADD FOREIGN KEY ("item_id") REFERENCES "public"."items"("id");