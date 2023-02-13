TRUNCATE TABLE items, orders RESTART IDENTITY;

INSERT INTO orders (customer_name, order_date) VALUES ('Pedro Pascal', 'March 10');
INSERT INTO orders (customer_name, order_date) VALUES ('Alex de Souza', 'September 11');
INSERT INTO orders (customer_name, order_date) VALUES ('Princess Diana', 'January 5');

INSERT INTO items (title, price, stock, order_id) VALUES ('Sweater', 30, 5, 1);
INSERT INTO items (title, price, stock, order_id) VALUES ('Jeans', 40, 10, 2);
INSERT INTO items (title, price, stock, order_id) VALUES ('Skirt', 20, 7, 3);