DROP TABLE IF EXISTS "public"."stocks" CASCADE;
DROP TABLE IF EXISTS "public"."orders" CASCADE;

CREATE TABLE stocks( 
id SERIAL PRIMARY KEY,
name text,
price int,
quantity int
);

CREATE TABLE orders(
id SERIAL PRIMARY KEY,
cname text,
time text,
date text,
stock_id int,
constraint fk_stock foreign key(stock_id) references 
stocks(id)
);

INSERT INTO "public"."stocks" ("id", "name", "price", "quantity" ) VALUES 
(1, 'Item1', 1, 1),
(2, 'Item2', 2, 2),
(3, 'Item3', 3, 3);


INSERT INTO "public"."orders" ("id", "cname", "time", "date" ) VALUES 
(1, 'A', '11:00', '20.04.2022'),
(2, 'B', '12:00', '21.04.2022'),
(3, 'C', '13:00', '22.04.2022');