DROP TABLE IF EXISTS items CASCADE;
CREATE SEQUENCE IF NOT EXISTS items_id_seq;
CREATE TABLE items (id SERIAL PRIMARY KEY, name TEXT, price DECIMAL, quantity INTEGER);

DROP TABLE IF EXISTS items_orders;

CREATE TABLE items_orders (items_id INTEGER, orders_id INTEGER, items_order_quantity INTEGER);

DROP TABLE IF EXISTS orders;
CREATE SEQUENCE IF NOT EXISTS orders_id_seq;
CREATE TABLE orders (id SERIAL PRIMARY KEY, customer_name TEXT, order_date DATE);

ALTER TABLE items_orders ADD FOREIGN KEY (items_id) REFERENCES items(id);
ALTER TABLE items_orders ADD FOREIGN KEY (orders_id) REFERENCES orders(id);

INSERT INTO items (name, price, quantity) VALUES ('Vacuum Cleaner', 299.99, 20);
INSERT INTO items (name, price, quantity) VALUES ('Coffee Machine', 249.50, 10);
INSERT INTO items (name, price, quantity) VALUES ('Air Conditioner', 343.49, 13);

INSERT INTO orders (customer_name, order_date) VALUES ('Shaun', '2015-12-01');
INSERT INTO orders (customer_name, order_date) VALUES ('Hello', '2013-11-13');
INSERT INTO orders (customer_name, order_date) VALUES ('World', '2020-10-12');


INSERT INTO items_orders (orders_id, items_id, items_order_quantity) VALUES (1,1,2);
INSERT INTO items_orders (orders_id, items_id, items_order_quantity) VALUES (1,3,1);
INSERT INTO items_orders (orders_id, items_id, items_order_quantity) VALUES (2,1,1);
INSERT INTO items_orders (orders_id, items_id, items_order_quantity) VALUES (2,3,2);
INSERT INTO items_orders (orders_id, items_id, items_order_quantity) VALUES (3,1,1);
INSERT INTO items_orders (orders_id, items_id, items_order_quantity) VALUES (3,2,1);
INSERT INTO items_orders (orders_id, items_id, items_order_quantity) VALUES (3,3,1);