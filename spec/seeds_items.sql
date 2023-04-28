TRUNCATE TABLE items, orders RESTART IDENTITY;

INSERT INTO items (name, unit_price, quantity) VALUES ('Cookie Dough', 2.99, 25);
INSERT INTO items (name, unit_price, quantity) VALUES ('Ice Cream', 1.99, 50);


INSERT INTO orders (customer_name, date, item_id) VALUES ('Caroline', '27-Apr-2023', 1);
INSERT INTO orders (customer_name, date, item_id) VALUES ('Phil','28-Apr-2023' , 2);


