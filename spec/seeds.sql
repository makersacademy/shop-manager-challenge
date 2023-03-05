CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name text,
  order_date date
);

CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  item_name text,
  price numeric,
  quantity int,
  order_id int,
  constraint fk_order foreign key(order_id)
    references orders(id)
    on delete cascade
);