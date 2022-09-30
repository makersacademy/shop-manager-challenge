TRUNCATE TABLE items RESTART IDENTITY CASCADE;
TRUNCATE TABLE orders RESTART IDENTITY CASCADE;

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO items (name, price, quantity) VALUES ('Scrabble', 14, 100);

INSERT INTO orders (customer_name, date) VALUES ('Stephen', '09-29-2022');
INSERT INTO orders (customer_name, date) VALUES ('Alan','10-01-2022');