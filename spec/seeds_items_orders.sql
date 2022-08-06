TRUNCATE TABLE items, orders  RESTART IDENTITY;

INSERT INTO items (item_name, price, quantity) 
VALUES ('GOLD NECKLACE', 800, 19);
INSERT INTO items (item_name, price, quantity) 
VALUES ('GOLD PENDANT', 1500, 12);

INSERT INTO orders (customer_name, order_date, item_id) 
VALUES ('Anna', '4 May 2022', 2);
INSERT INTO orders (customer_name, order_date, item_id) 
VALUES ('Mike', '15 jun 2022', 1);
