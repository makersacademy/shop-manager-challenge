TRUNCATE orders, items, items_orders RESTART IDENTITY CASCADE;

INSERT INTO items (item_name, unit_price, quantity) VALUES ('Chips', 2.99, 1);
INSERT INTO items (item_name, unit_price, quantity) VALUES ('Pizza', 3.49, 2);
INSERT INTO items (item_name, unit_price, quantity) VALUES ('Sandwich', 1.99, 3);

INSERT INTO orders (customer_name, order_date) VALUES ('Sara', '1995-09-01');
INSERT INTO orders (customer_name, order_date) VALUES ('Anne', '2022-12-12');


INSERT INTO items_orders (item_id, order_id) VALUES (1, 1);
INSERT INTO items_orders (item_id, order_id) VALUES (2, 1);
INSERT INTO items_orders (item_id, order_id) VALUES (3, 2);