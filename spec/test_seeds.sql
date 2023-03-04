TRUNCATE TABLE orders RESTART IDENTITY;
TRUNCATE TABLE items RESTART IDENTITY CASCADE; 

INSERT INTO items (name, price, quantity) VALUES ('Carbonara', 10, 2);
INSERT INTO orders (date, customer_name, item_id) VALUES ('05/02/2023', 'Paolo', 1);