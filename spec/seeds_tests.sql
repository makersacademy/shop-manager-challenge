TRUNCATE TABLE items, orders RESTART IDENTITY;

INSERT INTO items (name, unit_price, quantity) VALUES ('Super Shark Vacuum Cleaner', 99, 30);
INSERT INTO items (name, unit_price, quantity) VALUES ('Makerspresso Coffee Machine', 69, 15);

INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Mantas Volkauskas', '2023-01-07', 2);
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Bob Boberto', '2022-12-25', 2);