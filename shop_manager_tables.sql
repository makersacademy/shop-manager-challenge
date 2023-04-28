-- file: shop_manager_tables.sql

-- Create the table without the foreign key first.
CREATE TABLE shop_items (
  id SERIAL PRIMARY KEY,
  name text,
  unit_price money,
  quantity int
);

-- Then the table with the foreign key first.
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name text,
  date_placed timestamp,
-- The foreign key name is always {other_table_singular}_id
  shop_item_id int,
  constraint fk_shop_item foreign key(shop_item_id)
    references shop_items(id)
    on delete cascade
);