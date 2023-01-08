
INSERT INTO items (name, price, quantity) VALUES ('Phone', 189, 32);
INSERT INTO items (name, price, quantity) VALUES ('Laptop', 450, 25);
INSERT INTO items (name, price, quantity) VALUES ('Monitor', 120, 50);
INSERT INTO items (name, price, quantity) VALUES ('Keyboard', 20, 160);
INSERT INTO items (name, price, quantity) VALUES ('Mouse', 10, 150);

INSERT INTO orders (name, date) VALUES ('Lisa', '12/01/2023');
INSERT INTO orders_items (order_id, item_id, quantity) VALUES (1, 2, 2);

INSERT INTO orders (name, date) VALUES ('Rob', '18/12/2022');
INSERT INTO orders_items (order_id, item_id, quantity) VALUES (2, 2, 1);

INSERT INTO orders (name, date) VALUES ('Nathan', '13/12/2022');
INSERT INTO orders_items (order_id, item_id, quantity) VALUES (3, 3, 3);

INSERT INTO orders (name, date) VALUES ('Seren', '12/01/2023');
INSERT INTO orders_items (order_id, item_id, quantity) VALUES (4, 5, 1);

INSERT INTO orders (name, date) VALUES ('Sara', '12/01/2023');
INSERT INTO orders_items (order_id, item_id, quantity) VALUES (5, 4, 5);
