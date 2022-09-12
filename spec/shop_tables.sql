/*
CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name text,
  unit_price int4,
  quantity int4
);


CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name text,
  order_date date,
  item_id int,
  constraint fk_item foreign key(item_id)
    references items(id)
    on delete cascade);

*/

DROP TABLE IF EXISTS "public"."items";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS items_id_seq;

-- Table Definition
CREATE TABLE "public"."items" (
    "id" SERIAL,
    "name" text,
    "unit_price" int,
    "quantity" int,
    PRIMARY KEY ("id")
);

DROP TABLE IF EXISTS "public"."items_orders";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Table Definition
CREATE TABLE "public"."items_orders" (
    "item_id" int,
    "order_id" int
);

DROP TABLE IF EXISTS "public"."orders";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS orders_id_seq;

-- Table Definition
CREATE TABLE "public"."orders" (
    "id" SERIAL,
    "customer_name" text,
    "date" date,
    PRIMARY KEY ("id")
);

INSERT INTO "public"."items" ("id", "name", "unit_price", "quantity") VALUES
(1, 'shark vacuum', 50, 100),
(2, 'carrot spiralizer', 8, 23),
(3, 'nut peeler', 3, 10),
(4, 'ball shaver', 35, 16),
(5, 'ball waxer', 12, 155);

INSERT INTO "public"."items_orders" ("item_id", "order_id") VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 2),
(5, 2),
(1, 3),
(1, 4),
(3, 4),
(3, 5),
(4, 5),
(5, 6),
(4, 6),
(3, 6),
(2, 7),
(4, 7),
(4, 8),
(1, 9),
(1, 10),
(3, 10),
(5, 10),
(5, 11);

INSERT INTO "public"."orders" ("id", "customer_name", "order_date") VALUES
(1, 'Roy Bofter', '2022-10-02'),
(2, 'James Lamppe', '2022-10-03'),
(3, 'Ziggy Dufresne', '2022-08-22'),
(4, 'Lips McKenzie', '2022-11-12'),
(5, 'Doberman Fancy', '2022-10-10'),
(6, 'Djembe Djones', '2022-05-19'),
(7, 'Hardswipe Lepht', '2022-02-28'),
(8, 'Fan Bang', '2022-06-13'),
(9, 'Princess Michael Of Kunt', '2022-12-01'),
(10, 'Tim Bifter', '2022-12-12'),
(11, 'Hodja Hauses', '2022-03-10');

ALTER TABLE "public"."items_orders" ADD FOREIGN KEY ("order_id") REFERENCES "public"."orders"("id");
ALTER TABLE "public"."items_orders" ADD FOREIGN KEY ("item_id") REFERENCES "public"."items"("id");