-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE items, orders RESTART IDENTITY CASCADE; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO items (item_name, unit_price, quantity) VALUES
('Apple', 0.50, 100),
('Orange', 0.60, 80);

INSERT INTO orders (customer_name, item_id, date) VALUES
('John Smith', 1, '2023-04-01'),
('Jane Doe', 1, '2023-04-02');