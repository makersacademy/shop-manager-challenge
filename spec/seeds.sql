TRUNCATE TABLE items RESTART IDENTITY CASCADE;
TRUNCATE TABLE orders RESTART IDENTITY CASCADE;
TRUNCATE TABLE items_orders RESTART IDENTITY CASCADE;

INSERT INTO items (name, price, quantity) VALUES 
('TV', 99.99, 5),
('Fridge', 80.00, 10),
('Toaster', 9.99, 10);

INSERT INTO orders (customer, date) VALUES
('Rob', 'Jan-01-2022'),
('Tom', 'Jan-02-2022'),
('Anisha','Jan-02-2022');

INSERT INTO items_orders (item_id, order_id) VALUES
(1, 1), -- TV, Rob
(1, 2), -- TV, Tom
(2, 1), -- Fridge, Rob
(3, 3); -- Toaster, Anisha
