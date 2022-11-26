TRUNCATE TABLE orders RESTART IDENTITY CASCADE;

INSERT INTO orders (customer_name, date_placed, quantity, item_id) VALUES ('Aaa Bbb', '2022-11-21');
INSERT INTO orders (customer_name, date_placed, quantity, item_id) VALUES ('Ccc Ddd', '2022-10-17');
INSERT INTO orders (customer_name, date_placed, quantity, item_id) VALUES ('Eee Fff', '1994-03-16');
