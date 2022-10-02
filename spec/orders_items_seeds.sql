
DROP TABLE IF EXISTS "public"."orders";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS orders_id_seq;

-- Table Definition
CREATE TABLE "public"."orders" (
    "id" SERIAL PRIMARY KEY,
    "order_number" int,
    "customer_name" text,
    "order_date" DATE
);

DROP TABLE IF EXISTS "public"."orders_items";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Table Definition
CREATE TABLE "public"."orders_items" (
    "order_id" int4,
    "item_id" int4
);

DROP TABLE IF EXISTS "public"."items";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS items_id_seq;

-- Table Definition
CREATE TABLE "public"."items" (
  "id" SERIAL PRIMARY KEY,
  "item_name" text,
  "price" int,
  "quantity" int
);

INSERT INTO "public"."orders" ("id", "order_number", "customer_name", "order_date") VALUES
(1, 1, 'Joe Bloggs', '2022-10-02'),
(2, 2, 'John Doe', '2022-10-01'),
(3, 3, 'John Doe', '2022-09-15');

INSERT INTO "public"."orders_items" ("order_id", "item_id") VALUES
(1, 1),
(2, 2),
(3, 1);


INSERT INTO "public"."items" ("id", "item_name", "price", "quantity") VALUES
(1, 'MacBook', '1000', '13'),
(2, 'HDMI Cable - 1M', '10', '7'),
(3, 'HDMI Cable - 3M', '12', '16');

ALTER TABLE "public"."orders_items" ADD FOREIGN KEY ("item_id") REFERENCES "public"."items"("id");
ALTER TABLE "public"."orders_items" ADD FOREIGN KEY ("order_id") REFERENCES "public"."orders"("id");