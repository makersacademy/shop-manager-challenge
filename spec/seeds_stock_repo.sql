TRUNCATE TABLE stocks RESTART IDENTITY; 

INSERT INTO stocks (id, item_name, price, quantity) VALUES ('1', 'Bread', '5', '15');
INSERT INTO stocks (id, item_name, price, quantity) VALUES ('2', 'Tuna', '3', '23');