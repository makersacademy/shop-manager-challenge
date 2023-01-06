TRUNCATE TABLE items, orders, orders_items RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO items (name, price, quantity) VALUES ('Super Shark Vacuum Cleaner', '99', '30');
INSERT INTO items (name, price, quantity) VALUES ('Makerspresso Coffee Machine', '70', '15');
INSERT INTO items (name, price, quantity) VALUES ('Magic Beans', '20', '40');
INSERT INTO items (name, price, quantity) VALUES ('Beanstalk', '30', '50');

INSERT INTO orders (customer_name, date, item_id) VALUES ('John Smith', '06/01/22', '1');
INSERT INTO orders (customer_name, date, item_id) VALUES ('Pauline Jones', '05/01/22', '2');
INSERT INTO orders (customer_name, date, item_id) VALUES ('Colonel Mustard', '05/01/22', '2');

INSERT INTO orders_items (order_id, item_id) VALUES ('1', '1');
INSERT INTO orders_items (order_id, item_id) VALUES ('2', '2');
INSERT INTO orders_items (order_id, item_id) VALUES ('3', '4');