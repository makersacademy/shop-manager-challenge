TRUNCATE TABLE items, orders RESTART IDENTITY;

INSERT INTO items (name, price, quantity) VALUES('Monitor', '200'), 10;
INSERT INTO items (name, price, quantity) VALUES('Fridge', '400'), 20;
INSERT INTO orders (customer, date, item_id) VALUES('Jim', '1/1/2023', 1);
INSERT INTO orders (customer, date, item_id) VALUES('Bob', '2/1/2023', 2);