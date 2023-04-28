TRUNCATE TABLE items, orders, items_orders RESTART IDENTITY;

INSERT INTO items (name, unit_price, quantity)
    VALUES
        ('milk', 175, 20),
        ('spinach', 115, 20),
        ('pineapple', 95, 20),
        ('chocolate', 210, 20),
        ('cereal', 185, 20),
        ('coffee', 450, 20);

INSERT INTO orders (customer_name, date_placed)
    VALUES
        ('Alice', '2021-02-05'),
        ('Bob', '2021-02-05'),
        ('Carol', '2021-02-05'),
        ('Dom', '2021-02-05');

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
