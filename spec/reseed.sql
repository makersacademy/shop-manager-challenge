
TRUNCATE TABLE stock_items, orders, customer_orders, stock_items_orders RESTART IDENTITY;


INSERT INTO "public"."stock_items" ("id", "item_name", "unit_price", "stock_level") VALUES
(1, 'Dummy item', 45, 20),
(2, 'Extra dummy item', 22, 80); 

INSERT INTO "public"."customer_orders" ("id", "customer_name", "order_date") VALUES
(100, 'Jeff Jeffson', '1900-01-01'),
(101, 'Jeffs Brother', '2021-04-20'); 

INSERT INTO "public"."orders" ("id", "customer_order_id", "stock_item_ordered_qty", "stock_item_ordered_id") VALUES
(1, 100, 7, 1); 
INSERT INTO "public"."orders" ("id", "customer_order_id", "stock_item_ordered_qty", "stock_item_ordered_id") VALUES
(2, 100, 3, 2); 
INSERT INTO "public"."orders" ("id", "customer_order_id", "stock_item_ordered_qty", "stock_item_ordered_id") VALUES
(3, 101, 13, 1); 
INSERT INTO "public"."orders" ("id", "customer_order_id", "stock_item_ordered_qty", "stock_item_ordered_id") VALUES
(4, 101, 8, 2); 

INSERT INTO "public"."stock_items_orders" ("stock_item_id", "order_id") VALUES
(1, 1),
(2, 2),
(1, 3),
(2, 4); 


SELECT SETVAL((SELECT PG_GET_SERIAL_SEQUENCE('"stock_items"', 'id')),
(SELECT (MAX("id") + 1) FROM "stock_items"), FALSE);

SELECT SETVAL((SELECT PG_GET_SERIAL_SEQUENCE('"customer_orders"', 'id')),
(SELECT (MAX("id") + 1) FROM "customer_orders"), FALSE);

SELECT SETVAL((SELECT PG_GET_SERIAL_SEQUENCE('"orders"', 'id')),
(SELECT (MAX("id") + 1) FROM "orders"), FALSE);

-- select * from stock_items 
-- inner join stock_items_orders on stock_items.id = stock_items_orders.stock_item_id 
-- inner join orders on stock_items_orders.order_id = orders.id 
-- inner join customer_orders on orders.customer_order_id = customer_orders.id;

-- select customer_name, order_date, item_name, unit_price, stock_item_ordered_qty from stock_items 
-- inner join stock_items_orders on stock_items.id = stock_items_orders.stock_item_id 
-- inner join orders on stock_items_orders.order_id = orders.id 
-- inner join customer_orders on orders.customer_order_id = customer_orders.id
-- where customer_order_id = 100;
