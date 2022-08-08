TRUNCATE TABLE items, orders RESTART IDENTITY;

INSERT INTO items (name, unit_price, quantity) VALUES ('Bananas', 1.00, 5);
INSERT INTO items (name, unit_price, quantity) VALUES ('Pasta', 2.00, 10);
INSERT INTO items (name, unit_price, quantity) VALUES ('Fish', 4.00, 8);
INSERT INTO orders (customer_name, date, item_id) VALUES ('Sophie', '2022-08-05 12:00:00', 1);
INSERT INTO orders (customer_name, date, item_id) VALUES ('Mabon', '2022-08-04 11:00:00', 2);
INSERT INTO orders (customer_name, date, item_id) VALUES ('Twm', '2022-08-03 15:00:00', 3);
