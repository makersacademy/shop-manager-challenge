TRUNCATE TABLE items RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO items (name, unit_price, quantity) VALUES ('item1', '10.0', '30');
INSERT INTO items (name, unit_price, quantity) VALUES ('item2', '12.1', ' 22');