TRUNCATE TABLE items, orders RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO items (name, unit_price, item_quantity) VALUES ('Mascara', 9, 30);
INSERT INTO items (name, unit_price, item_quantity) VALUES ('Foundation', 42, 40);
INSERT INTO items (name, unit_price, item_quantity) VALUES ('Lipstick', 19, 15);
INSERT INTO items (name, unit_price, item_quantity) VALUES ('Blusher', 22, 10);

INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Cindy', '2023-03-05', 2);
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Lucy', '2023-03-03', 2);
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Jane', '2023-03-01', 1);
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Alex', '2023-03-01', 4);
