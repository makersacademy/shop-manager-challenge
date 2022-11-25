INSERT INTO "public"."items" ("id", "name", "price", "quantity") VALUES
(1, 'Vacuum', 10.00, 10),
(2, 'Coffee Machine', 15.00, 10),
(3, 'TV', 99.99, 5),
(4, 'Fridge',80.00, 5);

INSERT INTO "public"."items_orders" ("item_id", "order_id") VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 2),
(3, 2),
(4, 3);

INSERT INTO "public"."orders" ("id", "customer", "date") VALUES
(1, 'Robbie', 'Nov-25-2022'),
(2, 'Anisha', 'Nov-26-2022'),
(3, 'Thomas', 'Dec-25-2022');

ALTER TABLE "public"."items_orders" ADD FOREIGN KEY ("order_id") REFERENCES "public"."orders"("id");
ALTER TABLE "public"."items_orders" ADD FOREIGN KEY ("item_id") REFERENCES "public"."items"("id");