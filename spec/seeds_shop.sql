TRUNCATE TABLE items,orders,items_orders RESTART IDENTITY; 


INSERT INTO items (item_name,item_price,item_quantity) VALUES 
('Dyson Vaccum', '319','10'),
('Fitbit Sense 2', '90','30'),
('Galaxy Tab A8', '179','15'),
('Tefal Air Fryer', '99','21'),
('Nutribullet', '29','10'),
('Oral B CrossAction Toothbrush', '24','52');


INSERT INTO orders (customer_name,order_date) VALUES 
('Aimee', '02-12-22'),
('Zack', '04-12-22'),
('Chloe', '02-04-22'),
('Matthew', '05-03-22');


INSERT INTO items_orders(item_id,order_id) VALUES 
(1,2),
(2,2),
(3,1),
(4,4),
(5,3),
(6,1);
