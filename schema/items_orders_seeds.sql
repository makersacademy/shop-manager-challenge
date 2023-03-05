TRUNCATE TABLE items, orders RESTART IDENTITY;

INSERT INTO items (item_name, unit_price, quantity) 
VALUES ('Jollof rice', 5.50, 200),
       ('Playstation 5', 479.99, 30),
       ('Standing desk', 200, 400),
       ('Cereal', 3.20, 500);

INSERT INTO orders (customer_name, order_date, item_id) 
VALUES ('Sasuke Uchiha', '2023-03-04', 4),
       ('Ross Geller', '1999-10-10', 1),
       ('Monica Geller', '1997-10-10', 1),
       ('Ted Moseby', '2006-10-10', 3), 
       ('Barney Stintson', '2007-05-27', 2);