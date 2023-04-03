TRUNCATE TABLE orders RESTART IDENTITY CASCADE;

INSERT INTO orders 
  (customer_name, order_date) 
VALUES 
  ('Joe Bloggs', '2023-03-30'),
  ('John Smith', '2023-03-31'),
  ('Harry Kane', '2023-04-01');