TRUNCATE TABLE items, orders, items_orders RESTART IDENTITY; -- replace with your own table name.

INSERT INTO items (name, unit_price, quantity) VALUES ('Semi Skimmed Milk: 2 Pints', 1.30, 30);
INSERT INTO items (name, unit_price, quantity) VALUES ('Cathedral City Mature Cheddar: 550G', 5.25, 15);
INSERT INTO items (name, unit_price, quantity) VALUES ('Hovis Soft White Medium Bread: 800G', 1.40, 10);
INSERT INTO items (name, unit_price, quantity) VALUES ('Nestle Shreddies The Original Cereal 630G', 0.52, 8);
INSERT INTO items (name, unit_price, quantity) VALUES ('Walkers Baked Cheese & Onion 37.5G', 2.40, 80);

INSERT INTO orders (customer_name, date) VALUES ('Joe Bloggs', '21-Nov-2022');
INSERT INTO orders (customer_name, date) VALUES ('Mrs Miggins', '23-Nov-2022');
INSERT INTO orders (customer_name, date) VALUES ('Jane Appleseed', '17-Nov-2022');

INSERT INTO items_orders (item_id, order_id) VALUES ('4', '1');
INSERT INTO items_orders (item_id, order_id) VALUES ('3', '1');
INSERT INTO items_orders (item_id, order_id) VALUES ('2', '1');
INSERT INTO items_orders (item_id, order_id) VALUES ('5', '2');
INSERT INTO items_orders (item_id, order_id) VALUES ('1', '2');
INSERT INTO items_orders (item_id, order_id) VALUES ('1', '3');
