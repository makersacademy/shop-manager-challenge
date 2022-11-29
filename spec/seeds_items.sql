TRUNCATE TABLE orders, items RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO items (name, price, quantity) VALUES ('shirt', 10, 20);
INSERT INTO items (name, price, quantity) VALUES ('trouser', 5, 5);
INSERT INTO items (name, price, quantity) VALUES ('tie', 2, 10);


