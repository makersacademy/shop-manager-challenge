CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer text,
  date date
);

-- Then the table with the foreign key first.
CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  stock int,
  name text,
  price int,
-- The foreign key name is always {other_table_singular}_id
  order_id int,
  constraint fk_order foreign key(order_id)
    references orders(id)
    on delete cascade
);