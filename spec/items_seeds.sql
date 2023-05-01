TRUNCATE TABLE items RESTART IDENTITY CASCADE; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO items (item_name, item_price, item_quantity) VALUES ('Nice Mints', '50', '12');
INSERT INTO items (item_name, item_price, item_quantity) VALUES ('Best Beans', '1000', '5');
