TRUNCATE TABLE items, orders RESTART IDENTITY;

INSERT INTO items (name, unit_price, quantity) VALUES ('Super Shark Vacuum Cleaner', 99, 30);
INSERT INTO items (name, unit_price, quantity) VALUES ('Makerspresso Coffee Machine', 69, 15);

INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Mantas Volkauskas', '7 Jan 2023', 2);
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Bob Boberto', '25 Dec 2022', 2);