INSERT INTO items (name, price, quantity) VALUES 
('Bread', 1.50, 10),
('Milk', 2.50, 10),
('Eggs', 3.50, 10),
('Cheese', 4.50, 10),
('Butter', 5.50, 10),
('Apples', 6.50, 10),
('Oranges', 7.50, 10),
('Bananas', 8.50, 10),
('Peaches', 9.50, 10),
('Pears', 10.50, 10);

INSERT INTO orders (customer_name, order_date) VALUES 
('Thomas Mannion', '2022-01-01'),
('Makers', '2022-01-02'),
('John Smith', '2022-01-03');

INSERT INTO items_orders (item_id, order_id) VALUES 
(1, 1),
(2, 1),
(3, 1),
(4, 2),
(5, 2),
(6, 2),
(7, 3),
(8, 3),
(9, 3),
(10, 3);