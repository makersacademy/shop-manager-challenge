-- Create the first table.
CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name text,
  price int,
  qty int
);

-- Create the second table.
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer text,
  date_of_order date
);

-- Create the join table.
CREATE TABLE items_orders (
  item_id int,
  order_id int,
  constraint fk_post foreign key(item_id) references items(id) on delete cascade,
  constraint fk_tag foreign key(order_id) references orders(id) on delete cascade,
  PRIMARY KEY (item_id, order_id)
);