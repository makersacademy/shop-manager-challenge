TRUNCATE TABLE items RESTART IDENTITY cascade;

INSERT INTO items (name, unit_price, quantity) VALUES ('corn', '1.5', '250');
INSERT INTO items (name, unit_price, quantity) VALUES ('peas', '1.75', '200');
INSERT INTO items (name, unit_price, quantity) VALUES ('lettuce', '2', '150');
INSERT INTO items (name, unit_price, quantity) VALUES ('carrot', '1.25', '500');
INSERT INTO items (name, unit_price, quantity) VALUES ('parsnip', '2.5', '50');