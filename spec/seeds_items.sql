TRUNCATE TABLE orders, items RESTART IDENTITY; 


INSERT INTO items (name, unit_price, quantity) VALUES ('Henry Vacuum Hoover', 50, 20);
INSERT INTO items (name, unit_price, quantity) VALUES ('Toaster', 30, 35);