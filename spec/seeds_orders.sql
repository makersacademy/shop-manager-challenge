TRUNCATE TABLE orders RESTART IDENTITY CASCADE; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO orders (customer, order_date, item_id) VALUES ('Jake', '2022-01-30', 1);
INSERT INTO orders (customer, order_date, item_id) VALUES ('Sophie', '2022-01-01', 2);