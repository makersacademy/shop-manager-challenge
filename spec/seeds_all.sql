TRUNCATE TABLE items, orders RESTART IDENTITY;

INSERT INTO items ("name", "unit_price", "quantity") VALUES
('Super Shark Vacuum Cleaner', 99, 30),
('Makerspresso Coffee Machine', 69, 15),
('Porridge Oats', 2, 100),
('Avocado', 1.49, 17);

INSERT INTO orders ("customer_name", "order_date", "item_id") VALUES
('Alex Hoggett', '12th Dec 2021', 2),
('Shaun Flood', '22th Feb 2021', 1),
('Lorna Powell', '16th Mar 2021', 3);