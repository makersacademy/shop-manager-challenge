-- Create the first table.
CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name text NOT NULL,
  price float NOT NULL,
  quantity int NOT NULL
);

-- Create the second table.
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name text NOT NULL,
  order_date date NOT NULL
);

-- Create the join table.
CREATE TABLE items_orders (
  item_id int NOT NULL,
  order_id int NOT NULL,
  constraint fk_items foreign key(item_id) references items(id) on delete cascade,
  constraint fk_order foreign key(order_id) references orders(id) on delete cascade,
  PRIMARY KEY (item_id, order_id)
);