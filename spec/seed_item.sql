TRUNCATE TABLE items, orders RESTART IDENTITY;

INSERT INTO items (name, price, quantity) VALUES ('item1', 66.50, 70);
INSERT INTO items (name, price, quantity) VALUES ('item2', 33.25, 35);
