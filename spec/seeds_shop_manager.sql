TRUNCATE TABLE items RESTART IDENTITY CASCADE; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO items (name, unit_price, quantity) VALUES ('item 1', 1.11, 1);
INSERT INTO items (name, unit_price, quantity) VALUES ('item 2', 22.22, 22);
INSERT INTO items (name, unit_price, quantity) VALUES ('item 3', 333.33, 333);
INSERT INTO items (name, unit_price, quantity) VALUES ('item 4', 4444.44, 4444);

INSERT INTO orders (customer_name, order_date, item_id) VALUES ('customer 1', '2022-01-25', 1);
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('customer 2', '2022-12-01', 2);
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('customer 3', '2021-01-03', 2);
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('customer 4', '2022-03-19', 3);
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('customer 5', '2022-02-01', 1);
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('customer 6', '2021-04-03', 3);
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('customer 7', '2022-05-30', 1);
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('customer 8', '2022-11-25', 4);
