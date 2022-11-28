TRUNCATE TABLE items, orders RESTART IDENTITY; -- replace with your own table name.
-- TRUNCATE TABLE orders RESTART IDENTITY;

INSERT INTO orders (customer_name, date) VALUES ('Grace', '2022/11/26');
INSERT INTO orders (customer_name, date) VALUES ('Frankie', '2022/11/24');


-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO items (item, price, quantity, order_id) VALUES ('Bread', '9.99', 5, 1);
INSERT INTO items (item, price, quantity, order_id) VALUES ('Butter', '7.99', 1, 1);
