TRUNCATE TABLE items, orders, items_orders RESTART IDENTITY;

INSERT INTO items (item_name, item_price, item_quantity) VALUES 
('Smart Watch', '250.0', '60'),
('USB C to USB adapter', '8.99', '430'),
('Wireless Earbuds', '24.64', '34'),
('Shower Head and Hose', '16.99', '4');

INSERT INTO orders (customer_name, order_date) VALUES 
('Jimothy', '2022-05-07'),
('Nick', '2022-04-25');

INSERT INTO items_orders (item_id, order_id) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 2),
(1, 2);