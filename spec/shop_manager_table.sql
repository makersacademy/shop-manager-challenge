CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  item_name TEXT NOT NULL,
  unit_price DECIMAL NOT NULL,
  quantity INTEGER NOT NULL
);

CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name TEXT NOT NULL,
  item_id INTEGER,
  date DATE NOT NULL,
  CONSTRAINT fk_item FOREIGN KEY (item_id)
    REFERENCES items(id)
    ON DELETE CASCADE
);

-- Insert data into the items table
INSERT INTO items (item_name, unit_price, quantity) VALUES
('Apple', 0.50, 100),
('Orange', 0.60, 80),
('Banana', 0.40, 120),
('Grapes', 1.20, 50),
('Strawberry', 1.50, 60);

-- Insert data into the orders table
INSERT INTO orders (customer_name, item_id, date) VALUES
('John Smith', 1, '2023-04-01'),
('Jane Doe', 1, '2023-04-02'),
('Bon Jovi', 2, '2023-04-02'),
('Bob Brown', 3, '2023-04-03'),
('Charlie Charles', 4, '2023-04-03'),
('David Dave', 5, '2023-04-04'),
('Eva Walle', 1, '2023-04-04');

