TRUNCATE TABLE orders RESTART IDENTITY CASCADE; -- replace with your own table name.
-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO orders (name, date, item_id) VALUES ('Lamar', '2022/11/01', '1' );
INSERT INTO orders (name, date, item_id) VALUES ('Justin', '2022/11/10', '2');
INSERT INTO orders (name, date, item_id) VALUES ('Patrick', '2022/11/22', '3');
INSERT INTO orders (name, date, item_id) VALUES ('Josh', '2022/11/12', '4');
INSERT INTO orders (name, date, item_id) VALUES ('Kirk', '2022,11,15', '5');
