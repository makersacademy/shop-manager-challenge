TRUNCATE TABLE items, orders, items_orders RESTART IDENTITY;

INSERT INTO items (name, price, quantity) VALUES
('Pen', '£1', '10'),
('Ruler', '£2', '15'),
('Rubber', '50p', '5'),
('Paper', '£2.50', '20');

INSERT INTO orders (customer, order_date) VALUES
('Sam', 'August'),
('Matt', 'June'),
('Max', 'October'),
('James', 'March'),
('Olly', 'April');

INSERT INTO items_orders (item_id, order_id) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 2),
(2, 3),
(1, 2),
(1, 4),
(3, 3),
(2, 4),
(3, 5);
