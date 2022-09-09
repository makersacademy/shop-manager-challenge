TRUNCATE TABLE items, orders, items_orders RESTART IDENTITY;

INSERT INTO items (name, unit_price, quantity) VALUES 
('White Desk Lamp', 18, 12),
('Mahogani Dining Table', 235, 5),
('Oak Bookshelf', 80, 15),
('Oriental Rug', 139, 21),
('Aloe Vera Houseplant', 12, 150),
('Leather Sofa', 1699, 2);

INSERT INTO orders (customer_name, date_placed) VALUES
('John Treat', '2022-08-12'),
('Amelia Macfarlane', '2022-08-14'),
('Eleanor Borgate', '2022-09-02');

INSERT INTO items_orders (item_id, order_id) VALUES
(3, 1),
(4, 1),
(6, 1),
(1, 2),
(5, 3),
(1, 3),
(3, 3);

