TRUNCATE TABLE items, orders RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO items (name, price, quantity) VALUES ('Mustang', 47630, 200);
INSERT INTO items (name, price, quantity) VALUES ('Fiesta', 19060, 600);