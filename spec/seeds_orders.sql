TRUNCATE TABLE orders RESTART IDENTITY CASCADE; -- replace with your own table name.
TRUNCATE TABLE items RESTART IDENTITY CASCADE;
-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO items (name, unit_price, quantity) VALUES ('TV', 250, 10);
INSERT INTO items (name, unit_price, quantity) VALUES ('Microwave', 80, 50);
INSERT INTO items (name, unit_price, quantity) VALUES ('Kettle', 20, 70);
INSERT INTO items (name, unit_price, quantity) VALUES ('Rug', 75, 30);

INSERT INTO orders (customer_name, date_order_placed, item_id) VALUES ('Lauren', '2022-01-01', 1);
INSERT INTO orders (customer_name, date_order_placed, item_id) VALUES ('Tom', '2022-01-02', 2);
INSERT INTO orders (customer_name, date_order_placed, item_id) VALUES ('James', '2022-01-03', 1);
INSERT INTO orders (customer_name, date_order_placed, item_id) VALUES ('Emily', '2022-01-04', 2);
INSERT INTO orders (customer_name, date_order_placed, item_id) VALUES ('Grace', '2022-01-05', 3);
