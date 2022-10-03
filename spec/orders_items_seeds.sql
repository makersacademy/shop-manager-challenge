TRUNCATE items, orders, orders_items RESTART IDENTITY;

INSERT INTO items (name, price, quantity) VALUES
('Russell Hobbs Microwave', 69.00, 10),
('Bush Electric Oven', 139.00, 5),
('Rug Doctor Carpet Cleaner', 134.99, 8);

INSERT INTO orders (customer_name, order_date) VALUES
('Kate', '2022-09-20'),
('John', '2022-09-18'),
('Josh', '2022-09-20');

INSERT INTO orders_items (order_id, item_id) VALUES
(1, 2),
(1, 3),
(2, 2),
(3, 1),
(3, 3);