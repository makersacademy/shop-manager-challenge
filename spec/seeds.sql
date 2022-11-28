TRUNCATE TABLE orders, shop_items, shop_items_orders RESTART IDENTITY; 

INSERT INTO orders (customer_name, date_placed) VALUES ('David', '08-Nov-2022');
INSERT INTO orders (customer_name, date_placed) VALUES ('Anna', '10-Nov-2022');
INSERT INTO orders (customer_name, date_placed) VALUES ('Jill', '11-Nov-2022');
INSERT INTO shop_items (name, unit_price, quantity) VALUES ('sandwich', 2.99, 10);
INSERT INTO shop_items (name, unit_price, quantity) VALUES ('bananas', 1.99, 15);
INSERT INTO shop_items (name, unit_price, quantity) VALUES ('toilet roll', 3.00, 20);
INSERT INTO shop_items (name, unit_price, quantity) VALUES ('crisps', 0.99, 15);
INSERT INTO shop_items (name, unit_price, quantity) VALUES ('sausage roll', 1.50, 10);
INSERT INTO shop_items_orders (shop_item_id, order_id, quantity) VALUES (1,1,2);
INSERT INTO shop_items_orders (shop_item_id, order_id, quantity) VALUES (4,1,1);
INSERT INTO shop_items_orders (shop_item_id, order_id, quantity) VALUES (5,1,5);
INSERT INTO shop_items_orders (shop_item_id, order_id, quantity) VALUES (2,2,1);
INSERT INTO shop_items_orders (shop_item_id, order_id, quantity) VALUES (3,3,1);
INSERT INTO shop_items_orders (shop_item_id, order_id, quantity) VALUES (1,3,1);