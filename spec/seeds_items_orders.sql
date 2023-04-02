TRUNCATE TABLE orders RESTART IDENTITY CASCADE;

INSERT INTO items_orders 
  (item_id, order_id) 
VALUES
  (1, 3),
  (2, 1),
  (3, 2);