TRUNCATE TABLE items, orders, items_orders RESTART IDENTITY; 

INSERT INTO items (name, price, quantity) VALUES ('1984', '9.99', '54');
INSERT INTO items (name, price, quantity) VALUES ('War and peace', '7.99', '14');

INSERT INTO orders (customer, date) VALUES ('Anna', '2022, 08, 15');
INSERT INTO orders (customer, date) VALUES ('David', '``2022, 08, 23``');

INSERT INTO items_orders (item_id, order_id) VALUES (1, 1);
INSERT INTO items_orders (item_id, order_id) VALUES (1, 2);
INSERT INTO items_orders (item_id, order_id) VALUES (2, 1);