TRUNCATE TABLE items, orders, items_orders RESTART IDENTITY;

INSERT INTO items (name, price, quantity) VALUES ('steak', 15, 10)
INSERT INTO items (name, price, quantity) VALUES ('baby corn', 1, 15)
INSERT INTO items (name, price, quantity) VALUES ('chicken thigh', 3, 10)
INSERT INTO items (name, price, quantity) VALUES ('cream', 1, 5)

INSERT INTO orders(customer_name, order_date) VALUES ('Edward', '03/01/2023')
INSERT INTO orders(customer_name, order_date) VALUES ('Gilberto', '04/01/2023')
INSERT INTO orders(customer_name, order_date) VALUES ('Pablo', '04/01/2023')

INSERT INTO items_orders (item_id, order_id) VALUES (1, 1)
INSERT INTO items_orders (item_id, order_id) VALUES (3, 1)
INSERT INTO items_orders (item_id, order_id) VALUES (2, 2)
INSERT INTO items_orders (item_id, order_id) VALUES (4, 3)