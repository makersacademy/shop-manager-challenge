TRUNCATE TABLE stocks, orders, order_items RESTART IDENTITY; -- replace with your own table name.
 -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO stocks (item_name, unit_price, quantity) VALUES ('item_1', '10', '100');
INSERT INTO stocks (item_name, unit_price, quantity) VALUES ('item_2', '22', '150');
INSERT INTO orders (customer_name, date, stock_id ) VALUES ('David', '01/04/22', '1');
INSERT INTO orders (customer_name, date, stock_id ) VALUES ('Anna', '01/05/22', '2');
INSERT INTO order_items (order_id, stock_id) VALUES ('1', '2');
INSERT INTO order_items (order_id, stock_id) VALUES ('2', '1');