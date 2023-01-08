CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name text,
  date text
);

-- Create the second table.
CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name text,
  price int,
  quantity int
);

-- Create the join table.
CREATE TABLE orders_items (
  order_id int,
  item_id int,
  constraint fk_orders foreign key(order_id) references orders(id) on delete cascade,
  constraint fk_items foreign key(item_id) references items(id) on delete cascade,
  PRIMARY KEY (order_id, item_id)
);

