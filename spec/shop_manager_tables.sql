-- table: items

CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name text,
  unit_price numeric,
  quantity int
);

-- table: orders

CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name text,
  order_date date
);

-- table: orders_by_items

CREATE TABLE orders_by_items (
  id SERIAL PRIMARY KEY,
  item_id int,
  order_id int,
  constraint fk_items foreign key (item_id) references items(id) on delete cascade,
  constraint fk_orders foreign key (order_id) references orders(id) on delete cascade
);