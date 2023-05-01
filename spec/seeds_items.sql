TRUNCATE TABLE items RESTART IDENTITY CASCADE; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO items (name, unit_price, quantity) VALUES ('Flake', 99, 10);
INSERT INTO items (name, unit_price, quantity) VALUES ('Twix', 110, 5);