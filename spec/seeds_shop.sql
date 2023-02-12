TRUNCATE TABLE orders,items RESTART IDENTITY; 

-- Below this line there should only be `INSERT` statements.

INSERT INTO items (name, unit_price, quantity) VALUES ('Bread', '1.00', '20');
INSERT INTO items (name, unit_price, quantity) VALUES ('Ham', '3.00', '30');
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Amber', '2023-02-13', '1');
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Jamie', '2023-02-12', '2');