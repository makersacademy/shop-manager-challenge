CREATE TABLE items (
  id SERIAL PRIMARY KEY,
 item_name text,
 price int, 
 quantity int
);

CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name text,
  order_date text,
  item_id int,
  constraint fk_itemfo reign key(item_id)
    references items(id)
    on delete cascade
);


INSERT INTO items (item_name, price, quantity) 
VALUES ('GOLD WATCH', 3350, 5);
INSERT INTO items (item_name, price, quantity) 
VALUES ('DIMOND RING',6600, 3);
INSERT INTO items (item_name, price, quantity) 
VALUES ('SILVER NECKLACE', 500, 10);
INSERT INTO items (item_name, price, quantity) 
VALUES ('GOLDE NECKLACE', 800, 19);
INSERT INTO items (item_name, price, quantity) 
VALUES ('GOLD PENDANT', 1500, 12);

INSERT INTO orders (customer_name, order_date, item_id) 
VALUES ('Anna', '4 May 2022', 1);
INSERT INTO orders (customer_name, order_date, item_id) 
VALUES ('Mike', '15 jun 2022', 2);
INSERT INTO orders (customer_name, order_date, item_id) 
VALUES ('Joe', '5 MAY  2022', 3);
INSERT INTO orders (customer_name, order_date, item_id) 
VALUES ('Adrew', '6 May 2022', 4);
INSERT INTO orders (customer_name, order_date, item_id) 
VALUES ('Steve', '5 May 2022', 2);
INSERT INTO orders (customer_name, order_date, item_id) 
VALUES ('Fred', '5 May 2022', 1);