DROP TABLE IF EXISTS "public"."items";

CREATE TABLE "public"."items" (
    "id" SERIAL,
    "name" text,
    "price" NUMERIC (6, 2)  ,
    "quantity" int4,
    PRIMARY KEY ("id")
);

DROP TABLE IF EXISTS "public"."orders";

CREATE TABLE "public"."orders" (
    "id" SERIAL,
    "date_placed" text,
    "customer_name" text,
    PRIMARY KEY ("id")
);

DROP TABLE IF EXISTS "public"."orders_items";

CREATE TABLE "public"."orders_items" (
    "order_id" int4,
    "item_id" int4
);


INSERT INTO "public"."orders"
("date_placed","customer_name")
VALUES
('2020-05-30', 'John Brown'),
('2020-04-20', 'Anne Smith');


INSERT INTO "public"."items" 
("name","price","quantity")
VALUES
('Ray-Ban Sunglasses', 80.00, 100),
('Tefal set pans', 150.00, 9),
('Super Shark Vacuum Cleane', 99.00, 30),
('Makerspresso Coffee Machine', 69.00, 15);


INSERT INTO "public"."orders_items" ("order_id", "item_id") VALUES
(1, 1),
(1, 2),
(2, 3),
(2, 2);

ALTER TABLE "public"."orders_items" ADD FOREIGN KEY ("order_id") REFERENCES "public"."orders"("id");
ALTER TABLE "public"."orders_items" ADD FOREIGN KEY ("item_id") REFERENCES "public"."items"("id");