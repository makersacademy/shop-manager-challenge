TRUNCATE TABLE items, orders, items_orders RESTART IDENTITY; 

INSERT INTO items (name, price, quantity) VALUES 
('item_one', 1, 1),
('item_two', 2, 2),
('item_three', 3, 3),
('item_four', 4, 4),
('item_five', 5, 5);