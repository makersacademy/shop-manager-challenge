CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  date date,
  customer text
);

CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name text,
  quantity int,
  price int
);

CREATE TABLE orders_items (
  order_id int,
  item_id int,
  constraint fk_order foreign key(order_id) references orders(id) on delete cascade,
  constraint fk_item foreign key(item_id) references items(id) on delete cascade,
  PRIMARY KEY (order_id, item_id)
);