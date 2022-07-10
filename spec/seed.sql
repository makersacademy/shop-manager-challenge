TRUNCATE TABLE items, orders RESTART IDENTITY;

INSERT INTO items (name, price, quantity) VALUES ('Strength Potion', 8.99, 100 );
INSERT INTO items (name, price, quantity) VALUES ('Med Kit', 25.50, 43);

INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Sally Smith', 'July 4, 2022', 1 );
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Kevin Mack', 'July 2, 2022', 2);

