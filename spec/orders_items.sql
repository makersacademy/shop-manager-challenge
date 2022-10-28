CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name text,
  order_date text
);

CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  item_name text,
  item_price int,
  item_quantity int
);

CREATE TABLE orders_items (
  order_id int,
  item_id int,
  constraint fk_order foreign key(order_id) references orders(id) on delete cascade,
  constraint fk_item foreign key(item_id) references orders(id) on delete cascade,
  PRIMARY KEY (order_id, item_id)
);