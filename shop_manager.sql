CREATE TABLE stocks (
  id SERIAL PRIMARY KEY,
  item text,
  unit_price numeric,
  quantity int
);

-- Then the table with the foreign key first.
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name text,
  order_date date,
  stock_id int,
-- The foreign key name is always {other_table_singular}_id
  constraint fk_order foreign key(stock_id)
    references stocks(id)
    on delete cascade
);

INSERT INTO stocks (item, unit_price, quantity) VALUES ('Super Shark Vacuum Cleaner', 99, 30);
INSERT INTO stocks (item, unit_price, quantity) VALUES ('Makerspresso Coffee Machine', 69, 15);
INSERT INTO orders (customer_name, order_date, stock_id) VALUES ('Mr. Claus', '2022-01-01', 1);
INSERT INTO orders (customer_name, order_date, stock_id) VALUES ('The Grinch', '2022-02-02', 1);