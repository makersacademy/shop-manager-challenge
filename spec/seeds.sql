TRUNCATE TABLE items RESTART IDENTITY CASCADE;
TRUNCATE TABLE orders RESTART IDENTITY CASCADE;

INSERT INTO items (item, unit_price, quantity) VALUES 
  ('item_1', 2.99, 2),
  ('item_2', 3.99, 5),
  ('item_3', 5.49, 3),
  ('item_4', 8.99, 10),
  ('item_5', 6.49, 12),
  ('item_6', 9.49, 1),
  ('item_7', 2.49, 30),
  ('item_8', 12.49, 25),
  ('item_9', 11.99, 7),
  ('item_10', 1.49, 9);


INSERT INTO orders (order_date, customer_name) VALUES 
  ('2022-10-10', 'customer_1'),
  ('2022-10-16', 'customer_2'),
  ('2022-10-18', 'customer_3'),
  ('2022-10-11', 'customer_4'),
  ('2022-10-17', 'customer_5'),
  ('2022-10-09', 'customer_6');

INSERT INTO items_orders (item_id, order_id) VALUES 
  (1, 1),
  (1, 2),
  (8, 1),
  (2, 6),
  (3, 5),
  (2, 5),
  (9, 1),
  (7, 6),
  (2, 4),
  (10, 3),
  (5, 1);
