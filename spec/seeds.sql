DROP TABLE IF EXISTS items, orders, items_orders_join, shop_functions;

CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name text,
  unit_price int,
  quantity int
);

CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name text,
  order_date date
);

CREATE TABLE items_orders_join (
  item_id int,
  order_id int
);

CREATE TABLE shop_functions (
  id SERIAL PRIMARY KEY,
  function text
);

TRUNCATE TABLE items, orders, items_orders_join, shop_functions RESTART IDENTITY;

INSERT INTO items (name, unit_price, quantity) VALUES 
('Star Wars Jedi: Survivor', 60, 420),
('The Legend of Zelda: The Wind Waker', 69, 14),
('Dead Space', 42, 69),
('Metroid Prime', 3, 12);

INSERT INTO orders (customer_name, order_date) VALUES
('Barney', '2023-01-01'),
('Charlie', '2023-02-14'),
('Michael', '2023-04-28');

INSERT INTO items_orders_join (item_id, order_id) VALUES
(1, 1),
(3, 1),
(3, 2),
(2, 2),
(1, 3),
(2, 3),
(3, 3),
(4, 3);

INSERT INTO shop_functions (function) VALUES
('List all items.'),
('Create a new item.'),
('List all orders.'),
('Create a new order.');