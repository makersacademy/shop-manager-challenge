TRUNCATE TABLE items, orders RESTART IDENTITY;

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO orders (customer, date) VALUES ('Guillermina', '2022, 09, 10');
INSERT INTO orders (customer, date) VALUES ('Pablo', '2022, 09, 05');

INSERT INTO items (stock, name, price, order_id) VALUES (3, 'Coffee', 5, 1);
INSERT INTO items (stock, name, price, order_id) VALUES (5, 'Milk', 3, 2);