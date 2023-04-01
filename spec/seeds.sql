TRUNCATE TABLE items, orders, items_orders RESTART IDENTITY;

INSERT INTO items (name, price, quantity) VALUES
('milk', 2, 50),
('bread', 3, 30),
('cake', 9, 10),
('bananas', 4, 100),
('broccoli', 1, 45),
('rare item', 1000, 1);

INSERT INTO orders (customer, date) VALUES
('Quack Overflow', '04/01/23'),
('Scrooge McDuck', '03/31/23'),
('Silly Goose', '03/30/23');

INSERT INTO items_orders (item_id, order_id) VALUES
(1, 1),
(2, 1),
(2, 3),
(3, 1),
(4, 1),
(4, 3),
(5, 1),
(5, 2),
(5, 3);
