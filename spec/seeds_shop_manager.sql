TRUNCATE TABLE items, orders, order_items RESTART IDENTITY;

-- Insert sample data into the items table
INSERT INTO items (name, unit_price, quantity) VALUES
  ('CPU', 199.99, 10),
  ('GPU', 499.99, 5);

-- Insert sample data into the orders table
INSERT INTO orders (customer_name, order_date) VALUES
  ('Joe Hannis', '2023-05-25'),
  ('Sean Peters', '2023-05-26');

-- Insert sample data into the order_items table
INSERT INTO order_items (order_id, item_id, quantity) VALUES
  (1, 1, 1),
  (1, 2, 1),
  (2, 1, 1);