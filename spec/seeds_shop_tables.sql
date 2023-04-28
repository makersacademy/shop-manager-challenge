DROP TABLE IF EXISTS items, orders;

CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name text,
  unit_price decimal,
  quantity int
);

-- Then the table with the foreign key first.
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name text,
  date_placed date,

  item_id int,
  constraint fk_item foreign key(item_id)
    references items(id)
    on delete cascade
);

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO items (name, unit_price, quantity) 
            VALUES ('Hoover', 99.99, 20);
INSERT INTO items (name, unit_price, quantity) 
            VALUES ('Bicycle', 200, 2);

INSERT INTO orders (customer_name, date_placed, item_id)
            VALUES ('Louis', '2022-01-01', 1);
INSERT INTO orders (customer_name, date_placed, item_id)
            VALUES ('Lucy', '2023-01-01', 1);
INSERT INTO orders (customer_name, date_placed, item_id)
            VALUES ('Izzy', '2023-02-01', 2);