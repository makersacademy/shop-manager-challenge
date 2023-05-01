TRUNCATE TABLE orders RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO orders (customer_name, date, item_id) VALUES ('David', '03/03/2023', 1);
INSERT INTO orders (customer_name, date, item_id) VALUES ('David', '01/05/2023', 1);
INSERT INTO orders (customer_name, date, item_id) VALUES ('Anna', '01/05/2023', 2);