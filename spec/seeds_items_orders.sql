-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE items, orders RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO items (name, price, quantity) VALUES ('Super Shark Vacuum Cleaner', 99, 30);
INSERT INTO items (name, price, quantity) VALUES ('Makerspresso Coffee Machine', 69, 15);
INSERT INTO items (name, price, quantity) VALUES ('Toastie Maker', 30, 60);

INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Customer1', '2023-01-01', 1);
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Customer2', '2023-01-10', 2);
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Customer3', '2023-01-20', 3);