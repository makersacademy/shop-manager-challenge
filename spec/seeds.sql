TRUNCATE TABLE items,orders RESTART IDENTITY CASCADE; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO items (name, unit_price, quantity) VALUES 
('item1', 10.0, 30),
('item2', 12.1, 22);

INSERT INTO orders (customer_name, order_date) VALUES 
('David', '2022-06-22 19:10:25'),
('Anna', '2022-07-22 19:10:25');
