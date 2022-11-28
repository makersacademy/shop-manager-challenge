
TRUNCATE TABLE orders RESTART IDENTITY;

INSERT INTO orders (customer_name, date, item_id) VALUES ('Monika Geller', '01.02.1995', '2');
INSERT INTO orders (customer_name, date, item_id) VALUES ('Chandler Bing', '02.03.1996', '1');
INSERT INTO orders (customer_name, date, item_id)  VALUES ('Pheobe Buffay', '04.12.1997', '3');
