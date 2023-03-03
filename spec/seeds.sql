TRUNCATE TABLE items, orders RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.


INSERT INTO items (item_name, price, quantity) VALUES ('Apples', '0.99', '2');
INSERT INTO items (item_name, price, quantity) VALUES ('Pears', '0.45', '1');
INSERT INTO orders (customer_name, order_date, item_id ) VALUES ('jamespates', '2023-03-03', '1');
INSERT INTO orders (customer_name, order_date, item_id ) VALUES ('jamespates', '2023-03-01', '1');