TRUNCATE TABLE items, orders RESTART IDENTITY CASCADE; 

INSERT INTO items (name, price, qty) VALUES ('Shirt', '15', '50');
INSERT INTO items (name, price, qty) VALUES ('Sweat', '30', '100');
INSERT INTO orders (customer, date, item_id) VALUES ('Dai Jones', '01/30/2023', '1');
INSERT INTO orders (customer, date, item_id) VALUES ('Bobby Price', '02/03/2023', '2');