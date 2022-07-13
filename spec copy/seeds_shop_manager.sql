DROP TABLE IF EXISTS "public"."orders";
CREATE SEQUENCE IF NOT EXISTS orders_id_seq;

DROP TABLE IF EXISTS "public"."items";
CREATE SEQUENCE IF NOT EXISTS  items_id_seq;

CREATE TABLE "public"."items"(
  id SERIAL,
  name text,
  price numeric(3,2),
  quantity int,
  PRIMARY KEY ("id")
);

CREATE TABLE "public"."orders"(
  id SERIAL PRIMARY KEY,
  customer_name text,
  order_date date,
  item_id int,
  constraint fk_items foreign key(item_id) references items(id)
);

INSERT INTO "public"."items" ("id", "name", "price", "quantity") VALUES 
(1, 'bread', 1.10, 5),
(2, 'butter', 1.75, 3),
(3, 'cheese', 2.50, 2),
(4, 'milk', 0.90, 1),
(5, 'lettuce', 0.45, 6);

INSERT INTO "public"."orders"("id", "customer_name", "order_date", item_id) VALUES
(1, 'Joseph', '2022-07-08', 1),
(2, 'Colin', '2022-06-30', 2),
(3, 'Joe', '2022-05-02', 3),
(4, 'Karen', '2021-12-12', 4),
(5, 'Daniel', '2022-07-08', 5);





-- ------------------------------------------
-- CREATE TABLE "public"."user_accounts"(
--   id SERIAL,
--   username text,
--   email text,
--   PRIMARY KEY ("id")
-- );

-- CREATE TABLE "public"."posts"(
--   id SERIAL PRIMARY KEY,
--   title text,
--   content text,
--   post_id int,
--   constraint fk_user_accounts foreign key(post_id) references user_accounts(id)
-- );