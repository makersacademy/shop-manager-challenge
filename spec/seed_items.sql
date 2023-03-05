TRUNCATE TABLE items, orders RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO items (name, price, quantity) VALUES ('Basketball', 13.50, 756);
INSERT INTO items (name, price, quantity) VALUES ('Shoes', 110.0, 78);