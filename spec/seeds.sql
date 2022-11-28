TRUNCATE TABLE items, orders, items_orders RESTART IDENTITY; 

INSERT INTO items (name, unit_price, quantity) VALUES 
('Kitchen Towel', 2, 25),
('Cling Film', 1, 41),
('Washing Up Liquid', 3, 32),
('Washing Powder', 10, 71),
('Soap', 4, 80);

INSERT INTO orders (customer, date) VALUES 
('Bruce', '03-06-22'),
('Clark', '05-07-22'),
('Diana', '07-08-22');

INSERT INTO items_orders (item_id, order_id) VALUES 
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(2, 2),
(3, 2),
(1, 3),
(5, 3);