TRUNCATE TABLE items RESTART IDENTITY CASCADE; -- replace with your own table name.
TRUNCATE TABLE orders RESTART IDENTITY CASCADE; -- replace with your own table name.
TRUNCATE TABLE items_orders RESTART IDENTITY CASCADE; -- replace with your own table name.



INSERT INTO items (id, name, unit_price, quantity) VALUES
(1, 'screws', 5, 100),
(2, 'hammer', 20, 4),
(3, 'glue', 2, 30),
(4, 'tape measure', 7, 8),
(5, 'level', 17, 70);


INSERT INTO orders (id, customer_name, date) VALUES
(1, 'Ben W', 'Jan-08-1999'),
(2, 'Bob H', 'Nov-26-2017'),
(3, 'Bill Z', 'Jul-22-2034');

INSERT INTO items_orders (item_id, order_id) VALUES
(2, 1),
(3, 2),
(5, 2),
(1, 3),
(2, 3),
(3, 3),
(4, 3),
(5, 3);


ALTER TABLE items_orders ADD FOREIGN KEY (item_id) REFERENCES items(id);
ALTER TABLE items_orders ADD FOREIGN KEY (order_id) REFERENCES orders(id);
