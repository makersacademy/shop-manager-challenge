TRUNCATE TABLE items, orders RESTART IDENTITY;

INSERT INTO items (name, unit_price, quantity) VALUES ('cereal', 3, 50);
INSERT INTO items (name, unit_price, quantity) VALUES ('tea', 2, 100);

INSERT INTO orders (customer_name, date, item_id) VALUES ('customer_1', '2023-01-10 14:10:05', 1);
INSERT INTO orders (customer_name, date, item_id) VALUES ('customer_2', '2023-01-08 13:30:10', 2);
INSERT INTO orders (customer_name, date, item_id) VALUES ('customer_3', '2023-01-20 16:15:03', 1);