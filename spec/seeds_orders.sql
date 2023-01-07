TRUNCATE TABLE orders, items RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.
INSERT INTO items (name, price, quantity) VALUES ('Mustang', 47630, 200);
INSERT INTO items (name, price, quantity) VALUES ('Fiesta', 19060, 600);
INSERT INTO orders (customer_name, date, item_id) VALUES ('M. Jones', '2023-01-07', 1);
INSERT INTO orders (customer_name, date, item_id) VALUES ('R. Davids', '2023-01-08', 2);