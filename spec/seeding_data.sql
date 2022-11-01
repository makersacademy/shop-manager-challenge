
DROP TABLE IF EXISTS "public"."stock_items" CASCADE; --fine with warnings
--CREATE SEQUENCE IF NOT EXISTS stock_items_id_seq; -- already created
CREATE TABLE "public"."stock_items" (
    "id" SERIAL,
    "item_name" text,
    "unit_price" int,
    "stock_level" int,
    PRIMARY KEY ("id")); --fine



DROP TABLE IF EXISTS "public"."stock_items_orders"; --fine
CREATE TABLE "public"."stock_items_orders" (
    "stock_item_id" int4,
    "order_id" int4),
    constraint fk_customer_order foreign key(order_id)
    references customer_orders(id)
    on delete cascade);  --fine




DROP TABLE IF EXISTS "public"."customer_orders" CASCADE; -- fine
-- CREATE SEQUENCE IF NOT EXISTS customer_orders_id_seq; -- already created
CREATE TABLE "public"."customer_orders" (
"id" SERIAL,
"customer_name" TEXT,
"order_date" DATE,
PRIMARY KEY("id")); --fine




DROP TABLE IF EXISTS "public"."orders"; --fine
--CREATE SEQUENCE IF NOT EXISTS orders_id_seq; --already created
CREATE TABLE "public"."orders" (
    "id" SERIAL,
    "customer_order_id" int,
    "stock_item_ordered_id" int,
    "stock_item_ordered_qty" int,
    PRIMARY KEY ("id"),
    constraint fk_customer_order foreign key(customer_order_id)
    references customer_orders(id)
    on delete cascade); --fine




INSERT INTO "public"."stock_items" ("id", "item_name", "unit_price", "stock_level") VALUES
(1, 'Dummy item', 45, 20); --fine

INSERT INTO "public"."stock_items_orders" ("stock_item_id", "order_id") VALUES
(1, 1); --fine

INSERT INTO "public"."customer_orders" ("id", "customer_name", "order_date") VALUES
(100, 'Jeff Jeffson', '1900-01-01'); --fine

INSERT INTO "public"."orders" ("id", "customer_order_id", "stock_item_ordered_qty", "stock_item_ordered_id") VALUES
(1, 100, 7, 1); -- fine



ALTER TABLE "public"."stock_items_orders" ADD FOREIGN KEY ("stock_item_id") REFERENCES "public"."stock_items"("id") ON DELETE CASCADE; --fine
ALTER TABLE "public"."stock_items_orders" ADD FOREIGN KEY ("order_id") REFERENCES "public"."orders"("id") ON DELETE CASCADE; --fine
