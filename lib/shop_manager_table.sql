CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name text,
  unit_price numeric,
  quantity int
);

-- Then the table with the foreign key first.
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name text,
  order_date date,
 

-- The foreign key name is always {other_table_singular}_id
  item_id int,
  constraint fk_item foreign key(item_id)
    references items(id)
    on delete cascade
);

INSERT INTO items (name, unit_price, quantity)
    VALUES
    ('coffee machine', 80, 30),
    ('vacuum cleaner', 100, 15),
    ('toaster', 30, 60),
    ('fridge', 200, 20),
    ('dining set', 50, 70);

INSERT INTO orders (customer_name, order_date, item_id)
    VALUES
    ('John Smith', 'Jan-01-2023', 1),
    ('Harry Styles', 'Jan-02-2023', 2),
    ('Megan Rapinoe', 'Jan-03-2023', 2),
    ('Joe Gomez', 'Jan-04-2023', 4),
    ('Lorenzo Raeti', 'Jan-06-2023', 5),
    ('Dan Rashid', 'Jan-06-2023', 4),
    ('Phil Bravo', 'Jan-08-2023', 3);