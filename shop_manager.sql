
DROP TABLE IF EXISTS "public"."items";

CREATE SEQUENCE IF NOT EXISTS items_id_seq;

CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name text,
  unit_price float,
  quantity int
);

DROP TABLE IF EXISTS "public"."orders";

CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name text,
  date date,
  item_id int,
  constraint fk_item foreign key(item_id)
    references items(id)
    on delete cascade
);

INSERT INTO items (name, unit_price, quantity) VALUES ('Bag', 35.5, 23);
INSERT INTO items (name, unit_price, quantity) VALUES ('Lipstick', 15, 49);
INSERT INTO items (name, unit_price, quantity) VALUES ('Mascara', 18.4, 4);
INSERT INTO items (name, unit_price, quantity) VALUES ('Nail Polish', 8, 17);

INSERT INTO orders (customer_name, date, item_id) VALUES ('Lucas Smith', '2022-10-28', 1);
INSERT INTO orders (customer_name, date, item_id) VALUES ('Abigail Brown', '2022-11-28', 3);
INSERT INTO orders (customer_name, date, item_id) VALUES ('Sally Bright', '2022-11-16', 1);
