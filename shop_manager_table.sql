CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  item_name text,
  price numeric,
  quantity int
);

-- Then the table with the foreign key.
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name text,
  order_date date,
-- The foreign key name is always {item}_id
  item_id int,
  constraint fk_item foreign key(item_id)
    references items(id)
    on delete cascade
);