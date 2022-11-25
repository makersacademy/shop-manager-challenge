-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE orders RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO orders (customer_name, item_id, order_date) VALUES ('Jeff Winger', 2, '24.12.2021');
INSERT INTO orders (customer_name, item_id, order_date) VALUES ('Jeff Winger', 3, '24.12.2021');
INSERT INTO orders (customer_name, item_id, order_date) VALUES ('Raymond Holt', 4, '4.6.2022');
INSERT INTO orders (customer_name, item_id, order_date) VALUES ('Jake Peralta', 1, '9.9.2022');
INSERT INTO orders (customer_name, item_id, order_date) VALUES ('Michael Scott', 5, '1.10.2022');
INSERT INTO orders (customer_name, item_id, order_date) VALUES ('Dwight Schrute', 6, '6.10.2022');