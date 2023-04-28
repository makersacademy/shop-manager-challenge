CREATE TABLE Items (
  id SERIAL PRIMARY KEY,
  name text,
  unit_price int,
  stock_quantity int
);

CREATE TABLE Orders (
  id SERIAL PRIMARY KEY,
  customer_name text,
  order_date date,
  item_id int,
  constraint fk_item foreign key(item_id)
    references items(id)
    on delete cascade
);