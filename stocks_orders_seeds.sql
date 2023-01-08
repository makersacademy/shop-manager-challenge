CREATE TABLE stocks (
  id SERIAL PRIMARY KEY,
  item_name text,
  unit_price int,
  quantity int
);


CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name text,
  date date,
  stock_id int,
  constraint fk_stock foreign key(stock_id)
    references stocks(id)
    on delete cascade
);

CREATE TABLE order_items (
  order_id int,
  stock_id int,
  constraint fk_order foreign key(order_id) references orders(id) on delete cascade,
  constraint fk_stock foreign key(stock_id) references stocks(id) on delete cascade,
  PRIMARY KEY (order_id, stock_id)
);