DROP TABLE IF EXISTS items, orders;

CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name text,
  unit_price decimal,
  quantity int
);

-- Then the table with the foreign key first.
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name text,
  date_placed date,

  item_id int,
  constraint fk_item foreign key(item_id)
    references items(id)
    on delete cascade
);