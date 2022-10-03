TRUNCATE TABLE items, orders RESTART IDENTITY;

INSERT INTO items (name, unit_price, quantity) VALUES ( 'Royal Canin kitten food', '5', '20');
INSERT INTO items (name, unit_price, quantity) VALUES ( 'Organic tomatoes', '3', '10');
INSERT INTO items (name, unit_price, quantity) VALUES ( 'Celery', '2', '7');
INSERT INTO items (name, unit_price, quantity) VALUES ( 'Scottish salmon', '6', '9');
INSERT INTO items (name, unit_price, quantity) VALUES ( 'Baby leaves', '3', '15');

INSERT INTO orders (customer_name, date, item_id) VALUES ('Alice', '2022-09-15', '1');
INSERT INTO orders (customer_name, date, item_id) VALUES ('Pedro', '2022-08-30', '2');
INSERT INTO orders (customer_name, date, item_id) VALUES ('Hannah', '2022-10-01', '5');





