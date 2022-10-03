TRUNCATE items, orders, orders_items RESTART IDENTITY;

INSERT INTO items (name, price, quantity) VALUES
('Russell Hobbs Microwave', 69.00, 10),
('Bush Electric Oven', 139.00, 5),
('Rug Doctor Carpet Cleaner', 134.99, 8),
('SodaStream Spirit Machine', 70.00, 20),
('Gtech Cordless Vacuum Cleaner', 129.99, 4),
('NutriBullet Blender', 134.00, 10),
('Morphy Richards 4 Slice Toaster', 39.99, 30),
('Challenge Chrome Tilting Desk Fan', 18.00, 4),
('Henry Allergy Vacuum Cleaner', 199.99, 7),
('LG Tumble Dryer', 770.00, 2);

INSERT INTO orders (customer_name, order_date) VALUES
('Kate', '2022-09-20'),
('John', '2022-09-18'),
('Josh', '2022-09-20'),
('Clara', '2022-09-10'),
('Milana', '2022-09-01'),
('Artem', '2022-09-20'),
('Valerie', '2022-09-15'),
('Natasha', '2022-09-20'),
('Max', '2022-09-07');

INSERT INTO orders_items (order_id, item_id) VALUES
(1, 2),
(1, 3),
(2, 4),
(2, 1),
(2, 6),
(3, 7),
(3, 8),
(4, 10),
(5, 6),
(6, 9),
(6, 3),
(7, 1),
(8, 10),
(9, 9);
