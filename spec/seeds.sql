TRUNCATE TABLE orders RESTART IDENTITY; -- replace with your own table name.
--this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.
INSERT INTO orders (customer_name, the_date) VALUES ('David', '2022');
INSERT INTO orders (customer_name, the_date) VALUES ('Anna', '2024');
INSERT INTO orders (customer_name, the_date) VALUES ('Davinder', '1987');
INSERT INTO orders (customer_name, the_date) VALUES ('Annad', '2000');