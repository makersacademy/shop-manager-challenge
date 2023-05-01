DROP TABLE IF EXISTS items CASCADE;

CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name text,
  price numeric,
  quantity int
);

DROP TABLE IF EXISTS orders CASCADE;
-- Create the second table.
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name text,
  date date
);


DROP TABLE IF EXISTS items_orders CASCADE;
-- Create the join table.
CREATE TABLE items_orders (
  item_id int,
  order_id int,
  constraint fk_post foreign key(item_id) references items(id) on delete cascade,
  constraint fk_tag foreign key(order_id) references orders(id) on delete cascade,
  PRIMARY KEY (item_id, order_id)
);

TRUNCATE TABLE items RESTART IDENTITY CASCADE;
TRUNCATE TABLE orders RESTART IDENTITY CASCADE;
TRUNCATE TABLE items_orders RESTART IDENTITY CASCADE;


INSERT INTO items (name, price, quantity) VALUES ('Eggs', '2.99', '10');
INSERT INTO items (name, price, quantity) VALUES ('Coffee', '5.99', '5');
INSERT INTO items (name, price, quantity) VALUES ('Bread', '3.99', '15');
INSERT INTO items (name, price, quantity) VALUES ('Orange Juice', '2.99', '10');
-- New post inserted with id 3

INSERT INTO orders (customer_name, date) VALUES ('John Key', 'Jan-08-2023');
INSERT INTO orders (customer_name, date) VALUES ('Sally Smith', 'Jan-09-2023');
INSERT INTO orders (customer_name, date) VALUES ('Eddie Man', 'Jan-09-2023');
INSERT INTO orders (customer_name, date) VALUES ('Sam Baker', 'Jan-09-2023');
-- New tag inserted with id 5

INSERT INTO items_orders (item_id, order_id) VALUES
(1, 1), 
(1, 2),
(2, 2),
(1, 3),
(3, 3),
(4, 4);

ALTER TABLE items_orders ADD FOREIGN KEY (item_id) REFERENCES items(id);
ALTER TABLE items_orders ADD FOREIGN KEY (order_id) REFERENCES orders(id);

