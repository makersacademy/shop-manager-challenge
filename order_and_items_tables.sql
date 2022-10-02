-- Create the first table.
CREATE TABLE orders  (
  id SERIAL PRIMARY KEY,
  order_number int,
  customer_name text,
  order_date DATE
);

-- Create the second table.
CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  item_name text,
  price int,
  quantity int
);

-- Create the join table.
CREATE TABLE orders_items (
  order_id int,
  item_id int,
  constraint fk_order foreign key(order_id) references orders(id) on delete cascade,
  constraint fk_item foreign key(item_id) references items(id) on delete cascade,
  PRIMARY KEY (order_id, item_id)
);