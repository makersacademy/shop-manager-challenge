TRUNCATE TABLE items CASCADE;
ALTER SEQUENCE items_id_seq RESTART WITH 1;

INSERT INTO items (name, unit_price, stock_count) VALUES ('B1 Pencils', '£0.70', '506');
INSERT INTO items (name, unit_price, stock_count) VALUES ('A5 Notebooks', '£4.75', '156');
INSERT INTO items (name, unit_price, stock_count) VALUES ('Blue Biros', '£1.00', '325');
