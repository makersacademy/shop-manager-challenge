TRUNCATE TABLE orders RESTART IDENTITY CASCADE;

INSERT INTO orders (customer_name, date_placedd) VALUES ('Aaa Bbb', '2022-11-21');
INSERT INTO orders (customer_name, date_placedd) VALUES ('Ccc Ddd', '2022-10-17');
INSERT INTO orders (customer_name, date_placedd) VALUES ('Eee Fff', '1994-03-16');
INSERT INTO orders (customer_name, date_placedd) VALUES ('Ggg Hhh', '2015-07-21');
