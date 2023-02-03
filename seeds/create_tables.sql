DROP TABLE IF EXISTS items,
orders,
orders_items cascade;

CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name text NOT NULL,
  unit_price float NOT NULL,
  quantity int DEFAULT 0
);

CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name text NOT NULL,
  order_date date DEFAULT CURRENT_DATE
);

CREATE TABLE orders_items (
  order_id int NOT NULL,
  item_id int NOT NULL,
  quantity int NOT NULL,
  constraint fk_orders foreign key(order_id) references orders(id) on delete cascade,
  constraint fk_items foreign key(item_id) references items(id)
);