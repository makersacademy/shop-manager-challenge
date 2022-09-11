-- DROP TABLE items, orders; -- to use in case of issues/over iterations

-- CREATE TABLE items (
--   id SERIAL PRIMARY KEY,
--   name text,
--   unit_price numeric,
--   stock_quantity int);

-- CREATE TABLE orders (
--   id SERIAL PRIMARY KEY,
--   customer_name text,
--   order_date date,
--   item_id int,
--   constraint fk_item_235163493048 foreign key(item_id) references items(id)
--     on delete cascade);

-- to use below this point for test seeds file
TRUNCATE TABLE items, orders RESTART IDENTITY;

INSERT INTO items (name, unit_price, stock_quantity)
  VALUES ('Super Shark Vacuum Cleaner', 99, 30);
INSERT INTO items (name, unit_price, stock_quantity)
  VALUES ('Makerspresso Coffee Machine', 69, 15);

INSERT INTO orders (customer_name, order_date, item_id)
  VALUES ('John Doe', '2022-08-21', 2);
INSERT INTO orders (customer_name, order_date, item_id)
  VALUES ('John Doe The Second', '2022-08-22', 2);
INSERT INTO orders (customer_name, order_date, item_id)
  VALUES ('Jane Doe', '2022-08-23', 2);
INSERT INTO orders (customer_name, order_date, item_id)
  VALUES ('Jane Doe', '2022-08-24', 1);