CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  cust_name text,
  product_name text,
  product_id int,
  date date

);

CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name text,
  unit_price int,
  quantity int
);

-- # items - name, unit_price, quantity,
-- # orders - cust_name, product_name, date,
