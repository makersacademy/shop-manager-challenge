TRUNCATE TABLE items RESTART IDENTITY;

INSERT INTO items (item_name, price, order_id) VALUES ('Apple', 90, 1);
INSERT INTO items (item_name, price, order_id) VALUES ('Banana', 75, 1);
INSERT INTO items (item_name, price, order_id) VALUES ('Cherries', 120, 2);
INSERT INTO items (item_name, price, order_id) VALUES ('Cherries', 120, 2);
INSERT INTO items (item_name, price, order_id) VALUES ('Cherries', 120, 2);
INSERT INTO items (item_name, price, order_id) VALUES ('Banana', 75, 3);
INSERT INTO items (item_name, price, order_id) VALUES ('Banana', 75, 3);
INSERT INTO items (item_name, price) VALUES ('Apple', 90);
INSERT INTO items (item_name, price) VALUES ('Apple', 90);
INSERT INTO items (item_name, price) VALUES ('Banana', 75);
INSERT INTO items (item_name, price) VALUES ('Banana', 75);
INSERT INTO items (item_name, price) VALUES ('Cherries', 120);