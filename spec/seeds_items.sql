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
('Cheese', 15, 50),
('Jam', 15, 88),
('Chicken', 18, 40)
;
