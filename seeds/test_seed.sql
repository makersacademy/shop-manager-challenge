
TRUNCATE TABLE items, items_orders, orders RESTART IDENTITY;

INSERT INTO items (item_name, unit_price, quantity) VALUES('叉烧包', 5, 10);
INSERT INTO items (item_name, unit_price, quantity) VALUES('Chicken Rice', 25, 5);
INSERT INTO items (item_name, unit_price, quantity) VALUES('Bak Kut Teh', 50, 2);
INSERT INTO items (item_name, unit_price, quantity) VALUES('Asam Laksa', 12, 3);
INSERT INTO items (item_name, unit_price, quantity) VALUES('Beef Teriyaki Burger', 40, 5);

INSERT INTO orders (customer_name, order_date) VALUES('Ryan Lai', '12-07-2001');
INSERT INTO orders (customer_name, order_date) VALUES('Emma Copsey', '28-09-2000');
INSERT INTO orders (customer_name, order_date) VALUES('Alain Lai', '04-02-1971');

INSERT INTO items_orders (item_id, order_id, order_quantity) VALUES(1, 1, 2);
INSERT INTO items_orders (item_id, order_id, order_quantity) VALUES(4, 1, 1);
INSERT INTO items_orders (item_id, order_id, order_quantity) VALUES(2, 2, 1);
INSERT INTO items_orders (item_id, order_id, order_quantity) VALUES(3, 3, 1);