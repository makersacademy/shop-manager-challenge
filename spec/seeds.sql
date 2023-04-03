TRUNCATE TABLE items, orders, items_orders RESTART IDENTITY;

INSERT INTO items (name, price, qty) VALUES
('ChocoPop Cereal', 249, 234),
('Zenith Smart Watch', 8999, 42),
('FrostyBites Ice Cream', 399, 176),
('ThunderBolt Energy Drink', 149, 312),
('ScentSation Perfume', 4999, 89),
('Glovolium', 1199, 76),
('Amplicord', 845, 113),
('Luxifab', 699, 203),
('Truscent', 1425, 51),
('Plasticoat', 539, 414);

INSERT INTO orders (customer, date_of_order) VALUES
('Emma Jones', 'Mar-29-2023'),
('Benjamin Lee', 'Apr-03-2023'),
('Sophie Chen', 'Mar-25-2023'),
('Jack Wilson', 'Apr-02-2023'),
('Olivia Brown', 'Mar-31-2023');

INSERT INTO items_orders (order_id, item_id) VALUES
(1,1),(1,3),(1,4),(1,10),
(2,2),(2,4),(2,5),
(3,6),(3,7),
(4,3),(4,8),(4,9),
(5,10);

ALTER TABLE "public"."items_orders" ADD FOREIGN KEY ("item_id") REFERENCES "public"."items"("id");
ALTER TABLE "public"."items_orders" ADD FOREIGN KEY ("order_id") REFERENCES "public"."orders"("id");