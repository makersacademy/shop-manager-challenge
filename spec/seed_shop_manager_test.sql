TRUNCATE TABLE items, orders, orders_items RESTART IDENTITY;

INSERT INTO items (name, price, quantity) VALUES ('Phone', 189, 32);
INSERT INTO items (name, price, quantity) VALUES ('Laptop', 450, 25);

INSERT INTO orders (customer_name, date) VALUES ('Lisa', '12/01/2023');
INSERT INTO orders_items (order_id, item_id) VALUES (1, 2);

INSERT INTO orders (customer_name, date) VALUES ('Rob', '18/12/2022');
INSERT INTO orders_items (order_id, item_id) VALUES (2, 2);