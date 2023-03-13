DROP TABLE IF EXISTS orders;

-- Table Definition
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name text,
  date DATE,
  item_id int,
  constraint fk_item foreign key (item_id) 
    references items(id)
    on delete cascade
);

TRUNCATE TABLE orders RESTART IDENTITY; 

INSERT INTO orders (customer_name, date, item_id) VALUES 
('Mary Jones', '2023-03-11', 1),
('Anna Smith', '2023-03-12', 2),
('Jack Jackson', '2023-03-13', 3),
('Victor Potter', '2023-03-14', 4),
('Jane Peters', '2023-03-15', 1),
('Peter Jones', '2023-03-16', 2);