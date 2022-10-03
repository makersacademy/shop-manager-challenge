DROP TABLE IF EXISTS "public"."stocks";

CREATE SEQUENCE IF NOT EXISTS stocks_id_seq;

CREATE TABLE "public"."stocks" (
    "id" SERIAL PRIMARY KEY,
    "name" text,
    "price" int, 
    "quantity" int
    );

DROP TABLE IF EXISTS "public"."stocks_orders";

CREATE TABLE "public"."stocks_orders" (
    "stock_id" int4,
    "order_id" int4
    );

DROP TABLE IF EXISTS "public"."orders";

CREATE SEQUENCE IF NOT EXISTS orders_id_seq;

CREATE TABLE "public"."orders" (
    "id" SERIAL PRIMARY KEY,
    "name" text,
    "order_number" int,
    "date" DATE
    );


INSERT INTO "public"."stocks" ("id", "name", "price", "quantity") VALUES
(1, 'Super Shark Vacuum Cleaner', '99', '30'),
(2, 'Makerspresso Coffee Machine', '69', '15 ');


INSERT INTO "public"."stocks_orders" ("stock_id", "order_id") VALUES
(1, 1),
(2, 2);

INSERT INTO "public"."orders" ("id", "name", "order_number", "date") VALUES
(1, 'Blake ODonnell', '1', '2022-10-02'),
(2, 'John Smith', '2', '2022-10-02');

ALTER TABLE "public"."stocks_orders" ADD FOREIGN KEY ("order_id") REFERENCES "public"."orders"("id");
ALTER TABLE "public"."stocks_orders" ADD FOREIGN KEY ("stock_id") REFERENCES "public"."stocks"("id");