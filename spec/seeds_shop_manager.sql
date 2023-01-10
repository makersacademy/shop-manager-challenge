CREATE TABLE IF NOT EXISTS items (
	id SERIAL PRIMARY KEY,
	item_name text,
	unit_price float,
	quantity int
);

CREATE TABLE IF NOT EXISTS orders (
	id SERIAL PRIMARY KEY,
	customer_name text,
	item int,
	order_date DATE
);

TRUNCATE TABLE orders RESTART IDENTITY;
TRUNCATE TABLE items RESTART IDENTITY;

INSERT INTO items (item_name, unit_price, quantity) VALUES ('Potato', 5 , 100);
INSERT INTO items (item_name, unit_price, quantity) VALUES ('Spinach', 3 , 10);
INSERT INTO items (item_name, unit_price, quantity) VALUES ('Carrot', 2 , 20);
INSERT INTO items (item_name, unit_price, quantity) VALUES ('Onion', 1 , 50);

INSERT INTO orders (customer_name, order_date, item) VALUES ('Jim', '2023/01/09', 1);
INSERT INTO orders (customer_name, order_date, item) VALUES ('Bob', '2023/01/09', 2);

