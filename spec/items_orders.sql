CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name text,
  unit_price money,
  quantity int
);


CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name text,
  date timestamp,
  item_id int,
  constraint fk_item foreign key(item_id)
    references items(id)
    on delete cascade
);