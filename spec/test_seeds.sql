TRUNCATE TABLE orders RESTART IDENTITY;
TRUNCATE TABLE items RESTART IDENTITY CASCADE; 

INSERT INTO items (name, price, quantity) VALUES ('Carbonara', 10, 2);
INSERT INTO items (name, price, quantity) VALUES ('Milk', 2, 3);
INSERT INTO orders (date, customer_name, item_id) VALUES ('2023-02-06', 'Paolo', 1);
INSERT INTO orders (date, customer_name, item_id) VALUES ('2023-02-21', 'Anna', 2);