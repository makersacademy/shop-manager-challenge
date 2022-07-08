DROP TABLE IF EXISTS "public"."items" CASCADE;

CREATE SEQUENCE IF NOT EXISTS items_id_seq;

CREATE TABLE "public"."items"(
  "id" SERIAL PRIMARY KEY,
  "item" text,
  "price" numeric,
  "quantity" int  
);

INSERT INTO "public". "items" ("id", "item", "price", "quantity") VALUES
('1', 'item1','1', '1'),
('2', 'item2','2', '2'),
('3', 'item3','3', '3');

------------------------------

DROP TABLE IF EXISTS orders CASCADE;

CREATE SEQUENCE IF NOT EXISTS orders_id_seq;

CREATE TABLE orders(
  "id" SERIAL PRIMARY KEY,  
  "customer_name" text, 
  "date_ordered" text, 
  "item_id" int,
  constraint fk_item foreign key(item_id) references items(id)
  ON DELETE CASCADE
);

INSERT INTO "public"."orders" ("id", "customer_name", "date_ordered", "item_id") VALUES
('1', 'customer1', '1/1/11', '1'),
('2', 'customer2', '2/2/22', '2'),
('3', 'customer3', '3/3/33', '3');

