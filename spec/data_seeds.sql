TRUNCATE TABLE items, orders RESTART IDENTITY;

INSERT INTO items (name, unit_price, quantity) VALUES
('Super Shark Vacuum Cleaner', 99.99, 3),
('Makerspresso Coffee Machine', 69.50, 5),
('ThomasTech Wireless Charger', 11.39, 1);

INSERT INTO orders (customer_name, date, item_id) VALUES
('John', '2022-06-20', 1),
('Grace', '2023-01-01', 2),
('Baz', '2021-07-29', 3);