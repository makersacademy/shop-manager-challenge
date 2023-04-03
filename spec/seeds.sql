TRUNCATE TABLE items, orders, items_orders RESTART IDENTITY;

INSERT INTO items
	  (name, unit_price, quantity)
	VALUES
	  ('Pizza',	 9.99,	100),
	  ('Cake',	 4.50,	20),
	  ('Chips',	 2.50,	50),
	  ('Burger', 8.49,	12),
	  ('Salad',	 0.99,	2),
	  ('Hotdog', 12.50,	99),
	  ('Spagbol',19.99,	59);

INSERT INTO orders
	  (customer_name, date)
	VALUES
	  ('Sam', '2023-03-31'),
	  ('Bob', '2023-02-28'),
	  ('Jim', '2023-04-22');

INSERT INTO items_orders
	  (order_id, item_id)
	VALUES
	  (1,1),(1,3),(1,5),(1,2),
	  (2,2),(2,7),
	  (3,1),(3,2),(3,3),(3,6),(3,7);