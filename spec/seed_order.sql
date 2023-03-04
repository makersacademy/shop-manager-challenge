TRUNCATE TABLE orders RESTART IDENTITY;

INSERT INTO orders (date, customer, item_id) VALUES ('2022-07-23', 'Ayoub', 1);

INSERT INTO orders (date, customer, item_id) VALUES ('2023-01-16', 'Makers', 2);
