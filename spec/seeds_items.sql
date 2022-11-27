TRUNCATE TABLE items RESTART IDENTITY CASCADE; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO items (name, price, quantity) VALUES ('Banana', '2.00', 14);
INSERT INTO items (name, price, quantity) VALUES ('Cheesecake', '11.00', 3);