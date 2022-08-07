TRUNCATE TABLE items, orders, items_orders RESTART IDENTITY;

INSERT INTO items (name, unit_price, qty) VALUES ('Hoover', '100', '20');
INSERT INTO items (name, unit_price, qty) VALUES ('Washing Machine', '400', '30');
INSERT INTO items (name, unit_price, qty) VALUES ('Cooker', '389', '12');
INSERT INTO items (name, unit_price, qty) VALUES ('Tumble Dryer', '279', '44');
INSERT INTO items (name, unit_price, qty) VALUES ('Fridge', '199', '15');

INSERT INTO orders (customer_name, date_placed) VALUES ('Frank', '04-Jan-2021');
INSERT INTO orders (customer_name, date_placed) VALUES ('Benny', '05-Aug-2022');

INSERT INTO items_orders (item_id, order_id, item_qty) VALUES ('1', '1', '2');
INSERT INTO items_orders (item_id, order_id, item_qty) VALUES ('2', '1', '1');
INSERT INTO items_orders (item_id, order_id, item_qty) VALUES ('1', '2', '1');
INSERT INTO items_orders (item_id, order_id, item_qty) VALUES ('3', '2', '3');