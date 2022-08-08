

TRUNCATE TABLE products, orders RESTART IDENTITY;


INSERT INTO products (name, unit_price, quantity) VALUES ('Super Shark Vacuum Cleaner', 99, 30);  --1
INSERT INTO products (name, unit_price, quantity) VALUES ('Makerspresso Coffee Machine', 69, 15);  --2
INSERT INTO products (name, unit_price, quantity) VALUES ('iOrange Pro Max 15', 1000, 10);  --3
INSERT INTO products (name, unit_price, quantity) VALUES ('CannonBall Printer', 200, 22);  --4
INSERT INTO products (name, unit_price, quantity) VALUES ('Tony 55inch LED TV', 400, 56);  --5



INSERT INTO orders (customer_name, date_order_placed, product_id) VALUES ('John', '2022-07-01', 1);  --1
INSERT INTO orders (customer_name, date_order_placed, product_id) VALUES ('Alice', '2022-07-30', 3);  --2
INSERT INTO orders (customer_name, date_order_placed, product_id) VALUES ('Bob', '2022-07-31', 2);  --3
INSERT INTO orders (customer_name, date_order_placed, product_id) VALUES ('Mike', '2022-08-05', 4);  --4
INSERT INTO orders (customer_name, date_order_placed, product_id) VALUES ('Nathan', '2022-08-07', 1);  --5
INSERT INTO orders (customer_name, date_order_placed, product_id) VALUES ('Lorraine', '2022-08-08', 5);  --6


