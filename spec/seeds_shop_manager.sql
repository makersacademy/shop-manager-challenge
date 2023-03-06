INSERT INTO customers (customer_name) VALUES ('Customer1');
INSERT INTO customers (customer_name) VALUES ('Customer2');
INSERT INTO customers (customer_name) VALUES ('Customer3');

INSERT INTO items (item_name, item_price, item_quantity) VALUES ('Item1', 1, 5);
INSERT INTO items (item_name, item_price, item_quantity) VALUES ('Item2', 5, 50);
INSERT INTO items (item_name, item_price, item_quantity) VALUES ('Item3', 10, 25);
INSERT INTO items (item_name, item_price, item_quantity) VALUES ('Item4', 2, 100);
INSERT INTO items (item_name, item_price, item_quantity) VALUES ('Item5', 8, 70);

INSERT INTO orders (order_date, item_id, customer_id) VALUES ('3/5/2023', 2, 1);
INSERT INTO orders (order_date, item_id, customer_id) VALUES ('3/6/2023', 1, 1);
INSERT INTO orders (order_date, item_id, customer_id) VALUES ('3/7/2023', 1, 2);
INSERT INTO orders (order_date, item_id, customer_id) VALUES ('3/5/2023', 5, 2);
INSERT INTO orders (order_date, item_id, customer_id) VALUES ('3/8/2023', 4, 1);
INSERT INTO orders (order_date, item_id, customer_id) VALUES ('3/15/2023', 4, 2);