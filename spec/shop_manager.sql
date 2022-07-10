DROP TABLE IF EXISTS "public"."items" CASCADE; 

CREATE SEQUENCE IF NOT EXISTS items_id_seq;

CREATE TABLE "public"."items" (
  "id" SERIAL PRIMARY KEY,
  "item_name" text,
  "price" money,
  "quantity" int
);

INSERT INTO "public"."items" ("id", "item_name", "price", "quantity") VALUES
(1, 'Carrot Cake', 30, 2),
(2, 'Apple Cake', 34.50, 3),
(3, 'Chocolate Cake', 38, 1);

-----------------------------------------------------------------------------------

DROP TABLE IF EXISTS orders CASCADE;

CREATE SEQUENCE IF NOT EXISTS orders_id_seq;

CREATE TABLE orders (
  "id" SERIAL PRIMARY KEY,
  "customer_name" text,
  "date" date
);

INSERT INTO orders ("id", "customer_name", "date") VALUES
(1, 'Ana', '2022-06-08'),
(2, 'Maria', '2022-07-07'),
(3, 'Jon', '2022-09-09'),
(4, 'Tom', '2022-08-09'),
(5, 'Tay', '2022-02-02'),
(6, 'Iz', '2022-03-10');


DROP TABLE IF EXISTS items_orders CASCADE;
-- CREATE SEQUENCE IF NOT EXISTS items_orders_id_seq;

CREATE TABLE items_orders (
  item_id int,
  order_id int,
  constraint fk_item foreign key(item_id) references items(id),
  constraint fk_order foreign key(order_id) references orders(id),
  PRIMARY KEY (item_id, order_id)
);

INSERT INTO items_orders ("item_id", "order_id") VALUES
(1, 1),
(1, 2),
(2, 3),
(3, 2);
