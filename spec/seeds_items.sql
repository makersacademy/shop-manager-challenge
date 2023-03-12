DROP TABLE IF EXISTS items CASCADE;

-- Table Definition
CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name text,
  price int,
  quantity int
);

TRUNCATE TABLE items RESTART IDENTITY; 

INSERT INTO items (name, price, quantity) VALUES 
('Chair', 50, 7),
('Bed', 150, 11),
('Wardrobe', 90, 15),
('Shelf', 25, 21);