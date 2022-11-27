-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE items RESTART IDENTITY CASCADE; -- replace with your own table name.
TRUNCATE TABLE orders RESTART IDENTITY CASCADE;

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO items (name, unit_price, quantity) VALUES ('Computer', 500, 20);
INSERT INTO items (name, unit_price, quantity) VALUES ('Phone', 599, 79);
INSERT INTO items (name, unit_price, quantity) VALUES ('TV', 150, 200);
INSERT INTO items (name, unit_price, quantity) VALUES ('Shoes', 30, 250);
INSERT INTO items (name, unit_price, quantity) VALUES ('Basket', 5, 150);

INSERT INTO orders (customer_name, order_date) VALUES ('David', '2022-01-10');
INSERT INTO orders (customer_name, order_date) VALUES ('Anna', '2022-01-11');
INSERT INTO orders (customer_name, order_date) VALUES ('Max', '2022-01-15');

INSERT INTO items_orders (item_id, order_id) VALUES (1, 1);
INSERT INTO items_orders (item_id, order_id) VALUES (1, 2);
INSERT INTO items_orders (item_id, order_id) VALUES (2, 3);
INSERT INTO items_orders (item_id, order_id) VALUES (3, 2);
INSERT INTO items_orders (item_id, order_id) VALUES (3, 1);
INSERT INTO items_orders (item_id, order_id) VALUES (4, 1);
INSERT INTO items_orders (item_id, order_id) VALUES (4, 2);
INSERT INTO items_orders (item_id, order_id) VALUES (5, 3);
INSERT INTO items_orders (item_id, order_id) VALUES (5, 2);