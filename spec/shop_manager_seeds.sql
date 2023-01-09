TRUNCATE TABLE items, orders RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO items (item_name, unit_price, quantity) VALUES ('Fanta', 1, 300);
INSERT INTO items (item_name, unit_price, quantity) VALUES ('Coke', 2, 400);
INSERT INTO orders (customer_name, item_name, order_date, item_id) VALUES ('Brenda','Fanta', '2023-01-01', 1);
INSERT INTO orders (customer_name, item_name, order_date, item_id) VALUES ('Keith', 'Coke', '2022-12-31', 2);