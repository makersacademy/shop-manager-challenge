-- CREATE TABLE items (
--   "id" SERIAL PRIMARY KEY,
--   "item_name" text,
--   "unit_price" float,
--   "quantity" int
-- );

TRUNCATE TABLE items RESTART IDENTITY; 

INSERT INTO items (item_name, unit_price, quantity) VALUES ('Lego', 9.99, 20);
INSERT INTO items (item_name, unit_price, quantity) VALUES ('My little Pony', 13.99, 50);