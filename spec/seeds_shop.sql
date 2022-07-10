TRUNCATE TABLE items RESTART IDENTITY CASCADE;
TRUNCATE TABLE ordes RESTART IDENTITY;



INSERT INTO items (item, price, quantity) VALUES
('item1','1', '1'),
('item2','2', '2'),
('item3','3', '3');

------------------------------





INSERT INTO orders (customer_name, date_ordered, item_id) VALUES
('customer1', '1/1/11', '1'),
('customer2', '2/2/22', '2'),
('customer3', '3/3/33', '3');

