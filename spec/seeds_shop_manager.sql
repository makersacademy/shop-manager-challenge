-- file: albums_table.sql

CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name text,
  price float,
  quantity int
);

-- Then the table with the foreign key first.
CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  customer text,
  date date,
-- The foreign key name is always {other_table_singular}_id
  order_id int,
  constraint fk_order foreign key(order_id)
    references items(id)
    on delete cascade
);