-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE stocks RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO stocks (item, price, quantity) VALUES ('cine camera', '£45', 3);
INSERT INTO stocks (item, price, quantity) VALUES ('vintage dining chair', '£75', 6);
INSERT INTO stocks (item, price, quantity) VALUES ('carriage clock', '£50', 2);