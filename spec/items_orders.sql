CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  item_name text,
  item_price float,
  item_quantity int
);

-- Create the second table.
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name text,
  order_date date
);

-- Create the join table.
CREATE TABLE items_orders (
  item_id int,
  order_id int,
  constraint fk_item foreign key(item_id) references items(id) on delete cascade,
  constraint fk_order foreign key(order_id) references orders(id) on delete cascade,
  PRIMARY KEY (item_id, order_id)
);

INSERT INTO items (item_name, item_price, item_quantity) VALUES 
('Smart Watch', '250.0', '60'),
('USB C to USB adapter', '8.99', '430'),
('Wireless Earbuds', '24.64', '34'),
('Shower Head and Hose', '16.99', '4');

INSERT INTO orders (customer_name, order_date) VALUES 
('Jimothy', '2022-05-07'),
('Nick', '2022-04-25'),
('Tina', '2022-08-25'),
('Jem', '2022-07-28');

INSERT INTO items_orders (item_id, order_id) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 2),
(1, 2),
(3, 3),
(4, 4);
