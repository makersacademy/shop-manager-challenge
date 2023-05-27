CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  unit_price DECIMAL(10, 2),
  quantity INTEGER DEFAULT 0
);

-- Create the orders table
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name VARCHAR(255),
  order_date DATE
);

-- Create the order_items table
CREATE TABLE order_items (
  order_id INT,
  item_id INT,
  CONSTRAINT fk_order FOREIGN KEY (order_id) REFERENCES orders (id) ON DELETE CASCADE,
  CONSTRAINT fk_item FOREIGN KEY (item_id) REFERENCES items (id) ON DELETE CASCADE,
  PRIMARY KEY (order_id, item_id)
);

-- Insert sample data into the items table
INSERT INTO items (name, unit_price, quantity) VALUES
  ('CPU', 199.99, 10),
  ('GPU', 499.99, 5),
  ('RAM', 99.99, 20),
  ('SSD', 149.99, 15),
  ('Power Supply', 79.99, 12);

-- Insert sample data into the orders table
INSERT INTO orders (customer_name, order_date) VALUES
  ('Joe Hannis', '2023-05-25'),
  ('Sean Peters', '2023-05-26');