TRUNCATE TABLE orders RESTART IDENTITY CASCADE; -- replace with your own table name.

INSERT INTO orders (customer_name, date, item_id) VALUES ('Brain', '2022-09-04', 1);
INSERT INTO orders (customer_name, date, item_id) VALUES ('Lily', '2022-09-07', 2);