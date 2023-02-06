TRUNCATE TABLE orders,items RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO items (name, unit_price, quantity) VALUES ('Super Shark Vacuum Cleaner', 99, 30);
INSERT INTO items (name, unit_price, quantity) VALUES ('Makerspresso Coffee Machine', 69, 15);
INSERT INTO orders (customer_name, date, item_id) VALUES ('Dave','2023-02-03',1);
INSERT INTO orders (customer_name, date, item_id) VALUES ('John','2023-02-03',2);