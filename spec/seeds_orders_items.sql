TRUNCATE TABLE orders_items RESTART IDENTITY CASCADE;

INSERT INTO orders_items (order_id, item_id, quantity) VALUES ('1', '1', '3');
INSERT INTO orders_items (order_id, item_id, quantity) VALUES ('1', '3', '4');
INSERT INTO orders_items (order_id, item_id, quantity) VALUES ('2', '2', '5');
INSERT INTO orders_items (order_id, item_id, quantity) VALUES ('2', '3', '5');
INSERT INTO orders_items (order_id, item_id, quantity) VALUES ('3', '1', '5');
INSERT INTO orders_items (order_id, item_id, quantity) VALUES ('3', '2', '5');
INSERT INTO orders_items (order_id, item_id, quantity) VALUES ('3', '3', '5');
INSERT INTO orders_items (order_id, item_id, quantity) VALUES ('3', '4', '5');

