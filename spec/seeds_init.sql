CREATE TABLE customers (
    id SERIAL,
    customer_name TEXT
);

CREATE TABLE items (
    id SERIAL,
    item_name TEXT,
    item_price INT,
    item_quantity INT
);

CREATE TABLE orders (
    id SERIAL,
    order_date TIMESTAMP,
    item_id INT,
    customer_id INT,
    constraint fk_item foreign key(item_id) references items(id) on delete cascade,
    constraint fk_customer foreign key(customer_id) references customers(id) on delete cascade
);
-- Note: you have to create the tables first then reload the seeds with the constraints added!