TRUNCATE TABLE items, orders, items_orders RESTART IDENTITY;

INSERT INTO items (product, price, quantity) VALUES ('Apple', 1, 100);
INSERT INTO items (product, price, quantity) VALUES ('Banana', 2, 50);
INSERT INTO items (product, price, quantity) VALUES ('Canteloupe', 3, 20);

INSERT INTO orders (customer, date) VALUES ('Andy', '2022-01-01');
INSERT INTO orders (customer, date) VALUES ('Barry', '2022-02-02');
INSERT INTO orders (customer, date) VALUES ('Carl', '2022-03-03');

INSERT INTO items_orders (item_id, order_id) VALUES (1,1);
INSERT INTO items_orders (item_id, order_id) VALUES (2,1);
INSERT INTO items_orders (item_id, order_id) VALUES (3,1);
INSERT INTO items_orders (item_id, order_id) VALUES (2,2);
INSERT INTO items_orders (item_id, order_id) VALUES (3,2);
INSERT INTO items_orders (item_id, order_id) VALUES (3,3);