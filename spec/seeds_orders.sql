-- (file: spec/seeds_orders.sql)
TRUNCATE TABLE orders, items RESTART IDENTITY;

INSERT INTO orders (customer_name, order_date) VALUES ('Paul Jones', '2022-08-25');
INSERT INTO orders (customer_name, order_date) VALUES ('Isabelle Mayhew', '2022-10-13');
INSERT INTO orders (customer_name, order_date) VALUES ('Naomi Laine', '2022-10-14');
INSERT INTO items (item_name, price, order_id) VALUES ('Apple', 90, 1);
INSERT INTO items (item_name, price, order_id) VALUES ('Banana', 75, 1);
INSERT INTO items (item_name, price, order_id) VALUES ('Cherries', 120, 2);
INSERT INTO items (item_name, price, order_id) VALUES ('Cherries', 120, 2);
INSERT INTO items (item_name, price, order_id) VALUES ('Cherries', 120, 2);
INSERT INTO items (item_name, price, order_id) VALUES ('Banana', 75, 3);
INSERT INTO items (item_name, price, order_id) VALUES ('Banana', 75, 3);
INSERT INTO items (item_name, price) VALUES ('Apple', 90);
INSERT INTO items (item_name, price) VALUES ('Apple', 90);
INSERT INTO items (item_name, price) VALUES ('Banana', 75);
INSERT INTO items (item_name, price) VALUES ('Banana', 75);
INSERT INTO items (item_name, price) VALUES ('Cherries', 120);