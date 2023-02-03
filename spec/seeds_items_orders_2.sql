TRUNCATE TABLE items, orders, items_orders RESTART IDENTITY;

INSERT INTO items (name, price, quantity) VALUES
('Apple', 2, 10),
('Orange', 3, 5),
('Peach', 10, 3),
('Tomato', 4, 30),
('Banana', 5, 50);

INSERT INTO orders (customer_name, placed_date) VALUES
('Ryan','08-Jan-2023'),
('Edward','10-Feb-2023'),
('James','14-Mar-2023');

INSERT INTO items_orders (order_id, item_id, item_count) VALUES
(1, 1, 2),
(1, 2, 1),
(2, 3, 1),
(2, 5, 1),
(3, 4, 1),
(3, 2, 1),
(3, 1, 1);
