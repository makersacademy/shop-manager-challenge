TRUNCATE TABLE items RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO items (item_name, quantity, price, order_id) VALUES ('pizza', 10, 4.99, 1);
INSERT INTO items (item_name, quantity, price, order_id) VALUES ('beer', 20, 1.99, 2);