TRUNCATE TABLE orders, items, items_orders RESTART IDENTITY;

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.
INSERT INTO items (name, unit_price, quantity) VALUES ('blueberries', '4', '30');
INSERT INTO items (name, unit_price, quantity) VALUES ('raspberries', '5', '20');
INSERT INTO items (name, unit_price, quantity) VALUES ('eggs', '2', '50');
INSERT INTO items (name, unit_price, quantity) VALUES ('milk', '1', '50');
INSERT INTO items (name, unit_price, quantity) VALUES ('cheese', '4', '20');
INSERT INTO items (name, unit_price, quantity) VALUES ('bread', '2', '100');
INSERT INTO items (name, unit_price, quantity) VALUES ('bananas', '3', '20');

INSERT INTO orders (customer_name, order_date) VALUES ('Harry Styles', '2022-03-10');
INSERT INTO orders (customer_name, order_date) VALUES ('Taylor Swift', '2022-04-14');
INSERT INTO orders (customer_name, order_date) VALUES ('Billie Eillish', '2022-05-21');
INSERT INTO orders (customer_name, order_date) VALUES ('Madison Beer', '2022-05-23');

INSERT INTO items_orders (item_id, order_id) VALUES (1, 1);
INSERT INTO items_orders (item_id, order_id) VALUES (2, 1);
INSERT INTO items_orders (item_id, order_id) VALUES (7, 1);
INSERT INTO items_orders (item_id, order_id) VALUES (5, 1);
INSERT INTO items_orders (item_id, order_id) VALUES (3, 2);
INSERT INTO items_orders (item_id, order_id) VALUES (4, 2);
INSERT INTO items_orders (item_id, order_id) VALUES (5, 2);
INSERT INTO items_orders (item_id, order_id) VALUES (5, 3);
INSERT INTO items_orders (item_id, order_id) VALUES (3, 4);
INSERT INTO items_orders (item_id, order_id) VALUES (6, 4);
INSERT INTO items_orders (item_id, order_id) VALUES (7, 4);
