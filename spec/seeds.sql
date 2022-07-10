DROP TABLE IF EXISTS "public"."items" CASCADE; 

CREATE SEQUENCE IF NOT EXISTS items_id_seq;

CREATE TABLE "public"."items" (
  id SERIAL PRIMARY KEY,
  name text,
  price decimal(6,2),
  quantity int
);

INSERT INTO "public"."items" ("id", "name", "price", "quantity") VALUES
(1, 'item1', 23.763, 23),
(2, 'item2', 12.135, 45),
(3, 'item3', 384.38, 27);

-----------------------------------------------------------------------------------

DROP TABLE IF EXISTS orders CASCADE;

CREATE SEQUENCE IF NOT EXISTS orders_id_seq;

CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer text,
  date date,
-- The foreign key name is always {other_table_singular}_id
  item_id int,
  constraint fk_item foreign key(item_id) references items(id)
);

INSERT INTO orders ("id", "customer", "date", "item_id") VALUES
(1, 'name1', '2022-07-9', 1),
(2, 'name2', '2022-07-10', 2),
(3, 'name3', '2022-07-11', 3);

