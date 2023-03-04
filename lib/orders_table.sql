
-- file: order_table.sql

CREATE TABLE items(
  id SERIAL PRIMARY KEY,
  name TEXT,
  price FLOAT,
  quantity INT
);

CREATE TABLE orders(
  id SERIAL PRIMARY KEY,
  customer TEXT,
  date DATE,
  item_id INT,
  constraint fk_item foreign key(item_id)
    references items(id)
    on delete cascade
);


