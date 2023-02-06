
TRUNCATE TABLE items, orders RESTART IDENTITY;
 -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO items (name, unit_price, quantity) VALUES ('Chocolate', 3, 6);
INSERT INTO items (name, unit_price, quantity) VALUES ('Crisps', 2, 10);

INSERT INTO orders (customer_name, order_date, item_id) VALUES ('John', '2023-02-02', '1');
