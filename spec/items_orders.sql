CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  item_name text
unit_price int
quantity int
order_id int

);


CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name text,
order_date date,
item_id int
);


CREATE TABLE items_orders (
    item_id int,
    order_id int,
    constraint fk_item foreign key(item_id) references items(id) on delete cascade,
    constraint fk_order foreign key(order_id) references orders(id) on delete cascade,
    PRIMARY KEY (item_id, order_id)
);