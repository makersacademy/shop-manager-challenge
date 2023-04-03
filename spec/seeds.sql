TRUNCATE orders_items, orders, items RESTART IDENTITY;


INSERT INTO "public"."orders"
("date_placed","customer_name")
VALUES
('2020-05-30', 'John Brown'),
('2020-04-20', 'Anne Smith');

INSERT INTO "public"."items" 
("name","price","quantity")
VALUES
('Ray-Ban Sunglasses', 80.00, 100),
('Tefal set pans', 150.00, 9),
('Super Shark Vacuum Cleane', 99.00, 30),
('Makerspresso Coffee Machine', 69.00, 15);

INSERT INTO "public"."orders_items" ("order_id", "item_id") VALUES
(1, 1),
(1, 2),
(2, 3),
(2, 2);
