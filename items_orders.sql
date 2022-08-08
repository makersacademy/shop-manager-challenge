CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name text,
  price int,
  quantity int
);

CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  order_id int,
  customer_name text,
  date_of_order timestamp
);

CREATE TABLE items_orders (
  item_id int,
  order_id int,
  constraint fk_item foreign key(item_id) references items(id) on delete cascade,
  constraint fk_order foreign key(order_id) references orders(id) on delete cascade,
  PRIMARY KEY (order_id, item_id)
);

INSERT INTO items (name, price, quantity) VALUES ('iPhone', '700', '65');
INSERT INTO items (name, price, quantity) VALUES ('MacBookAir', '990', '22');
INSERT INTO items (name, price, quantity) VALUES ('MacBookAir Pro', '1200', '17');
INSERT INTO items (name, price, quantity) VALUES ('Smart TV LG', '850', '7');
INSERT INTO items (name, price, quantity) VALUES ('Smart TV Samsung', '1500', '4');

INSERT INTO orders (order_id, customer_name, date_of_order) VALUES ('1', 'Evelina', '2022-07-25');
INSERT INTO orders (order_id, customer_name, date_of_order) VALUES ('1', 'Evelina', '2022-07-25');
INSERT INTO orders (order_id, customer_name, date_of_order) VALUES ('2', 'John', '2022-07-28');
INSERT INTO orders (order_id, customer_name, date_of_order) VALUES ('3', 'Mary', '2022-07-31');
INSERT INTO orders (order_id, customer_name, date_of_order) VALUES ('4', 'Louis', '2022-07-29');