TRUNCATE TABLE shop_items, orders RESTART IDENTITY;

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO shop_items (name, unit_price, quantity) VALUES ('Super Shark Vacuum Cleaner', 99.99, 30);
INSERT INTO shop_items (name, unit_price, quantity) VALUES ('Makerspresso', 69.00, 15);

-- timestamp format - YYYY-MM-DD HH:MI:SS
INSERT INTO orders (customer_name, date_placed, shop_item_id) VALUES ('Sarah', '2023-04-06 12:57:03', 1);
INSERT INTO orders (customer_name, date_placed, shop_item_id) VALUES ('Fred', '2023-03-12 15:12:42', 2);