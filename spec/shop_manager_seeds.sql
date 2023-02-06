-- CREATE TABLE orders (
--   order_id SERIAL PRIMARY KEY,
--   customer_name text,
--   date_placed date
-- );

-- CREATE TABLE items (
--   item_id SERIAL PRIMARY KEY,
--   item_name text,
--   price numeric,
--   quantity int
-- );

-- CREATE TABLE orders_items (
--     order_id int REFERENCES orders (order_id) ON UPDATE CASCADE ON DELETE CASCADE,
--     item_id int REFERENCES items (item_id) ON UPDATE CASCADE,
--     CONSTRAINT orders_items_pkey PRIMARY KEY (order_id, item_id)
-- );

TRUNCATE TABLE orders, items, orders_items RESTART IDENTITY;

INSERT INTO items ("item_name", "price", "quantity") VALUES
('Carton of eggs', 3, 50),
('Pork shoulder', 10, 100),
('Marmite', 4, 75),
('Packet of carrots', 2, 150),
('Loaf of bread', 1, 150),
('Head of broccoli', 2, 100),
('Chicken thighs', 8, 75),
('4pt milk', 2, 200),
('Three red peppers', 5, 50),
('Box of cereal', 4, 150),
('Smoked salmon', 12, 50),
('Box of grapes', 3, 100);

-- INSERT INTO posts ("title", "contents", "view_count", "user_id") VALUES
-- ('Cass post 1', 'My first comment in this fictional social network', 1000, 1),
-- ('Cass post 2', 'I really hope this works', 5000, 1),
-- ('Cass post 3', 'Also I hope that this recording comes in at under an hour', 2000, 1),
-- ('Ed post 1', 'Cass is being very loud and he is messing up my recording', 1000, 2),
-- ('Ed post 2', 'I think I can hear him on my process feedback challenge', 1000, 2),
-- ('Luke post 1', 'Thank god I am paired with Terry today', 1000, 3);