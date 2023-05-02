-- (file: spec/seeds_{table_name}.sql)

-- Write your SQL seed here.

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE items, items_orders, orders RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.



INSERT INTO items (name, unit_price, quantity) VALUES ('book', '2', '100');
INSERT INTO items (name, unit_price, quantity) VALUES ('pen', '1', '200');

INSERT INTO orders (customer_name, placed_date) VALUES ('David', '2023/04/22');
INSERT INTO orders (customer_name, placed_date) VALUES ('James', '2023/05/25');

INSERT INTO items_orders (item_id, order_id) VALUES (1,1);
INSERT INTO items_orders (item_id, order_id) VALUES (2,1);
INSERT INTO items_orders (item_id, order_id) VALUES (1,2);