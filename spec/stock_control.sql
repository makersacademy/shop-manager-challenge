/* Uncomment the following block if tables have not been created yet.
-- Create the first table.
CREATE TABLE IF NOT EXISTS items (
  id SERIAL PRIMARY KEY,
  name text,
  unit_price int,
  quantity int
);

-- Create the second table.
CREATE TABLE IF NOT EXISTS orders (
  id SERIAL PRIMARY KEY,
  customer_name text,
  date date
);

-- Create the join table.
CREATE TABLE IF NOT EXISTS orders_items (
  item_id int,
  order_id int,
  constraint fk_items foreign key(item_id) references items(id) on delete cascade,
  constraint fk_orders foreign key(order_id) references orders(id) on delete cascade
);
*/
TRUNCATE TABLE items, orders, orders_items RESTART IDENTITY;

INSERT INTO items 
(name, unit_price, quantity)
VALUES  ('pens', 2, 234),
        ('pencils', 1, 998),
        ('paper', 5, 123),
        ('brush', 4, 927);

INSERT INTO orders
(customer_name, date)
VALUES  ('Mike', '2023-04-28'),
        ('Steve', '2023-04-27');

INSERT INTO orders_items
(order_id, item_id)
VALUES  (1, 2),
        (1, 4),
        (1, 1),
        (2, 3),
        (2, 2);