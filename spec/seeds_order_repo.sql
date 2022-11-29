TRUNCATE TABLE orders RESTART IDENTITY; 

INSERT INTO orders (id, customer, date, order_id) VALUES ('1', 'Alex', '16/6/2016', '1');
INSERT INTO orders (id, customer, date, order_id) VALUES ('2', 'Frankie', '17/6/2016', '2');