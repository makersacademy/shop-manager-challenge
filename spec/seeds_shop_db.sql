TRUNCATE TABLE items, orders RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

-- add test data to items
INSERT INTO items(id, name, price, quantity) VALUES (1, 'Butter Bear', 16, 14);
INSERT INTO items(id, name, price, quantity) VALUES (2, 'Greek Yoghurt', 6, 4);
INSERT INTO items(id, name, price, quantity) VALUES (3, 'Curry Rice', 15,3);
INSERT INTO items(id, name, price, quantity) VALUES (4, 'Chocolate', 7, 9);

-- add test datat to orders
INSERT INTO orders(id, customer_name, date, item_id) VALUES (1, 'Harry', '2023-02-03', 3);
INSERT INTO orders(id, customer_name, date, item_id) VALUES (2, 'Ron', '2022-12-13', 1);
INSERT INTO orders(id, customer_name, date, item_id) VALUES (3, 'Hermoine', '1993-09-23', 4);
INSERT INTO orders(id, customer_name, date, item_id) VALUES (4, 'James', '1987-12-03', 2);




