TRUNCATE TABLE items, orders RESTART IDENTITY; 

INSERT INTO items (name, unit_price, quantity) VALUES ('Repo Chocolate', 4, 97);
INSERT INTO items (name, unit_price, quantity) VALUES ('Class Popcorn', 2, 68);


INSERT INTO orders (customer_name, order_date, item_id) VALUES ('David', '08/10/22', 1);
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Anna', '9/12/22', 2);