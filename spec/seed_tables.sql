TRUNCATE TABLE orders, items RESTART IDENTITY;

INSERT INTO items (name, price, quantity) VALUES ('Book case', '300', 5);
INSERT INTO items (name, price, quantity) VALUES ('Chicken treats', '3', 30);

INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Chris', '01/10/2022', 1);
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Forest', '01/10/2022', 2);