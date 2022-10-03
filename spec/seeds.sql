TRUNCATE TABLE items, orders, items_orders RESTART IDENTITY;

INSERT INTO items (name, price, quantity) VALUES 
('Bread', '1.00', '10'),
('Milk', '2.00', '5'),
('Tea', '1.50', '12'),
('Sugar', '0.90', '4');
INSERT INTO orders (customer, date) VALUES 
('customer_1', '01-01-2022'),
('customer_2', '02-01-2022'),
('customer_3', '03-01-2022');
INSERT INTO items_orders (item_id, order_id) VALUES 
(1, 1),
(1, 2),
(1, 3),
(2, 1),
(2, 2),
(2, 3),
(3, 2),
(3, 3),
(4, 1),
(4, 3);

ALTER TABLE "items_orders" ADD FOREIGN KEY ("order_id") REFERENCES "orders"("id");
ALTER TABLE "items_orders" ADD FOREIGN KEY ("item_id") REFERENCES "items"("id");