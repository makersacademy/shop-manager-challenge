TRUNCATE items, orders, items_orders RESTART IDENTITY;

INSERT INTO  items (name, unit_price, quantity) VALUES('Tower Air Fryer', 55, 10);
INSERT INTO  items (name, unit_price, quantity) VALUES('Howork Stand Mixer', 54, 23);

INSERT INTO  orders (customer_name, date_ordered) VALUES('Tinky-winky', '2022-09-28');
INSERT INTO  orders (customer_name, date_ordered) VALUES('Dipsy', '2022-09-27');

INSERT INTO items_orders (item_id, order_id) VALUES(1, 1);
INSERT INTO items_orders (item_id, order_id) VALUES(2, 1);
INSERT INTO items_orders (item_id, order_id) VALUES(2, 2);