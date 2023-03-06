TRUNCATE TABLE orders, items RESTART IDENTITY CASCADE; 

INSERT INTO orders (date, customer) VALUES ('2023-03-01', 'Jim');
INSERT INTO orders (date, customer) VALUES ('2023-02-01', 'Tim');
INSERT INTO orders (date, customer) VALUES ('2023-01-01', 'Kim');
INSERT INTO orders (date, customer) VALUES ('2022-12-01', 'Lim');
INSERT INTO orders (date, customer) VALUES ('2022-11-01', 'Yim');

INSERT INTO items (name, price, quantity) VALUES ('Xbox series X', 399, 20);
INSERT INTO items (name, price, quantity) VALUES ('Dell Monitor 4K', 499, 25);
INSERT INTO items (name, price, quantity) VALUES ('Macbook Air', 1249, 30);
INSERT INTO items (name, price, quantity) VALUES ('LG TV 4K', 119, 35);
INSERT INTO items (name, price, quantity) VALUES ('Ipad', 369, 40);

TRUNCATE TABLE orders_items RESTART IDENTITY; 

INSERT INTO orders_items (order_id, item_id) VALUES (1, 1);
INSERT INTO orders_items (order_id, item_id) VALUES (1, 4);

INSERT INTO orders_items (order_id, item_id) VALUES (2, 2);
INSERT INTO orders_items (order_id, item_id) VALUES (2, 3);

INSERT INTO orders_items (order_id, item_id) VALUES (3, 5);
INSERT INTO orders_items (order_id, item_id) VALUES (3, 3);

INSERT INTO orders_items (order_id, item_id) VALUES (4, 1);
INSERT INTO orders_items (order_id, item_id) VALUES (4, 2);
INSERT INTO orders_items (order_id, item_id) VALUES (4, 3);
INSERT INTO orders_items (order_id, item_id) VALUES (4, 4);
INSERT INTO orders_items (order_id, item_id) VALUES (4, 5);

INSERT INTO orders_items (order_id, item_id) VALUES (5, 5);
INSERT INTO orders_items (order_id, item_id) VALUES (5, 4);
INSERT INTO orders_items (order_id, item_id) VALUES (5, 1);