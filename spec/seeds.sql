TRUNCATE TABLE orders, items RESTART IDENTITY;
 -- replace with your own table name.
--this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.
INSERT INTO orders (customer_name, the_date) VALUES ('David', '2022');
INSERT INTO orders (customer_name, the_date) VALUES ('Anna', '2024');
INSERT INTO orders (customer_name, the_date) VALUES ('Davinder', '1987');
INSERT INTO orders (customer_name, the_date) VALUES ('Annad', '2000');


INSERT INTO items (item_name, unit_price, order_id ) VALUES ('glue', '3', 1);
INSERT INTO items (item_name, unit_price, order_id ) VALUES ('paper', '2', 2);
INSERT INTO items (item_name, unit_price, order_id ) VALUES ('tv', '247', 3);
INSERT INTO items (item_name, unit_price, order_id ) VALUES ('chocolate', '2000', 4);