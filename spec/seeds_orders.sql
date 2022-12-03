-- CREATE TABLE orders (
--   "id" SERIAL PRIMARY KEY,
--   "date" text,
--   "customer_name" text,
--   "item_id" int, 
--   "quantity" int,
--   constraint fk_item foreign key(item_id)
--     references items(id)
--     on delete cascade
-- );

TRUNCATE TABLE orders RESTART IDENTITY;

INSERT INTO orders (date, customer_name, item_id, quantity) VALUES ('01/10/2022', 'Hillary', 1, 1);
INSERT INTO orders (date, customer_name, item_id, quantity) VALUES ('02/10/2022', 'Simone', 2, 1);
INSERT INTO orders (date, customer_name, item_id, quantity) VALUES ('03/11/2022', 'Simone', 1, 2);
INSERT INTO orders (date, customer_name, item_id, quantity) VALUES ('04/10/2022', 'Sharon', 1, 1);
INSERT INTO orders (date, customer_name, item_id, quantity) VALUES ('05/11/2022', 'Helen', 2, 2);