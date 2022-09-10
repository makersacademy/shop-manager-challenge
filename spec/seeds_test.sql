TRUNCATE TABLE orders, items RESTART IDENTITY;

INSERT INTO items (name, price, stock) VALUES ('Sun Lamp', 39, 50);
INSERT INTO items (name, price, stock) VALUES ('Bass Guitar', 189, 25);
INSERT INTO items (name, price, stock) VALUES ('Ergonomic Keyboard', 89, 95);

INSERT INTO orders (customer, date, item_id) VALUES ('Thundercat', '15/05/2022', 2);
INSERT INTO orders (customer, date, item_id) VALUES ('Steve Jobs', '15/06/2022', 3);
INSERT INTO orders (customer, date, item_id) VALUES ('Alice Coltrane','15/07/2022',1);

