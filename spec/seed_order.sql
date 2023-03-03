TRUNCATE TABLE orders, items RESTART IDENTITY;

INSERT INTO orders (date, customer) VALUES ('2022-07-23', 'Ayoub');

INSERT INTO orders (date, customer) VALUES ('2023-01-16', 'Makers');
