TRUNCATE TABLE items RESTART IDENTITY CASCADE;

INSERT INTO items (name, unit_price, quantity) VALUES ('Socks', '2.75', '100');
INSERT INTO items (name, unit_price, quantity) VALUES ('T-shirts', '10.00', '50');
INSERT INTO items (name, unit_price, quantity) VALUES ('Trousers', '18.50', '80');
INSERT INTO items (name, unit_price, quantity) VALUES ('Shoes', '45.00', '30');
