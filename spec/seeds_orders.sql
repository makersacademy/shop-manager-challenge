TRUNCATE TABLE orders RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO orders (customer_name, date, item_id) VALUES ('Maya', '2004-11-03 15:40:12', '2');
INSERT INTO orders (customer_name, date, item_id) VALUES ('Anna', '2004-10-19 10:23:54', '1');