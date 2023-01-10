CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name text,
  price text,
  quantity int,
);

CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name text,
  date text,
  items_id int,
  constraint fk_item foreign key(items_id)
    references items(id)
    on delete cascade
);