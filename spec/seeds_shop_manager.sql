TRUNCATE TABLE items, orders, items_orders RESTART IDENTITY; -- replace with your own table name.

INSERT INTO items (name, price, quantity) VALUES ('shirt', 35.00, 5);
INSERT INTO items (name, price, quantity) VALUES ('jeans', 50.00, 6);
INSERT INTO items (name, price, quantity) VALUES ('hoodie', 40.00, 3);

INSERT INTO orders (customer_name, date) VALUES ('Jack', '2023-02-21');
INSERT INTO orders (customer_name, date) VALUES ('George', '2023-03-10');

INSERT INTO items_orders (item_id, order_id) VALUES (1, 1);
INSERT INTO items_orders (item_id, order_id) VALUES (1, 2);
INSERT INTO items_orders (item_id, order_id) VALUES (2, 1);
INSERT INTO items_orders (item_id, order_id) VALUES (3, 2);