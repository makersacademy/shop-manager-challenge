CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  item_name text,
  unit_price float,
  quantity int
);

CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name text,
  date_placed date,
  item_id int,
  constraint fk_item foreign key (item_id)
    references items(id)
    on delete cascade
);