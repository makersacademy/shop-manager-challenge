TRUNCATE TABLE orders RESTART IDENTITY CASCADE;

INSERT INTO orders (customer_name, date_placed) VALUES ('Aaa Bbb', '2022-11-21');
INSERT INTO orders (customer_name, date_placed) VALUES ('Ccc Ddd', '2022-10-17');
INSERT INTO orders (customer_name, date_placed) VALUES ('Eee Fff', '1994-03-16');
INSERT INTO orders (customer_name, date_placed) VALUES ('Ggg Hhh', '2015-07-21');
