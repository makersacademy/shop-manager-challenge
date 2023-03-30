CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name TEXT,
  unit_price INT,
  quantity INT
);

CREATE TABLE customers (
  id SERIAL PRIMARY KEY,
  name TEXT
);

CREATE TABLE orders (
  order_time DATE,
  item_id INT,
  customer_id INT,
  CONSTRAINT fk_item_id FOREIGN KEY(item_id) REFERENCES items(id) ON DELETE CASCADE,
  CONSTRAINT fk_customer_id FOREIGN KEY(customer_id) REFERENCES customers(id) ON DELETE CASCADE,
  PRIMARY KEY (item_id, customer_id)
);
