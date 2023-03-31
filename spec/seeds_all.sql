TRUNCATE TABLE items RESTART IDENTITY CASCADE; 

INSERT INTO items (name, unit_price, quantity) VALUES 
('Soap', 10, 100),
('Candy', 2, 500),
('Lamp', 400, 20),
('Chocolate', 5, 300),
('Coal', 100, 30),
('Shampoo', 25, 60),
('Peanut Butter', 12, 120),
('Bread', 8, 35),
('Cheese', 15, 0),
('Jam', 15, 88),
('Chicken', 18, 40)
;

TRUNCATE TABLE customers RESTART IDENTITY CASCADE; 

INSERT INTO customers (name) VALUES 
('Customer_1'),
('Customer_2'),
('Customer_3'),
('Customer_4'),
('Customer_5')
;

TRUNCATE TABLE orders RESTART IDENTITY;

INSERT INTO orders (item_id, customer_id, order_time) VALUES
(1, 3, '2023-01-08'),
(4, 3, '2023-01-08'),
(5, 3, '2023-01-08'),
(8, 3, '2023-01-08'),
(5, 3, '2023-02-18'),
(6, 3, '2023-02-18'),
(11, 3, '2023-02-18'),
(4, 1, '2023-01-08'),
(9, 1, '2023-01-08'),
(10, 1, '2023-01-08'),
(3, 1, '2023-01-12'),
(6, 2, '2023-01-17'),
(7, 2, '2023-01-17'),
(1, 4, '2023-02-11'),
(7, 4, '2023-02-11'),
(8, 4, '2023-01-15'),
(7, 4, '2023-03-01'),
(1, 5, '2023-02-22')
;

