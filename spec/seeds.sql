TRUNCATE TABLE items RESTART IDENTITY CASCADE;
TRUNCATE TABLE orders RESTART IDENTITY;

INSERT INTO items (name, price) VALUES ('KitKat', 1.00);
INSERT INTO items (name, price) VALUES ('PS5', 499.99);
INSERT INTO items (name, price) VALUES ('Notepad', 1.50);

INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Alex', '2022-06-28', 1);
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Bob', '2022-01-01', 2);
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Jemima', '2022-07-01', 1);