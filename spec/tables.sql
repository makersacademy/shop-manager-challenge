-- CREATE TABLE items (
--   id SERIAL,
--   item text,
--   price_£ int,
--   quantity int);

CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  order_no int,
  customer_name text,
  order_date date,
  order_id int,
  constraint fk_order foreign key(order_id)
    references order(id)
    on delete cascade);