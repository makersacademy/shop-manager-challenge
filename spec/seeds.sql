TRUNCATE TABLE items, orders RESTART IDENTITY;

INSERT INTO items (name, unit_price, quantity)
VALUES ('Super Shark Vacuum Cleaner', 99, 30),
       ('Makerspresso Coffee Machine', 69, 15);

INSERT INTO orders (customer_name, date, item_id)
VALUES ('Alice', '2023-01-29', 1),
       ('Bob', '2023-01-30', 2),
       ('Carry', '2023-01-31', 2),
       ('Dan', '2023-02-01', 1);