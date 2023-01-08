TRUNCATE TABLE items, orders RESTART IDENTITY;

INSERT INTO items (name, unit_price, quantity) VALUES ('Pickles', '10', '5');
INSERT INTO items (name, unit_price, quantity) VALUES ('Tomatos', '10', '5');
INSERT INTO items (name, unit_price, quantity) VALUES ('Cucumber', '10', '5');



INSERT INTO orders (cust_name, product_name, product_id, date) VALUES ('Thomas', 'Cucumber', '3', '2001-01-01');
INSERT INTO orders (cust_name, product_name, product_id, date) VALUES ('David', 'Pickles', '1', '2001-01-01');
INSERT INTO orders (cust_name, product_name, product_id, date) VALUES ('Steven', 'Pickles', '1', '2001-01-01');



-- # items - name, unit_price, quantity,
-- # orders - cust_name, product_name, date,
