TRUNCATE TABLE orders RESTART IDENTITY;

INSERT INTO orders (customer_name, order_date, item_id) VALUES ('John Smith', 'Jan-01-2023', 1);
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Harry Styles', 'Jan-02-2023', 2);
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Megan Rapinoe', 'Jan-03-2023', 2);
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Lorenzo Raeti', 'Jan-06-2023', 1);
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Phil Bravo', 'Jan-08-2023', 3);
