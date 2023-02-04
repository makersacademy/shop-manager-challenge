TRUNCATE TABLE items, orders RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO items (id, name, price, quantity) VALUES (1, 'Cheese', '5', '8');
INSERT INTO items (id, name, price, quantity) VALUES (2, 'Cake', '10', '5');

INSERT INTO orders (id, customer_name, date, item_id) VALUES (1, 'Harry', '1987-12-03', '1');
INSERT INTO orders (id, customer_name, date, item_id) VALUES (2, 'Hermoine', '1989-12-13', '2');