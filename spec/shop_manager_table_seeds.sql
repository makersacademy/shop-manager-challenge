CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name text,
  date timestamp
);

CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  item_name text,
  unit_price int,
  quantity int,
  order_id int,
  constraint fk_order foreign key(order_id)
    references orders(id)
    on delete cascade
);