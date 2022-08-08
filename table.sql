



CREATE TABLE products (id SERIAL PRIMARY KEY, name text, unit_price int, quantity int);

CREATE TABLE orders (id SERIAL PRIMARY KEY, customer_name text, date_order_placed date, product_id int, 
constraint fk_product foreign key(product_id) references products(id) on delete cascade);