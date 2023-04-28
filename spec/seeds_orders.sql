TRUNCATE TABLE orders RESTART IDENTITY;

INSERT INTO orders (customer_name, order_date, item_id ) VALUES ('Jack Skates', '2023-04-28', 1 );
INSERT INTO orders (customer_name, order_date, item_id ) VALUES ('Charlie Kelly', '2020-08-12', 2 );