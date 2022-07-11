CREATE TABLE shop_items (
  id SERIAL PRIMARY KEY,
  item_name text,
  unit_price money,
  quantity int
);

CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name text,
  date timestamp
);

CREATE TABLE orders_items (
  order_id int,
  item_id int,
  constraint fk_order foreign key(order_id) references orders(id),
  constraint fk_item foreign key(item_id) references shop_items(id),
  PRIMARY KEY (order_id, item_id)
);

INSERT INTO shop_items (item_name,unit_price,quantity) VALUES 
('Cheese', '3', 33),
('Cherries', '4', 368),
('Watermelon', '2.5', 99),
('Strawberries', '3.5', 150),
('Strawberries', '3.5', 150);

INSERT INTO orders (customer_name,date) VALUES
('Irina', '2022/07/03'),
('Tim', '2022/07/01'),
('Julien', '2022/07/02'),
('Jane', '2022/06/01');

INSERT INTO orders_items (order_id,item_id) VALUES
(1,3),
(1,1),
(1,2),
(2,4),
(2,5),
(3,1),
(3,2),
(3,5);