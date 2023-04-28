TRUNCATE TABLE orders RESTART IDENTITY;

INSERT INTO orders (customer_name, date, item_id) VALUES ('Caroline', '27-Apr-2023', 1);
INSERT INTO orders (customer_name, date, item_id) VALUES ('Phil','28-Apr-2023' , 2);