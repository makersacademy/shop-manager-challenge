TRUNCATE TABLE items RESTART IDENTITY CASCADE;

INSERT INTO items 
  (name, unit_price, quantity) 
VALUES
  ('Apple MacBook Air', 999.00, 25),
  ('Samsung Galaxy S23', 899.00, 10),
  ('Apple iPad', 499.00, 3);