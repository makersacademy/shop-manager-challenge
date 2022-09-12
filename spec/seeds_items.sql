TRUNCATE TABLE items, orders, items_orders RESTART IDENTITY;

INSERT INTO items (id, name, unit_price, quantity) VALUES(1, 'shark vacuum', 50, 100);
INSERT INTO items (id, name, unit_price, quantity) VALUES(2, 'carrot spiralizer', 8, 23);
INSERT INTO items (id, name, unit_price, quantity) VALUES(3, 'nut peeler', 3, 10);
INSERT INTO items (id, name, unit_price, quantity) VALUES(4, 'ball shaver', 35, 16);
INSERT INTO items (id, name, unit_price, quantity) VALUES(5, 'ball waxer', 12, 155);
INSERT INTO orders (id, customer_name, order_date) VALUES(1, 'Roy Bofter', '2022-10-02');
INSERT INTO orders (id, customer_name, order_date) VALUES(2, 'James Lamppe', '2022-10-03');
INSERT INTO orders (id, customer_name, order_date) VALUES(3, 'Ziggy Dufresne', '2022-08-22');
INSERT INTO orders (id, customer_name, order_date) VALUES(4, 'Lips McKenzie', '2022-11-12');
INSERT INTO orders (id, customer_name, order_date) VALUES(5, 'Doberman Fancy', '2022-10-10');
INSERT INTO orders (id, customer_name, order_date) VALUES(6, 'Djembe Djones', '2022-05-19');
INSERT INTO orders (id, customer_name, order_date) VALUES(7, 'Hardswipe Lepht', '2022-02-28');
INSERT INTO orders (id, customer_name, order_date) VALUES(8, 'Fan Bang', '2022-06-13');
INSERT INTO orders (id, customer_name, order_date) VALUES(9, 'Princess Michael Of Kunt', '2022-12-01');
INSERT INTO orders (id, customer_name, order_date) VALUES(10, 'Tim Bifter', '2022-12-12');
INSERT INTO orders (id, customer_name, order_date) VALUES(11, 'Hodja Hauses', '2022-03-10');
INSERT INTO items_orders (item_id, order_id) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 2),
(5, 2),
(1, 3),
(1, 4),
(3, 4),
(3, 5),
(4, 5),
(5, 6),
(4, 6),
(3, 6),
(2, 7),
(4, 7),
(4, 8),
(1, 9),
(1, 10),
(3, 10),
(5, 10),
(5, 11);

