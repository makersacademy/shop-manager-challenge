-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE orders RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO orders (customer, order_date, stock_id) VALUES ('Marie Taylor', '21/3/2022', '1');
INSERT INTO orders (customer, order_date, stock_id) VALUES ('Peter Piper', '20/3/2022', '2');

--Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

--psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql