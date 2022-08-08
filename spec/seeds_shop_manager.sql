TRUNCATE TABLE items, orders RESTART IDENTITY; -- replace with your own table name.


-- Below this line there should only be  statements.
-- Replace these statements with your own seed data.

INSERT INTO items (name, unit_price, quantity) VALUES
('Climbing rope', 40.99, 5),
('Waterproof jacket', 50.00, 2),
('Hiking boots', 130.99, 10),
('Guidebook', 40.00, 1),
('Family tent', 70.99, 0);

INSERT INTO orders (customer_name, date_ordered, item_id) VALUES
('David Green', '2022-08-05', 3),
('Nadine Dorris', '2022-07-30', 4),
('Gary Neville', '2022-06-27', 1),
('Calvin Klein', '2022-07-28', 2),
('Duncan Russell', '2022-07-01', 1),
('Barry Clark', '2022-08-01', 3);
