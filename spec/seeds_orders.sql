TRUNCATE TABLE items, orders, items_orders RESTART IDENTITY; 

INSERT INTO items (name, price, quantity) VALUES 
('item_one', 1, 1),
('item_two', 2, 2),
('item_three', 3, 3),
('item_four', 4, 4),
('item_five', 5, 5);

INSERT INTO orders (customer_name, order_date) VALUES	
('Jeff', '2023-10-16'),
('John', '2023-11-16'),
('Jerry', '2023-12-16'),
('George', '2024-01-16');


INSERT INTO items_orders (item_id, order_id)
		VALUES(1, 1), (2, 4), (3, 2), (4, 3), (5, 1);