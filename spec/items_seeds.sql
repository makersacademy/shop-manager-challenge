TRUNCATE items, orders, ordered_items RESTART IDENTITY;

INSERT INTO items(id,quantity, name, price_units) VALUES(1, 2, 'Porshe', 50);
INSERT INTO items(id,quantity, name, price_units) VALUES(2, 3, 'Jeep', 30);
INSERT INTO items(id,quantity, name, price_units) VALUES(3, 4, 'Tesla', 50);
INSERT INTO items(id,quantity, name, price_units) VALUES(4, 5, 'Saab VW', 100);

INSERT INTO orders(id,customer_name, order_date) VALUES(1, 'Ziggy', 2021-08-08);
INSERT INTO orders(id,customer_name, order_date) VALUES(2, 'Sid', 2021-08-07);
INSERT INTO orders(id,customer_name, order_date) VALUES(3, 'Tommy', 2021-08-06);
INSERT INTO orders(id,customer_name, order_date) VALUES(4, 'Clivet', 2021-08-05);

INSERT INTO ordered_items(order_id,item_id) VALUES(1, 1);
INSERT INTO ordered_items(order_id,item_id) VALUES(2, 2);
INSERT INTO ordered_items(order_id,item_id) VALUES(3, 3);
INSERT INTO ordered_items(order_id,item_id) VALUES(4, 4);

-- sense checked alongside Kates code