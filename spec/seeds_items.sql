TRUNCATE TABLE items RESTART IDENTITY CASCADE; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO items (name, unit_price, quantity) VALUES ('Correction tape', '4.95', '26');
INSERT INTO items (name, unit_price, quantity) VALUES ('Cute eraser', '3.25', '14');