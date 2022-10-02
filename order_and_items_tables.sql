CREATE TABLE orders  (
  customer_name text,
  order_number int,
  order_date DATE
);

-- Create the second table.
CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  item_name text,
  quantity int
);

-- Create the join table.
CREATE TABLE orders_items (
  order_id int,
  item_id int,
  constraint fk_order foreign key(order_id) references order(id) on delete cascade,
  constraint fk_item foreign key(item_id) references item(id) on delete cascade,
  PRIMARY KEY (order_id, item_id)
);