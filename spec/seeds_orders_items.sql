TRUNCATE TABLE orders_items RESTART IDENTITY CASCADE;

INSERT INTO orders_items (order_id, item_id) VALUES ('1', '1');
INSERT INTO orders_items (order_id, item_id) VALUES ('1', '3');
INSERT INTO orders_items (order_id, item_id) VALUES ('2', '2');
INSERT INTO orders_items (order_id, item_id) VALUES ('2', '3');
INSERT INTO orders_items (order_id, item_id) VALUES ('3', '1');
INSERT INTO orders_items (order_id, item_id) VALUES ('3', '2');
INSERT INTO orders_items (order_id, item_id) VALUES ('3', '3');
INSERT INTO orders_items (order_id, item_id) VALUES ('3', '4');

