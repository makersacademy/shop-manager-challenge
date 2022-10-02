TRUNCATE TABLE items, orders RESTART IDENTITY;

INSERT INTO orders (customer_name, date) VALUES ('Joe Osborne', '2022-09-23 13:10:11');
INSERT INTO orders (customer_name, date) VALUES ('Dave Thomson','2022-09-29 10:10:11');
INSERT INTO orders (customer_name, date) VALUES ('Jim Lennox','2022-09-30 19:07:07');


INSERT INTO items (item_name, unit_price, quantity, order_id) VALUES ('Kombucha - Stawberry Peach', 8.99, 10, 1);
INSERT INTO items (item_name, unit_price, quantity, order_id) VALUES ('Kimchi', 3, 10, 1);
INSERT INTO items (item_name, unit_price, quantity, order_id) VALUES ('Salt Of The Earth Deodorant', 1, 5, 2);
INSERT INTO items (item_name, unit_price, quantity, order_id) VALUES ('Spinach Gnocchi', 1, 3.49, 3);
INSERT INTO items (item_name, unit_price, quantity, order_id) VALUES ('Provence Red Wine', 1, 18.49, 1);
INSERT INTO items (item_name, unit_price, quantity, order_id) VALUES ('What The Cluck', 1, 2.49, 2);
INSERT INTO items (item_name, unit_price, quantity, order_id) VALUES ('E-Cover Laundry Detergent', 3, 7.99, 3);
INSERT INTO items (item_name, unit_price, quantity, order_id) VALUES ('Crunchy Peanut Butter', 1, 1.99, 1);
INSERT INTO items (item_name, unit_price, quantity, order_id) VALUES ('Lavender Oil', 1, 15.99, 2);
INSERT INTO items (item_name, unit_price, quantity, order_id) VALUES ('Dried Ginger', 2, 4.99, 3);

