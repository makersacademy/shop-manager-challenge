DROP TABLE IF EXISTS "public".items CASCADE;

CREATE SEQUENCE IF NOT EXISTS items_id_seq;

CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name text,
  unit_price int,
  quantity int
);

DROP TABLE IF EXISTS "public".orders;

CREATE SEQUENCE IF NOT EXISTS orders_id_seq;

CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name text,
  order_date date,
  item_id int,
  constraint fk_item foreign key(item_id)
    references items(id)
    on delete cascade
);

INSERT INTO "public".items ("name", "unit_price", "quantity") VALUES
('Pachira Aquatica', 8, 50),
('Sansevieria Trifaciata', 12, 40),
('32inch Screen', 269, 5),
('Ergonomic Keyboard', 89, 10);

INSERT INTO "public".orders ("customer_name", "order_date", "item_id") VALUES
('Cristiano Ronaldo', '2023-01-01', 1),
('Lionel Messi', '2023-01-02', 1),
('Kylian Mbappe', '2023-01-03', 2),
('Neymar', '2023-01-04', 2),
('Harry Kane', '2023-01-05', 1),
('Marcus Rashford', '2023-01-06', 3),
('Bruno Fernandes', '2023-01-07', 3),
('Cristian Eriksen', '2023-01-08', 4),
('Casemiro', '2023-01-09', 4),
('Antony Martial', '2023-01-10', 4),
('Alejandro Garnacho', '2023-01-11', 4),
('David De Gea', '2023-01-12', 2);