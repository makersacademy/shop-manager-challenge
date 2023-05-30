TRUNCATE TABLE orders RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO orders (customer_name, date_of_order) VALUES('Khuslen', '2023-05-26');
INSERT INTO orders (customer_name, date_of_order) VALUES('John', '2023-05-25');