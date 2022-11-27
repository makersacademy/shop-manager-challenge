-- CREATE TABLE items (
--   "id" SERIAL PRIMARY KEY,
--   "item_name" text,
--   "unit_price" float,
--   "quantity" int
-- );

--  CREATE TABLE orders (
--   "id" SERIAL PRIMARY KEY,
--   "date" text,
--   "customer_name" text,
--   "item_id" int, 
--   "quantity" int,
--   constraint fk_item foreign key(item_id)
--     references items(id)
--     on delete cascade
-- );


-- INSERT INTO items (item_name, unit_price, quantity) VALUES ('Ludo', 6.99, 100);
-- INSERT INTO items (item_name, unit_price, quantity) VALUES ('Dobble', 9.99, 200);
-- INSERT INTO items (item_name, unit_price, quantity) VALUES ('Dino Floor Puzzle', 8.99, 150);
-- INSERT INTO items (item_name, unit_price, quantity) VALUES ('Folanimos', 8.99, 200);

INSERT INTO orders (date, customer_name, item_id, quantity) VALUES ('01/04/2022', 'Carey', 1, 1);
INSERT INTO orders (date, customer_name, item_id, quantity) VALUES ('02/05/2022', 'Julia', 2, 1);
INSERT INTO orders (date, customer_name, item_id, quantity) VALUES ('03/11/2022', 'Terri', 1, 2);
INSERT INTO orders (date, customer_name, item_id, quantity) VALUES ('04/03/2022', 'Katy', 1, 1);
INSERT INTO orders (date, customer_name, item_id, quantity) VALUES ('24/11/2022', 'Keira', 2, 2);

