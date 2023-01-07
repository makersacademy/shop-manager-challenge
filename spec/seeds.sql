TRUNCATE TABLE items, orders, items_orders RESTART IDENTITY; 
INSERT INTO orders (date, customer_name) VALUES ('2023-01-01', 'John Smith');
INSERT INTO orders (date, customer_name) VALUES ('2023-01-02', 'Jane Doe');
INSERT INTO orders (date, customer_name) VALUES ('2023-01-03', 'Joe Burgess');
INSERT INTO orders (date, customer_name) VALUES ('2023-01-04', 'Elise Beer');
INSERT INTO orders (date, customer_name) VALUES ('2023-01-06', 'James Dean');

INSERT INTO items (name, price, quantity) VALUES ('Apple', '1', '100');
INSERT INTO items (name, price, quantity) VALUES ('Orange', '1', '120' );
INSERT INTO items (name, price, quantity) VALUES ('Chocolate Bar', '3', '50');
INSERT INTO items (name, price, quantity) VALUES ('Crisp Pack', '2', '200');
INSERT INTO items (name, price, quantity) VALUES ('Sirloin Steak', '5', '10');
INSERT INTO items (name, price, quantity) VALUES ('Chicken Breast', '4', '20');

INSERT INTO items_orders (item_id, order_id) VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 1),
(2, 2),
(3, 4),
(3, 5),
(4, 3),
(4, 4),
(4, 5),
(5, 2),
(5, 3),
(5, 4),
(6, 5);