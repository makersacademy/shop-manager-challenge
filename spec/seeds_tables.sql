TRUNCATE TABLE items RESTART IDENTITY CASCADE; -- replace with your own table name.
TRUNCATE TABLE orders RESTART IDENTITY CASCADE; -- replace with your own table name.
TRUNCATE TABLE items_orders RESTART IDENTITY CASCADE; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO items (name, price, quantity) VALUES ('Tartan Paint', '6.75', 30);
INSERT INTO items (name, price, quantity) VALUES ('Hens Teeth', '15.45', 3);
INSERT INTO items (name, price, quantity) VALUES ('Rocking Horse Droppings', '45.95', 1);
INSERT INTO items (name, price, quantity) VALUES ('Fairy Dust', '200.85', 0);

INSERT INTO orders (customer_name, date) VALUES ('Bob', '10-20-2022');
INSERT INTO orders (customer_name, date) VALUES ('Julie', '05-07-2022');
INSERT INTO orders (customer_name, date) VALUES ('Mavis', '08-10-2021');

INSERT INTO items_orders (item_id, order_id) VALUES ('3', '1');
INSERT INTO items_orders (item_id, order_id) VALUES ('2', '2');
INSERT INTO items_orders (item_id, order_id) VALUES ('3', '2');
INSERT INTO items_orders (item_id, order_id) VALUES ('1', '3');
INSERT INTO items_orders (item_id, order_id) VALUES ('2', '3');
INSERT INTO items_orders (item_id, order_id) VALUES ('3', '3');