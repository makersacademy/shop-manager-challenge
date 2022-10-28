TRUNCATE TABLE items RESTART IDENTITY CASCADE;
TRUNCATE TABLE orders RESTART IDENTITY CASCADE;
TRUNCATE TABLE orders_items RESTART IDENTITY;

INSERT INTO items (item_name, item_price, item_quantity) VALUES ('Sherbet Lemons', 1, 500);
INSERT INTO items (item_name, item_price, item_quantity) VALUES ('Starmix', 3, 250);
INSERT INTO items (item_name, item_price, item_quantity) VALUES ('Candy Apple', 5, 20);
INSERT INTO items (item_name, item_price, item_quantity) VALUES ('Foam Bananas', 1, 40);
INSERT INTO items (item_name, item_price, item_quantity) VALUES ('Lollipops', 2, 650); 

INSERT INTO orders (customer_name, order_date) VALUES ('John Smith', '04012022');
INSERT INTO orders (customer_name, order_date) VALUES ('Jane Bower', '06012022');
INSERT INTO orders (customer_name, order_date) VALUES ('Slyvia Hanratty', '14112022');

INSERT INTO orders_items (item_id, order_id) VALUES (1, 1);
INSERT INTO orders_items (item_id, order_id) VALUES (2, 1);
INSERT INTO orders_items (item_id, order_id) VALUES (5, 1);
INSERT INTO orders_items (item_id, order_id) VALUES (1, 3);
INSERT INTO orders_items (item_id, order_id) VALUES (5, 3);
INSERT INTO orders_items (item_id, order_id) VALUES (1, 2);
INSERT INTO orders_items (item_id, order_id) VALUES (2, 3);
INSERT INTO orders_items (item_id, order_id) VALUES (4, 3);
