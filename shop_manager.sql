CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name text,
  price money,
  quantity int
);

-- Then the table with the foreign key first.
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

INSERT INTO items (name, price, quantity) VALUES ('Mustang', 47630, 200);
INSERT INTO items (name, price, quantity) VALUES ('Fiesta', 19060, 600);
INSERT INTO items (name, price, quantity) VALUES ('Focus', 26040, 350);
INSERT INTO items (name, price, quantity) VALUES ('Kuga', 30445, 150);
INSERT INTO items (name, price, quantity) VALUES ('Puma', 24660, 400);

INSERT INTO orders (customer_name, date, item_id) VALUES ('M. Jones', '2023-01-07', 1);
INSERT INTO orders (customer_name, date, item_id) VALUES ('R. Davids', '2023-01-08', 2);
INSERT INTO orders (customer_name, date, item_id) VALUES ('L. SIMMONS', '2023-01-08', 4);
INSERT INTO orders (customer_name, date, item_id) VALUES ('T. PAYNE', '2023-01-02', 4);
INSERT INTO orders (customer_name, date, item_id) VALUES ('R. RICHARDS', '2023-01-02', 4);
INSERT INTO orders (customer_name, date, item_id) VALUES ('B. ROSS', '2023-01-03', 5);
INSERT INTO orders (customer_name, date, item_id) VALUES ('R. GELLER', '2023-01-04', 3);