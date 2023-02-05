TRUNCATE TABLE orders,items RESTART IDENTITY; 

INSERT INTO items (name, price, quantity) VALUES ('Notebook', 1, 10);
INSERT INTO items (name, price, quantity) VALUES ('Shirt', 5, 6);
INSERT INTO items (name, price, quantity) VALUES ('Trousers', 10, 15);
INSERT INTO items (name, price, quantity) VALUES ('Boots', 20, 5);

INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Janet', '2023-01-2', 1);
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Aaron', '2022-12-12', 3);
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Emily', '2022-10-23', 2);
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Camille', '2023-01-24', 4);





