CREATE TABLE items (
  id SERIAL PRIMARY KEY,
 item_name text,
 price int, 
 quantity int
);

CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name text,
  order_date text,
  artist_id int,
  constraint fk_order foreign key(order_id)
    references orders(id)
    on delete cascade
);
