TRUNCATE TABLE orders RESTART IDENTITY CASCADE;
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Ana', '01/01/2023', '001');
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Sam', '02/01/2023', '002');
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Jane', '03/01/2023', '003');
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Carol', '04/01/2023', '004');
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Ana', '01/01/2023', '005');
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Ana', '01/01/2023', '006');
