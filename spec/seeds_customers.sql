TRUNCATE TABLE customers RESTART IDENTITY CASCADE; 

INSERT INTO customers (name) VALUES 
('Customer_1'),
('Customer_2'),
('Customer_3'),
('Customer_4'),
('Customer_5')
;