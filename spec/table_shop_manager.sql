-- -------------------------------------------------------------
-- TablePlus 5.1.2(472)
--
-- https://tableplus.com/
--
-- Database: shop_manager
-- Generation Time: 2023-01-09 16:08:50.3990
-- -------------------------------------------------------------


DROP TABLE IF EXISTS "public"."orders";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.


DROP TABLE IF EXISTS "public"."items";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS items_id_seq;

-- Table Definition
CREATE TABLE "public"."items" (
    "id" SERIAL,
    "name" text,
    "unit_price" int4,
    "quantity" int4,
    PRIMARY KEY ("id")
);


INSERT INTO "public"."items" ("name", "unit_price", "quantity") VALUES
('Super Shark Vacuum Cleaner', 99, 30),
('Makerspresso Coffee Machine', 69, 15),
('Kettle', 50, 25),
('Cooker', 200, 10),
('Mug', 20, 2);




-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS orders_id_seq;

-- Table Definition
CREATE TABLE "public"."orders" (
    id SERIAL PRIMARY KEY,
    "customer_name" text,
    "date" date,
    "item_id" int4,
    constraint fk_item foreign key(item_id)
    references items(id)
    on delete cascade

);

INSERT INTO "public"."orders" ("customer_name", "date", "item_id") VALUES
('John', '01/01/2023' , 2),
('Emily', '02/01/2023', 5),
('Joseph', '03/01/2023', 1),
('Anne', '04/01/2023', 3),
('Benjamin', '05/01/2023', 4);



