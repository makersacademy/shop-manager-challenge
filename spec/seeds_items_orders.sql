-- EXAMPLE
-- (file: spec/seeds_{table_name}.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE items, orders, items_orders RESTART IDENTITY;

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO items (name, price, quantity) VALUES ('iPhone', '700', '65');
INSERT INTO items (name, price, quantity) VALUES ('MacBookAir', '990', '22');
INSERT INTO items (name, price, quantity) VALUES ('MacBookAir Pro', '1200', '17');

INSERT INTO orders (order_id, customer_name, date_of_order) VALUES ('1', 'Evelina', '2022-07-25');
INSERT INTO orders (order_id,customer_name, date_of_order) VALUES ('3', 'Mary', '2022-07-31');
INSERT INTO orders (order_id, customer_name, date_of_order) VALUES ('2', 'John', '2022-07-28');



