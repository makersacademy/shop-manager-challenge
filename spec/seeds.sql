TRUNCATE TABLE items, orders, items_orders RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO items (id, name, price, quantity) VALUES (1, 'Bread', 2.50, 10);
INSERT INTO items (id, name, price, quantity) VALUES (2, 'Towels', 9, 5);
INSERT INTO items (id, name, price, quantity) VALUES (3, 'Soap', 3.25, 15);
INSERT INTO items (id, name, price, quantity) VALUES (4, 'Salad', 4.75, 10);
INSERT INTO items (id, name, price, quantity) VALUES (5, 'Pizza', 7.25, 7);
INSERT INTO items (id, name, price, quantity) VALUES (6, 'Gloves', 19.99, 3);
INSERT INTO items (id, name, price, quantity) VALUES (7, 'Sausages', 3.75, 11);
INSERT INTO items (id, name, price, quantity) VALUES (8, 'Cheese', 3.50, 25);
INSERT INTO items (id, name, price, quantity) VALUES (9, 'Chair', 55, 1);
INSERT INTO items (id, name, price, quantity) VALUES (10, 'Orange juice', 1.75, 2);

INSERT INTO orders (id, customer_name, date) VALUES (1, 'Rodney Howell', '3 May 2023');
INSERT INTO orders (id, customer_name, date) VALUES (2, 'Lynn Stiedemann', '10 May 2023');

INSERT INTO items_orders (item_id, order_id) VALUES (1, 1);
INSERT INTO items_orders (item_id, order_id) VALUES (7, 1);
INSERT INTO items_orders (item_id, order_id) VALUES (10, 1);
INSERT INTO items_orders (item_id, order_id) VALUES (9, 2);
INSERT INTO items_orders (item_id, order_id) VALUES (2, 2);
