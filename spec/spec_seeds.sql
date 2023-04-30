TRUNCATE TABLE items, orders, items_orders RESTART IDENTITY;

INSERT INTO items (name, unit_price, quantity)
    VALUES
        ('milk', 175, 20),
        ('spinach', 115, 1),
        ('pineapple', 95, 0),
        ('chocolate', 210, 16),
        ('cereal', 185, 45),
        ('coffee', 450, 2);

INSERT INTO orders (customer_name, date_placed)
    VALUES
        ('Alice', '2021-02-05'),
        ('Bob', '2022-03-06'),
        ('Carol', '2022-06-21'),
        ('Dom', '2023-10-16');

INSERT INTO items_orders (item_id, order_id)
    VALUES
        (1, 1),
        (1, 2),
        (1, 3),
        (1, 4),
        (2, 2),
        (2, 4),
        (3, 2),
        (4, 4),
        (5, 2),
        (6, 3);
