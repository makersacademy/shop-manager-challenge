TRUNCATE TABLE orders RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Henry Smith', '12/02/2023', 1);
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('James Does', '05/07/2002', 2);