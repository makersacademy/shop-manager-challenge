TRUNCATE TABLE items, orders RESTART IDENTITY;

INSERT INTO "orders" ( "customer_name", "order_date", "item_id") VALUES
('Joe Bloggs', '2022-12-31', 1),
('John Smith', '2023-01-01', 2),
('Eva Jones', '2023-01-04', 3),
('Mary Cole', '2023-01-05', 4);

INSERT INTO "items" ("item_name", "quantity", "unit_price") VALUES
('paint set', 8, 15.99),
('brush set', 24, 7.99),
('pencil set', 17, 4.99), 
('small canvas', 5, 6.99), 
('large canvas', 3, 11.99);