-- Create the first table.
CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name text,
  unit_price int,
  quantity int
);

-- Create the second table.
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name text,
  item_id int,
  date date
);

-- Create the join table.
CREATE TABLE items_orders (
  item_id int,
  order_id int,
  constraint fk_item foreign key(item_id) references items(id) on delete cascade,
  constraint fk_order foreign key(order_id) references orders(id) on delete cascade,
  PRIMARY KEY (item_id, order_id)
);


-- Add data to tables
INSERT INTO "items" (name, unit_price, quantity) VALUES ('Henry Hoover', 79, 19);
INSERT INTO "items" (name, unit_price, quantity) VALUES ('Dyson Vacuum', 199, 28);
INSERT INTO "items" (name, unit_price, quantity) VALUES ('Dualit Toaster', 49, 39);
INSERT INTO "items" (name, unit_price, quantity) VALUES ('Breville Kettle', 39, 34);
INSERT INTO "items" (name, unit_price, quantity) VALUES ('Panasonic Microwave', 59, 29);

INSERT INTO "orders" (customer_name, item_id, date) VALUES ('Andy Lewis', 2, '2022-11-23');
INSERT INTO "orders" (customer_name, item_id, date) VALUES ('James Scott', 5, '2022-11-24');
INSERT INTO "orders" (customer_name, item_id, date) VALUES ('Christine Smith', 4, '2022-11-24');
INSERT INTO "orders" (customer_name, item_id, date) VALUES ('Louise Stones', 1, '2022-11-25');
INSERT INTO "orders" (customer_name, item_id, date) VALUES ('Michael Kelly', 3, '2022-11-26');
INSERT INTO "orders" (customer_name, item_id, date) VALUES ('Catherine Wells', 2, '2022-11-27');

INSERT INTO "items_orders" (item_id, order_id) VALUES (1, 4);
INSERT INTO "items_orders" (item_id, order_id) VALUES (2, 1);
INSERT INTO "items_orders" (item_id, order_id) VALUES (2, 6);
INSERT INTO "items_orders" (item_id, order_id) VALUES (3, 5);
INSERT INTO "items_orders" (item_id, order_id) VALUES (4, 3);
INSERT INTO "items_orders" (item_id, order_id) VALUES (5, 2);