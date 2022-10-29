CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  item_name text,
  price int,
  order_id int,
  constraint fk_order foreign key(order_id)
    references orders(id)
    on delete cascade
);