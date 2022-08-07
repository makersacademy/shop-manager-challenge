DROP TABLE IF EXISTS "public"."items";

CREATE SEQUENCE IF NOT EXISTS items_id_seq;

CREATE TABLE "public"."items" (
    id SERIAL PRIMARY KEY,
    name text,
    unit_price float8,
    quantity int
);

DROP TABLE IF EXISTS "public"."orders";

CREATE SEQUENCE IF NOT EXISTS orders_id_seq;

-- Then the table with the foreign key first.
CREATE TABLE "public"."orders" (
    id SERIAL PRIMARY KEY,
    customer_name text,
    name text,
    date date,
-- The foreign key name is always {other_table_singular}_id
  item_id int,
  constraint fk_item foreign key(item_id)
    references items(id)
    on delete cascade
);

INSERT INTO "public"."items" ("name", "unit_price", "quantity") VALUES
('PS5', '449.00', '150'),
('Xbox Series X', '449.00', '280'),
('Nintendo Switch', '179.98', '199'),
('Meta Quest 2', '349.99', '245');


INSERT INTO "public"."orders" ("customer_name", "name", "date", "item_id") VALUES
('John Doe', 'PS5', '2022-03-12', 1),
('David Meade Jr.', 'PS5', '2022-04-16', 1),
('Barack Obama', 'Xbox Series X', '2022-05-27', 2),
('Gordan Ryan', 'Meta Quest 2', '2022-01-16', 4),
('Bruce Banner', 'PS5', '2022-06-19', 1),
('Reece Wabara', 'Meta Quest 2', '2022-01-25', 4),
('Anthony Joshua', 'Xbox Series X', '2022-07-07', 2),
('James Degale', 'PS5', '2022-04-17', 1),
('Aubrey Graham', 'PS5', '2022-07-11', 1),
('Charlie Adams', 'Nintendo Switch', '2022-05-29', 3);