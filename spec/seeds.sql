TRUNCATE TABLE orders, items RESTART IDENTITY;

INSERT INTO orders (customer, date) VALUES ('Hana Holmens', '2022-07-10');
INSERT INTO orders (customer, date) VALUES ('Alfred Jones', '2022-08-15');

INSERT INTO items (name, unit_price, quantity, order_id) VALUES ('Ray chair', '499', '20', '1');
INSERT INTO items (name, unit_price, quantity, order_id) VALUES ('Mags sofa', '5800', '45', '2');