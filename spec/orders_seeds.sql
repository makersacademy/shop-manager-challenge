TRUNCATE TABLE orders RESTART IDENTITY CASCADE; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO orders (order_name, customer_name, order_date) VALUES ('Nice Mints', 'Karl', '2023');
INSERT INTO orders (order_name, customer_name, order_date) VALUES ('Best Beans', 'Sue', '2023');