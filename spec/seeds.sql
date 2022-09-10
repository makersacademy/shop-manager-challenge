TRUNCATE TABLE items, orders, items_orders RESTART IDENTITY;

INSERT INTO items (name, unit_price, quantity) VALUES 
  ('voile', 13, 260),
  ('microSD', 30, 50),
  ('cradle', 7, 1000),
  ('toilet roll', 24, 20),
  ('light bulbs', 8, 10);


INSERT INTO orders (customer, date) VALUES 
  ('Yichao', '2022-08-22'),
  ('Chris', '2021-09-23'),
  ('Anna', '2019-03-12');

INSERT INTO items_orders (item_id, order_id) VALUES 
  (1, 1),
  (2, 1),
  (3, 1),
  (4, 1),
  (5, 1),
  (2, 2),
  (3, 2),
  (1, 3),
  (4, 3),
  (5, 3);

-- SELECT orders.customer, orders.date, items.name
--   FROM orders
--     JOIN items_orders ON items_orders.order_id = orders.id
--     JOIN items ON items.id = items_orders.item_id
--   WHERE orders.id = $1;