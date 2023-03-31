DROP TABLE IF EXISTS "items_orders";
DROP TABLE IF EXISTS "orders";
DROP TABLE IF EXISTS "items";


-- Create the first table.
CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name text,
  -- arguments specify 12 digits max in the number, 2 of which are to the right of decimal point
  unit_price NUMERIC(12, 2),
  quantity int
);

-- Create the second table.
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name text,
  date DATE
);

-- Create the join table.
CREATE TABLE items_orders (
  item_id int,
  order_id int,
  constraint fk_item foreign key(item_id) references items(id) on delete cascade,
  constraint fk_order foreign key(order_id) references orders(id) on delete cascade,
  PRIMARY KEY (item_id, order_id)
);
