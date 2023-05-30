TRUNCATE TABLE items RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO items (name, unit_price, quantity, order_id) VALUES('Orange', '0.85', '5', '1');
INSERT INTO items (name, unit_price, quantity, order_id) VALUES('Apple', '2', '3', '1');