-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE items RESTART IDENTITY CASCADE; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO items (item_name, unit_price, quantity) VALUES ('Electric Guitar', 500, 25);
INSERT INTO items (item_name, unit_price, quantity) VALUES ('PS5', 450, 200);
INSERT INTO items (item_name, unit_price, quantity) VALUES ('Macbook', 875, 23);
INSERT INTO items (item_name, unit_price, quantity) VALUES ('Drum kit', 750, 10);
INSERT INTO items (item_name, unit_price, quantity) VALUES ('Nintendo Switch', 300, 500);
INSERT INTO items (item_name, unit_price, quantity) VALUES ('Printer', 100, 45);