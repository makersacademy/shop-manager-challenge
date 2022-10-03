TRUNCATE TABLE items, orders, items_orders RESTART IDENTITY;

INSERT INTO items (id, name, price, quantity) VALUES
(1, 'Pen', '£1', '10'),
(2, 'Ruler', '£2', '15'),
(3, 'Rubber', '50p', '5'),
(4, 'Paper', '£2.50', '20');

INSERT INTO orders (id, customer, order_date) VALUES
(1, 'Sam', 'August'),
(2, 'Matt', 'June'),
(3, 'Max', 'October'),
(4, 'James', 'March'),
(5, 'Olly', 'April');

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
