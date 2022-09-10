TRUNCATE TABLE items, orders, items_orders RESTART IDENTITY;

INSERT INTO items (name, price, stock_qty) VALUES ('Item 1', 1, 5); -- id 1
INSERT INTO items (name, price, stock_qty) VALUES ('Item 2', 2, 10); -- id 2

INSERT INTO orders (customer, item_id, date) VALUES ('Wendy', 1, 2022-01-13); -- id 1
INSERT INTO orders (customer, item_id, date) VALUES ('Jovi', 2, 2022-02-13); -- id 2
INSERT INTO orders (customer, item_id, date) VALUES ('Bob', 1, 2022-03-13); -- id 3
INSERT INTO orders (customer, item_id, date) VALUES ('Dave', 2, 2022-04-13); -- id 4

INSERT INTO items_orders (item_id, order_id) VALUES (1, 1);
INSERT INTO items_orders (item_id, order_id) VALUES (2, 2);
INSERT INTO items_orders (item_id, order_id) VALUES (1, 3);
INSERT INTO items_orders (item_id, order_id) VALUES (2, 4);
