TRUNCATE TABLE items RESTART IDENTITY CASCADE;
TRUNCATE TABLE orders RESTART IDENTITY CASCADE;

INSERT INTO items (name, unit_price, quantity) VALUES
('Hammer', 5.99, 20),
('Duct Tape', 2.50, 50),
('Nails (0.5kg)', 4.50, 50),
('Drill', 49.99, 7);

INSERT INTO orders (customer_name, date_placed) VALUES
('Customer One', '2022-01-01'),
('Customer Two', '2022-01-02'),
('Customer Three', '2022-01-02'),
('Customer One', '2022-01-03'),
('Customer Four', '2022-01-07'),
('Customer Four', '2022-01-08');

INSERT INTO items_orders (item_id, order_id) VALUES
(1,1),
(3,1),
(4,1),
(1,2),
(4,3),
(2,4),
(2,5),
(1,6),
(3,6);

ALTER TABLE items_orders ADD FOREIGN KEY (item_id) REFERENCES items(id);
ALTER TABLE items_orders ADD FOREIGN KEY (order_id) REFERENCES orders(id);