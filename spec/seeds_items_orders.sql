TRUNCATE TABLE items, orders, items_orders RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO items (name, unit_price, item_quantity) VALUES ('Mascara', 9, 30);
INSERT INTO items (name, unit_price, item_quantity) VALUES ('Foundation', 42, 40);
INSERT INTO items (name, unit_price, item_quantity) VALUES ('Lipstick', 19, 15);
INSERT INTO items (name, unit_price, item_quantity) VALUES ('Blusher', 22, 10);

INSERT INTO orders (customer_name, order_date) VALUES ('Cindy', '2023-03-05');
INSERT INTO orders (customer_name, order_date) VALUES ('Lucy', '2023-03-03');
INSERT INTO orders (customer_name, order_date) VALUES ('Jane', '2023-03-01');

INSERT INTO items_orders (item_id, order_id) VALUES (1, 3);
INSERT INTO items_orders (item_id, order_id) VALUES (1, 2);
INSERT INTO items_orders (item_id, order_id) VALUES (2, 2);
INSERT INTO items_orders (item_id, order_id) VALUES (3, 1);
INSERT INTO items_orders (item_id, order_id) VALUES (3, 3);
INSERT INTO items_orders (item_id, order_id) VALUES (2, 1);
INSERT INTO items_orders (item_id, order_id) VALUES (4, 1);
INSERT INTO items_orders (item_id, order_id) VALUES (4, 3);
