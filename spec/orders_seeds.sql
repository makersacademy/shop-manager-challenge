TRUNCATE TABLE items RESTART IDENTITY CASCADE; 
TRUNCATE TABLE orders RESTART IDENTITY CASCADE; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO "items" ("name", "unit_price", "quantity") VALUES('Black Trousers', 30, 52);
INSERT INTO "items" ("name", "unit_price", "quantity") VALUES('Yellow T-shirt', 20, 23);
INSERT INTO "items" ("name", "unit_price", "quantity") VALUES('Nike Trainers', 100, 12);

INSERT INTO "orders" ("customer_name", "date", "item_id") VALUES('Marta Bianchini', '9/01/2023', '1');
INSERT INTO "orders" ("customer_name", "date", "item_id") VALUES('Name Surname', '5/01/2023', '2');
INSERT INTO "orders" ("customer_name", "date", "item_id") VALUES('Name_2 Surname_2', '3/01/2023', '3');
INSERT INTO "orders" ("customer_name", "date", "item_id") VALUES('Name_3 Surname_3', '6/01/2023', '2');