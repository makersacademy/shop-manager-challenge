TRUNCATE TABLE items RESTART IDENTITY CASCADE; -- replace with your own table name.
-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.
INSERT INTO items (name, price, quantity) VALUES ('ball', '10', '100');
INSERT INTO items (name, price, quantity) VALUES ('shoes', '50', '200');
INSERT INTO items (name, price, quantity) VALUES ('socks', '5', '100');
INSERT INTO items (name, price, quantity) VALUES ('jersey', '70', '50');
INSERT INTO items (name, price, quantity) VALUES ('shorts', '20', '300');
