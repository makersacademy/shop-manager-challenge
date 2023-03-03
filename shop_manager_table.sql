CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name text,
  order_date date
);

-- Then the table with the foreign key.
CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  item_name text,
  price numeric,
  quantity int,
-- The foreign key name is always {order}_id
  order_id int,
  constraint fk_order foreign key(order_id)
    references orders(id)
    on delete cascade
);