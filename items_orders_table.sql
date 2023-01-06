-- One to many configuration

-- -- Create the table without the foreign key first.
-- CREATE TABLE items (
--   id SERIAL PRIMARY KEY,
--   name text,
--   price int,
--   quantity int
-- );

-- -- Then the table with the foreign key first.
-- CREATE TABLE orders (
--   id SERIAL PRIMARY KEY,
--   customer_name text,
--   date date,
-- -- The foreign key name is always {other_table_singular}_id
--   item_id int,
--   constraint fk_item foreign key(item_id)
--     references items(id)
--     on delete cascade
-- );

-- Many to many configuration

CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name text,
  price int,
  quantity int
);

CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  name text,
  date date,
  item_id int,
  constraint fk_item foreign key(item_id)
    references items(id)
    on delete cascade
);

CREATE TABLE orders_items (
  order_id int,
  item_id int,
  constraint fk_order foreign key(order_id) references orders(id) on delete cascade,
  constraint fk_item foreign key(item_id) references items(id) on delete cascade,
  PRIMARY KEY (order_id, item_id)
);