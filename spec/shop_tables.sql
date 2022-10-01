CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  quantity int,
  name text,
  price_units int
  

);

--join tables
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name text,
  order_date date,
  item_id int,
  constraint fk_item foreign key(item_id) 
  references items(id) on delete cascade

);

CREATE TABLE ordered_items (
    item_id int,
    order_id int
);