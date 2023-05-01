TRUNCATE TABLE orders RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO orders (customer_name, date, item_id) VALUES ('David', '2023/03/03', 1);
INSERT INTO orders (customer_name, date, item_id) VALUES ('David', '2023/05/01', 1);
INSERT INTO orders (customer_name, date, item_id) VALUES ('Anna', '2023/05/01', 2);