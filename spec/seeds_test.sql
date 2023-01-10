TRUNCATE TABLE items, orders RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO items (name, price, quantity) VALUES ('Toothpaste', '£3.40', 10);
INSERT INTO items (name, price, quantity) VALUES ('Mouthwash', '£5.00', 20);

INSERT INTO orders (customer_name, date, item_id) VALUES ('John', '02/01/22', 1);
INSERT INTO orders (customer_name, date, item_id) VALUES ('George', '13/02/22', 2);