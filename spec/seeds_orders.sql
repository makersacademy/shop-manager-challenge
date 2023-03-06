TRUNCATE TABLE orders RESTART IDENTITY cascade;

INSERT INTO orders (customer_name, order_date) VALUES ('Harry', '2023-03-04');
INSERT INTO orders (customer_name, order_date) VALUES ('Ron', '2023-03-05');
INSERT INTO orders (customer_name, order_date) VALUES ('Hermione', '2023-03-04');
INSERT INTO orders (customer_name, order_date) VALUES ('Albus', '2023-02-24');
INSERT INTO orders (customer_name, order_date) VALUES ('Severus', '2023-03-05');