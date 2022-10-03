TRUNCATE TABLE items, orders RESTART IDENTITY;

INSERT INTO orders (customer_name, date) VALUES ('Joe', 'sept');
INSERT INTO orders (customer_name, date) VALUES ('Dave', 'oct');

INSERT INTO items (item_name, price, quantity, order_id) VALUES ('cheese', 2, 5, 1);
INSERT INTO items (item_name, price, quantity, order_id) VALUES ('hot crossed buns', 3, 10, 1);
INSERT INTO items (item_name, price, quantity, order_id) VALUES ('sausage', 1, 5, 2);

