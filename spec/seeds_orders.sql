TRUNCATE TABLE orders RESTART IDENTITY CASCADE; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO orders (customer_name, item_ordered, date_order) VALUES ('David', 'pizza', 'May 1st');
INSERT INTO orders (customer_name, item_ordered, date_order) VALUES ('Anna', 'beer', 'June 1st');