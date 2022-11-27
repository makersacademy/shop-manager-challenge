TRUNCATE TABLE stocks, orders RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO stocks (item, unit_price, quantity) VALUES ('item1', 1.01, 1);
INSERT INTO stocks (item, unit_price, quantity) VALUES ('item2', 2.00, 2);