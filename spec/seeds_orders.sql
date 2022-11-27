TRUNCATE TABLE orders, items RESTART IDENTITY;

 -- replace with your own table name.
INSERT INTO orders (customer_name, date, item_id) VALUES ('Anisha', '2022-11-24', 1);
INSERT INTO orders (customer_name, date, item_id) VALUES ('Robbie', '2022-11-25', 2);
INSERT INTO orders (customer_name, date, item_id) VALUES ('Shah', '2022-11-26', 3);

INSERT INTO items (name, price, quantity) VALUES ('shirt', 10, 20);
INSERT INTO items (name, price, quantity) VALUES ('trouser', 5, 5);
INSERT INTO items (name, price, quantity) VALUES ('tie', 2, 10);
