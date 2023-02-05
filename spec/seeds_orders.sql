TRUNCATE TABLE orders RESTART IDENTITY; 

INSERT INTO orders (customer, date, item_id) VALUES ('Dai Jones', '30/01/2023', '1');
INSERT INTO orders (customer, date, item_id) VALUES ('Bobby Price', '02/04/2023', '2');