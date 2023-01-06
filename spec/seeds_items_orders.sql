TRUNCATE TABLE items, orders RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO items (name, price, quantity) VALUES ('Super Shark Vacuum Cleaner', '99', '30');
INSERT INTO items (name, price, quantity) VALUES ('Makerspresso Coffee Machine', '70', '15');

INSERT INTO orders (customer_name, date, item_id) VALUES ('John Smith', '06/01/22', '1');
INSERT INTO orders (customer_name, date, item_id) VALUES ('Pauline Jones', '05/01/22', '2');