DROP TABLE IF EXISTS items CASCADE;

CREATE TABLE items (
  "id" SERIAL PRIMARY KEY,
  "name" text,
  "unit_price" decimal,
  "quantity" int
);

DROP TABLE IF EXISTS orders CASCADE;

CREATE TABLE orders (
  "id" SERIAL PRIMARY KEY,
  "customer_name" text,
  "order_date" text,
  "item_id" int,
  constraint fk_item foreign key(item_id)
    references items(id)
    on delete cascade
);

INSERT INTO items ("name", "unit_price", "quantity") VALUES
('Super Shark Vacuum Cleaner', 99, 30),
('Makerspresso Coffee Machine', 69, 15),
('Porridge Oats', 2, 100),
('Avocado', 1.49, 17);

INSERT INTO orders ("customer_name", "order_date", "item_id") VALUES
('Alex Hoggett', '12th Dec 2021', 2),
('Shaun Flood', '22th Feb 2021', 1),
('Lorna Powell', '16th Mar 2021', 3);