TRUNCATE TABLE items, orders, posts_tags RESTART IDENTITY;

-- replace with your own table name.

-- Below this line there should only be `INSERT` statements.

-- Replace these statements with your own seed data.

INSERT INTO
    items (
        item_name,
        quantity,
        unit_price
    )
VALUES ('Cheese', 100, 5);

INSERT INTO
    items (
        item_name,
        quantity,
        unit_price
    )
VALUES ('Milk', 50, 3);

INSERT INTO
    items (
        item_name,
        quantity,
        unit_price
    )
VALUES ('Ham', 500, 2);

INSERT INTO
    orders (
        customer_name,
        date,
        item_choice
    )
VALUES ('Dave', '2022-01-01', 1);

INSERT INTO
    orders (
        customer_name,
        date,
        item_choice
    )
VALUES ('Helen', '2022-09-30', 2);

INSERT INTO
    orders (
        customer_name,
        date,
        item_choice
    )
VALUES ('Sam', '2022-12-25', 3);