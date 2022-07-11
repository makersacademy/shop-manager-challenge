TRUNCATE TABLE shop_items RESTART IDENTITY CASCADE; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO shop_items (item_name,unit_price,quantity) VALUES 
('Cheese', '3', 33),
('Cherries', '4', 368),
('Watermelon', '2.5', 99),
('Strawberries', '3.5', 150),
('Strawberries', '3.5', 150);

TRUNCATE TABLE orders RESTART IDENTITY CASCADE; 

INSERT INTO orders (customer_name,date) VALUES
('Irina', '2022/07/03'),
('Tim', '2022/07/01'),
('Julien', '2022/07/02'),
('Jane', '2022/06/01');


TRUNCATE TABLE orders_items RESTART IDENTITY CASCADE; 

INSERT INTO orders_items (order_id,item_id) VALUES
(1,3),
(1,1),
(1,2),
(2,4),
(2,5),
(3,1),
(3,2),
(3,5);