TRUNCATE TABLE orders RESTART IDENTITY CASCADE; 


INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Peter', '01/01/2023', '001');
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('John', '02/01/2023', '002');
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Jane', '03/01/2023', '003');
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Jessica', '04/01/2023', '004');
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Kate', '05/01/2023', '005');
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Luisa', '06/01/2023', '006');