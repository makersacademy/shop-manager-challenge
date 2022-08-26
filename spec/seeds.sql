TRUNCATE TABLE items, orders, items_orders RESTART IDENTITY;

INSERT INTO items (name, unit_price, quantity) VALUES ('iPhone', 20, 5);
INSERT INTO items (name, unit_price, quantity) VALUES ('Tv', 50, 10);
INSERT INTO items (name, unit_price, quantity) VALUES ('Apple', 10, 8);


INSERT INTO orders (customer_name, date) VALUES ('Penaldo', '2022-03-01');
INSERT INTO orders (customer_name, date) VALUES ('Penzema', '2022-12-04');
INSERT INTO orders (customer_name, date) VALUES ('Messi', '2022-10-06');


INSERT INTO items_orders (item_id, order_id) VALUES
(1,1),
(2,2),
(3,2),(3,3);