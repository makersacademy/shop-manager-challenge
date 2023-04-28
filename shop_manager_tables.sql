
-- Create the table without the foreign key first.
CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name text,
  unit_price decimal,
  quantity int
);

-- Then the table with the foreign key.
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name text,
  date date,
-- The foreign key name is always {other_table_singular}_id
  item_id int,
  constraint fk_item foreign key(item_id)
    references items(id)
    on delete cascade
);


TRUNCATE TABLE items RESTART IDENTITY; 

INSERT INTO items (name, unit_price, quantity) VALUES ('Cookie Dough', 2.99, 25);
INSERT INTO items (name, unit_price, quantity) VALUES ('Ice Cream', 1.99, 50);
INSERT INTO items (name, unit_price, quantity) VALUES ('Oreo Cookie Pie', 3.99, 15);
INSERT INTO items (name, unit_price, quantity) VALUES ('Chocolate Orange Brownie', 3.25, 20);


TRUNCATE TABLE orders RESTART IDENTITY;

INSERT INTO orders (customer_name, date, item_id) VALUES ('Caroline', '27-Apr-2023', 1);
INSERT INTO orders (customer_name, date, item_id) VALUES ('Phil','28-Apr-2023' , 2);
INSERT INTO orders (customer_name, date, item_id) VALUES ('Vass','29-Apr-2023' , 3);
