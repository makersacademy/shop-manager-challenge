TRUNCATE TABLE items_orders RESTART IDENTITY;

INSERT INTO items (name, unit_price, quantity) VALUES ( 'Royal Canin kitten food', '5', '20');
INSERT INTO items (name, unit_price, quantity) VALUES ( 'Organic tomatoes', '3', '10');
INSERT INTO items (name, unit_price, quantity) VALUES ( 'Celery', '2', '7');
INSERT INTO items (name, unit_price, quantity) VALUES ( 'Scottish salmon', '6', '9');
INSERT INTO items (name, unit_price, quantity) VALUES ( 'Baby leaves', '3', '15');

INSERT INTO orders (customer_name, date) VALUES ('Alice', '2022-09-15');
INSERT INTO orders (customer_name, date) VALUES ('Pedro', '2022-08-30');
INSERT INTO orders (customer_name, date) VALUES ('Hannah', '2022-10-01');

INSERT INTO items_orders (item_id, order_id) VALUES (1, 1);
INSERT INTO items_orders (item_id, order_id) VALUES (2, 1);
INSERT INTO items_orders (item_id, order_id) VALUES (3, 2);
INSERT INTO items_orders (item_id, order_id) VALUES (4, 2);
INSERT INTO items_orders (item_id, order_id) VALUES (5, 3);



