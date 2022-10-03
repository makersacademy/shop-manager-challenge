TRUNCATE TABLE items, orders RESTART IDENTITY; --

INSERT INTO items (name, price, quantity) VALUES ('1950s Wedding Dresses', 50, 2);
INSERT INTO items (name, price, quantity) VALUES ('Band Merch', 100, 10);

INSERT INTO orders (customer, date, item_id) VALUES ('Piper', 01102022, 1);
INSERT INTO orders (customer, date, item_id) VALUES ('Lily', 01062022, 2);