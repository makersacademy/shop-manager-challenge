TRUNCATE items, orders RESTART IDENTITY;


INSERT INTO items (name, unit_price, quantity) VALUES ('Bag', 35.5, 23);
INSERT INTO items (name, unit_price, quantity) VALUES ('Lipstick', 15, 49);
INSERT INTO items (name, unit_price, quantity) VALUES ('Mascara', 18.4, 4);

INSERT INTO orders (customer_name, date, item_id) VALUES ('Lucas Smith', '2022-10-28', 1);
INSERT INTO orders (customer_name, date, item_id) VALUES ('Abigail Brown', '2022-11-28', 3);
INSERT INTO orders (customer_name, date, item_id) VALUES ('Sally Bright', '2022-11-16', 1);


