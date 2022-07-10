
-- TRUNCATE TABLE items RESTART IDENTITY CASCADE; 

DROP TABLE IF EXISTS "public"."items" CASCADE;
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
-- CREATE SEQUENCE IF NOT EXISTS orders_id_seq;

-- Table Definition
CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name text,
  price money,
  quantity int
);

-- TRUNCATE TABLE orders RESTART IDENTITY CASCADE; 
-- Sequence and defined type

DROP TABLE IF EXISTS "public"."orders" CASCADE;
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- CREATE SEQUENCE IF NOT EXISTS orders_id_seq;

-- Table Definition
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer text,
  date date
);

-- TRUNCATE TABLE items_orders RESTART IDENTITY; 

DROP TABLE IF EXISTS "public"."items_orders" CASCADE;
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Create the join table.
CREATE TABLE items_orders (
  item_id int,
  order_id int,
  constraint fk_item foreign key(item_id) references items(id),
  constraint fk_order foreign key(order_id) references orders(id),
  PRIMARY KEY (item_id, order_id)
);

INSERT INTO items (name, price, quantity) VALUES
('milk', 1, 35),
('cheese', 3.50, 55),
('bread', 2.75, 10),
('6 eggs', 2.33, 28),
('orange juice', 1.30, 20);

INSERT INTO orders (customer, date) VALUES
('Anna', '2022-06-21'),
('John', '2022-06-23'),
('Rachel', '2022-07-01');

INSERT INTO items_orders (item_id , order_id) VALUES
( 1, 1),
( 1, 2),
( 1, 3),
( 2, 1),
( 3, 2),
( 3, 3),
( 4, 2),
( 4, 3),
( 5, 1),
( 5, 2),
( 5, 3);