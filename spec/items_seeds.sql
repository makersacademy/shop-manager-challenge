TRUNCATE TABLE items RESTART IDENTITY CASCADE; 

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO "items" ("name", "unit_price", "quantity") VALUES('Black Trousers', 30, 52);
INSERT INTO "items" ("name", "unit_price", "quantity") VALUES('Yellow T-shirt', 20, 23);
INSERT INTO "items" ("name", "unit_price", "quantity") VALUES('Nike Trainers', 100, 12);