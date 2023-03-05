TRUNCATE TABLE items, orders RESTART IDENTITY;

INSERT INTO items (name, unit_price, quantity) VALUES ('T-shirts', 30, 25);
INSERT INTO items (name, unit_price, quantity) VALUES ('Jumpers', 50, 15);
INSERT INTO items (name, unit_price, quantity) VALUES ('Trousers', 100, 20);
INSERT INTO items (name, unit_price, quantity) VALUES ('Shoes', 115, 20);

INSERT INTO orders (customer_name, date, item_id) VALUES ('David', '04-04-2022', 2);
INSERT INTO orders (customer_name, date, item_id) VALUES ('Anna', '10-05-2022', 1);
INSERT INTO orders (customer_name, date, item_id) VALUES ('John', '21-06-2022', 4);
INSERT INTO orders (customer_name, date, item_id) VALUES ('Jessica', '31-07-2022', 3)