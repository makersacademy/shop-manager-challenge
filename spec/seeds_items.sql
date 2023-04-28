TRUNCATE TABLE items, orders RESTART IDENTITY;

INSERT INTO items (name, unit_price, quantity) VALUES ('Cookie Dough', 2.99, 25);
INSERT INTO items (name, unit_price, quantity) VALUES ('Ice Cream', 1.99, 50);


