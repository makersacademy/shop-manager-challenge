TRUNCATE TABLE orders RESTART IDENTITY CASCADE;

INSERT INTO orders (customer_name, order_date) values('Joe Bloggs', '2023-03-30');
INSERT INTO orders (customer_name, order_date) values('John Smith', '2023-03-31');
INSERT INTO orders (customer_name, order_date) values('Harry Kane', '2023-04-01');