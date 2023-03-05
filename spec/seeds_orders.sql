TRUNCATE TABLE orders, items RESTART IDENTITY; 

INSERT INTO orders (customer_name, order_date) VALUES ('Sarah', '3/3/2023');
INSERT INTO orders (customer_name, order_date) VALUES ('Emma', '2/3/2023');

INSERT INTO items (item_name, price, quantity, order_id) VALUES ('Super Shark Vacuum Cleaner', '199', '60', '1');
INSERT INTO items (item_name, price, quantity, order_id) VALUES ('Makerspresso Coffee Machine', '90', '20', '1');
INSERT INTO items (item_name, price, quantity, order_id) VALUES ('iPhone 14', '800', '50', '2');