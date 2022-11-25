TRUNCATE TABLE orders RESTART IDENTITY CASCADE; -- replace with your own table name.

INSERT INTO orders (customer_name, date) VALUES ('Harry', '2022-11-25');
INSERT INTO orders (customer_name, date) VALUES ('Jack', '2022-11-24');
