TRUNCATE TABLE items RESTART IDENTITY CASCADE;

INSERT INTO items (name, unit_price, quantity) VALUES ('coffee machine', 80, 30);
INSERT INTO items (name, unit_price, quantity) VALUES ('vacuum cleaner', 100, 15);
INSERT INTO items (name, unit_price, quantity) VALUES ('toaster', 30, 60);