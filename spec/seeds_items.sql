TRUNCATE TABLE items RESTART IDENTITY CASCADE; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO items (name, price, quantity) VALUES ('shoes', 120, 10);
INSERT INTO items (name, price, quantity) VALUES ('jacket', 250, 15);