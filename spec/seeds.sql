TRUNCATE TABLE items, items_orders, orders RESTART IDENTITY;

INSERT INTO items ("name", "unit_price", "quantity") VALUES
('MacBookPro', 999.99, 50),
('Magic Mouse', 30.00, 10),
('Charger', 50.49, 25);


INSERT INTO orders ("customer_name", "date") VALUES
('Uncle Bob', '05-Sep-2022'),
('Linus Torvalds', '22-Feb-2023');

INSERT INTO items_orders ("item_id", "order_id") VALUES
(3, 1),
(2, 1),
(1, 1),
(2, 2);
  