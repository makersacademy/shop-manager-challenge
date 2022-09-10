TRUNCATE TABLE items, orders, items_orders RESTART IDENTITY;

INSERT INTO items (name, price, stock_qty) VALUES ('Item 1', 1, 5);
INSERT INTO items (name, price, stock_qty) VALUES ('Item 2', 2, 10);

INSERT INTO orders (customer, item, date) VALUES ('Wendy', 'Item 1', '2022-01-13');
INSERT INTO orders (customer, item, date) VALUES ('Jovi', 'Item 2', '2022-02-13');
INSERT INTO orders (customer, item, date) VALUES ('Bob', 'Item 1', '2022-03-13');
INSERT INTO orders (customer, item, date) VALUES ('Dave', 'Item 2', '2022-04-13');

INSERT INTO items_orders (item_id, order_id) VALUES (2, 2);
INSERT INTO items_orders (item_id, order_id) VALUES (1, 1);
INSERT INTO items_orders (item_id, order_id) VALUES (1, 3);
INSERT INTO items_orders (item_id, order_id) VALUES (2, 4);
