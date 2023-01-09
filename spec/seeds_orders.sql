TRUNCATE TABLE orders RESTART IDENTITY; 


INSERT INTO orders (customer_name, date, item_id) VALUES ('Harry', '2023/01/08', 1);
INSERT INTO orders (customer_name, date, item_id) VALUES ('Mary', '2022/12/11', 2);