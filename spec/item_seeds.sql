TRUNCATE TABLE items RESTART IDENTITY CASCADE;

INSERT INTO items (item_name, unit_price, quantity) VALUES ('Candlestick', 1.99, 10);
INSERT INTO items (item_name, unit_price, quantity) VALUES ('Lead-Pipe', 4.45, 3);
INSERT INTO items (item_name, unit_price, quantity) VALUES ('Gun', 12.95, 1);