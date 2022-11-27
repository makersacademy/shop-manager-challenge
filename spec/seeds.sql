TRUNCATE TABLE items RESTART IDENTITY CASCADE; -- replace with your own table name.
TRUNCATE TABLE orders RESTART IDENTITY CASCADE; -- replace with your own table name.
TRUNCATE TABLE items_orders RESTART IDENTITY;

INSERT INTO items (name, price, quantity) VALUES ('Item 1', 12.00, 5);
INSERT INTO items (name, price, quantity) VALUES ('Item 2', 04.50, 7);
INSERT INTO items (name, price, quantity) VALUES ('Item 3', 05.35, 10);
INSERT INTO items (name, price, quantity) VALUES ('Item 4', 32.45, 15);

INSERT INTO orders (customer_name, order_date) VALUES ('Customer 1', DATE '2022-11-07');
INSERT INTO orders (customer_name, order_date) VALUES ('Customer 2', DATE '2022-11-10');
INSERT INTO orders (customer_name, order_date) VALUES ('Customer 3', DATE '2022-11-08');
INSERT INTO orders (customer_name, order_date) VALUES ('Customer 4', DATE '2022-11-07');

INSERT INTO items_orders (item_id, order_id) VALUES (1, 3);
INSERT INTO items_orders (item_id, order_id) VALUES (1, 4);
INSERT INTO items_orders (item_id, order_id) VALUES (2, 3);
INSERT INTO items_orders (item_id, order_id) VALUES (3, 1);
INSERT INTO items_orders (item_id, order_id) VALUES (3, 2);
INSERT INTO items_orders (item_id, order_id) VALUES (3, 3);
INSERT INTO items_orders (item_id, order_id) VALUES (4, 2);
INSERT INTO items_orders (item_id, order_id) VALUES (4, 4);
