TRUNCATE TABLE orders RESTART IDENTITY CASCADE;

INSERT INTO orders(customer_name, date_placed, item_id) VALUES('Professor Plum', '12/12/2023', 1);
INSERT INTO orders(customer_name, date_placed, item_id) VALUES('Colonel Mustard', '12/12/2023', 1);
INSERT INTO orders(customer_name, date_placed, item_id) VALUES('Miss Scarlet', '03/09/2023', 3);
INSERT INTO orders(customer_name, date_placed, item_id) VALUES('Reverend Green', '12/12/2023', 1);
INSERT INTO orders(customer_name, date_placed, item_id) VALUES('Mrs Peacock', '12/12/2023', 2);
INSERT INTO orders(customer_name, date_placed, item_id) VALUES('Chef White', '10/10/2023', 1);
INSERT INTO orders(customer_name, date_placed, item_id) VALUES('Miss Peach', '10/06/2023', 2);
INSERT INTO orders(customer_name, date_placed, item_id) VALUES('Madame Rose', '07/11/2023', 3);
INSERT INTO orders(customer_name, date_placed, item_id) VALUES('Lady Lavender', '08/12/2023', 1);