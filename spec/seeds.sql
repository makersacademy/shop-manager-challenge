TRUNCATE TABLE items, orders, items_orders RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO items (name, price, quantity) VALUES ('Bread', 2.50, 10);
INSERT INTO items (name, price, quantity) VALUES ('Towels', 9, 5);
INSERT INTO items (name, price, quantity) VALUES ('Soap', 3.25, 15);
INSERT INTO items (name, price, quantity) VALUES ('Salad', 4.75, 10);
INSERT INTO items (name, price, quantity) VALUES ('Pizza', 7.25, 7);
INSERT INTO items (name, price, quantity) VALUES ('Gloves', 19.99, 3);
INSERT INTO items (name, price, quantity) VALUES ('Sausages', 3.75, 11);
INSERT INTO items (name, price, quantity) VALUES ('Cheese', 3.50, 25);
INSERT INTO items (name, price, quantity) VALUES ('Chair', 55, 1);
INSERT INTO items (name, price, quantity) VALUES ('Orange juice', 1.75, 2);

INSERT INTO orders (customer_name, date) VALUES ('Rodney Howell', '3 May 2023');
INSERT INTO orders (customer_name, date) VALUES ('Lynn Stiedemann', '10 May 2023');

INSERT INTO items_orders (item_id, order_id) VALUES (1, 1);
INSERT INTO items_orders (item_id, order_id) VALUES (7, 1);
INSERT INTO items_orders (item_id, order_id) VALUES (10, 1);
INSERT INTO items_orders (item_id, order_id) VALUES (9, 2);
INSERT INTO items_orders (item_id, order_id) VALUES (2, 2);
