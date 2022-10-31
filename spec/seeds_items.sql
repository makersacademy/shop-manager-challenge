TRUNCATE orders, items, orders_items RESTART IDENTITY;

INSERT INTO  items (name, price, quantity) VALUES('Iphone 11', 1000, 10);
INSERT INTO  items (name, price, quantity) VALUES('Iphone 10', 900, 5);
INSERT INTO  items (name, price, quantity) VALUES('Iphone 8', 500, 1);

INSERT INTO  orders (customer_name, date) VALUES('Mike', '2022-10-01');
INSERT INTO  orders (customer_name, date) VALUES('John', '2022-10-25');
INSERT INTO  orders (customer_name, date) VALUES('Sam', '2022-10-27');

INSERT INTO orders_items (order_id, item_id) VALUES(1, 1);
INSERT INTO orders_items (order_id, item_id) VALUES(3, 1);
INSERT INTO orders_items (order_id, item_id) VALUES(2, 2);
INSERT INTO orders_items (order_id, item_id) VALUES(2, 3);