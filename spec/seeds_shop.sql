TRUNCATE TABLE items, orders, items_orders RESTART IDENTITY; 

INSERT INTO items (name, price, quantity) VALUES ('Socks', 2.50, 100);
INSERT INTO items (name, price, quantity) VALUES ('Trousers', 11.00, 75);
INSERT INTO items (name, price, quantity) VALUES ('Shirt', 12.00, 60);
INSERT INTO items (name, price, quantity) VALUES ('Shoes', 30.00, 50);
INSERT INTO items (name, price, quantity) VALUES ('Skirt', 7.50, 65);
INSERT INTO items (name, price, quantity) VALUES ('Hat', 5.50, 90);
INSERT INTO items (name, price, quantity) VALUES ('Scarf', 3.50, 120);
INSERT INTO items (name, price, quantity) VALUES ('Dress', 12.50, 70);

INSERT INTO orders (customer_name, date) VALUES ('Sia', '2022-10-29');
INSERT INTO orders (customer_name, date) VALUES ('Bon', '2022-09-28');
INSERT INTO orders (customer_name, date) VALUES ('Ozzy', '2022-08-27');
INSERT INTO orders (customer_name, date) VALUES ('Lana', '2022-07-26');
INSERT INTO orders (customer_name, date) VALUES ('Ari', '2022-06-25');

INSERT INTO items_orders (item_id, order_id) VALUES (1, 1);
INSERT INTO items_orders (item_id, order_id) VALUES (2, 1);
INSERT INTO items_orders (item_id, order_id) VALUES (3, 1);
INSERT INTO items_orders (item_id, order_id) VALUES (5, 2);
INSERT INTO items_orders (item_id, order_id) VALUES (7, 2);
INSERT INTO items_orders (item_id, order_id) VALUES (1, 2);
INSERT INTO items_orders (item_id, order_id) VALUES (1, 3);
INSERT INTO items_orders (item_id, order_id) VALUES (1, 5);
INSERT INTO items_orders (item_id, order_id) VALUES (2, 4);
INSERT INTO items_orders (item_id, order_id) VALUES (7, 3);
INSERT INTO items_orders (item_id, order_id) VALUES (4, 5);
INSERT INTO items_orders (item_id, order_id) VALUES (6, 3);
INSERT INTO items_orders (item_id, order_id) VALUES (6, 2);
INSERT INTO items_orders (item_id, order_id) VALUES (3, 3);
INSERT INTO items_orders (item_id, order_id) VALUES (5, 5);