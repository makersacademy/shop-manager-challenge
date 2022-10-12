TRUNCATE TABLE items RESTART IDENTITY CASCADE; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO items (name, unit_price, quantity) VALUES ('TV', 250, 10);
INSERT INTO items (name, unit_price, quantity) VALUES ('Microwave', 80, 50);
INSERT INTO items (name, unit_price, quantity) VALUES ('Kettle', 20, 70);
INSERT INTO items (name, unit_price, quantity) VALUES ('Rug', 75, 30);