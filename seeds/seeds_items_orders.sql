TRUNCATE TABLE orders,
items,
orders_items RESTART IDENTITY cascade;

INSERT INTO
  orders (customer_name)
VALUES
  ('terry'),
  ('ryan'),
  ('luke');

INSERT INTO
  items (name, unit_price, quantity)
VALUES
  ('Garlic Pasta Sauce', 1.5, 30),
  ('Shower Gel', 2, 55),
  ('Daily Moisture Conditioner', 1.99, 89),
  ('Scottish Salmon Fillets', 5, 50),
  ('Rump Steak', 10, 0);

INSERT INTO
  orders_items(order_id, item_id, quantity)
VALUES
  (1, 3, 10),
  (1, 2, 2),
  (1, 4, 15),
  (2, 1, 5),
  (2, 2, 8),
  (2, 3, 15),
  (3, 4, 22),
  (3, 2, 2),
  (3, 1, 4),
  (3, 3, 5);