TRUNCATE TABLE products RESTART IDENTITY CASCADE; -- replace with your own table name.

INSERT INTO products (name, unit_price, quantity) VALUES ('PS5', 350, 2);
INSERT INTO products (name, unit_price, quantity) VALUES ('XBOX', 275, 10);
