TRUNCATE TABLE orders_by_items RESTART IDENTITY cascade;

INSERT INTO orders_by_items (item_id, order_id) VALUES ('1', '1');
INSERT INTO orders_by_items (item_id, order_id) VALUES ('2', '1');
INSERT INTO orders_by_items (item_id, order_id) VALUES ('4', '1');
INSERT INTO orders_by_items (item_id, order_id) VALUES ('5', '1');
INSERT INTO orders_by_items (item_id, order_id) VALUES ('3', '2');
INSERT INTO orders_by_items (item_id, order_id) VALUES ('3', '2');
INSERT INTO orders_by_items (item_id, order_id) VALUES ('1', '3');
INSERT INTO orders_by_items (item_id, order_id) VALUES ('3', '3');
INSERT INTO orders_by_items (item_id, order_id) VALUES ('2', '3');
INSERT INTO orders_by_items (item_id, order_id) VALUES ('4', '3');
INSERT INTO orders_by_items (item_id, order_id) VALUES ('2', '4');
INSERT INTO orders_by_items (item_id, order_id) VALUES ('5', '5');
INSERT INTO orders_by_items (item_id, order_id) VALUES ('2', '5');
INSERT INTO orders_by_items (item_id, order_id) VALUES ('3', '5');