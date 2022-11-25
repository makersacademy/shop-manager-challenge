TRUNCATE TABLE orders RESTART IDENTITY CASCADE; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO orders (customer, order_date, item_id) VALUES ('Jake', 01.01.2022, 1);
INSERT INTO orders (customer, order_date, item_id) VALUES ('Sophie', 02.09.2022, 2);