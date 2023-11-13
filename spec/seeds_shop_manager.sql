TRUNCATE TABLE items RESTART IDENTITY CASCADE; -- replace with your own table name.


-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO items (name, unit_price, stock_quantity) VALUES ('Coffee Machine', '99.99', '7');
INSERT INTO items (name, unit_price, stock_quantity) VALUES ('Vacuum Cleaner', '125.0', '42');
INSERT INTO items (name, unit_price, stock_quantity) VALUES ('Curtain', '34.0', '205');

INSERT INTO orders (customer_name, date, item_id) VALUES ('Andrea', '2023-01-18', '1');
INSERT INTO orders (customer_name, date, item_id) VALUES ('Céline', '2023-03-14', '2');
INSERT INTO orders (customer_name, date, item_id) VALUES ('Chiara', '2023-04-19', '3');