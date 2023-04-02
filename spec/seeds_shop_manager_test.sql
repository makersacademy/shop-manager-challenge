-- database_name shop_manager_test
-- file (./spec/seeds_shop_manager_test.sql)

TRUNCATE TABLE items RESTART IDENTITY CASCADE;
TRUNCATE TABLE orders RESTART IDENTITY;

INSERT INTO items (name, price, quantity) VALUES ('hammer', 5.99, 10);
INSERT INTO items (name, price, quantity) VALUES ('glue', 2.99, 5);

INSERT INTO orders (customer, date, order_id) VALUES ('chris', '08-Jan-1999', 1);
INSERT INTO orders (customer, date, order_id) VALUES ('tom', '09-Jan-2003', 1);
