CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name text,
  unit_price int,
  quantity int
);

CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  cust_name text,
  product_name text,
  date date,
  constraint fk_item foreign key(id) references items(id) on delete cascade
);

-- # items - name, unit_price, quantity,
-- # orders - cust_name, product_name, date,
