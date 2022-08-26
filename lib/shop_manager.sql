DROP TABLE IF EXISTS "public"."items";

CREATE SEQUENCE IF NOT EXISTS items_id_seq;

CREATE TABLE "public"."items" (
    "id" SERIAL,
    "name" text,
    "unit_price" int,
    "quantity" int,
    PRIMARY KEY ("id")
);

DROP TABLE IF EXISTS "public"."items_orders";

-- Table Definition
CREATE TABLE "public"."items_orders" (
    "item_id" int4,
    "order_id" int4
);

DROP TABLE IF EXISTS "public"."orders";

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS orders_id_seq;

-- Table Definition
CREATE TABLE "public"."orders" (
    "id" SERIAL,
    "customer_name" text,
    "date" date,
    PRIMARY KEY ("id")
);

INSERT INTO items (name, unit_price, quantity) VALUES 
('iPhone', 20, 5),
('iPad', 50, 2),
('Shiny toothpaste', 10, 2),
('BMW', 90, 4);

INSERT INTO orders (customer_name, date) VALUES 
('Penaldo', '2022-03-01'),
('Penzema', '2022-03-01'),
('Messi', '2022-03-01');

INSERT INTO "public"."items_orders" ("item_id", "order_id") VALUES
(1, 1),
(2, 1),
(3, 1),
(2, 3);

ALTER TABLE "public"."items_orders" ADD FOREIGN KEY ("item_id") REFERENCES "public"."orders"("id") ON DELETE CASCADE;
ALTER TABLE "public"."items_orders" ADD FOREIGN KEY ("order_id") REFERENCES "public"."items"("id") ON DELETE CASCADE;