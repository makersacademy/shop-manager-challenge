As a shop manager
So I can know which items I have in stock
I want to keep a list of my shop items with their name and unit price.

As a shop manager
So I can know which items I have in stock
I want to know which quantity (a number) I have for each item.

As a shop manager
So I can manage items
I want to be able to create a new item.

As a shop manager
So I can know which orders were made
I want to keep a list of orders with their customer name.

As a shop manager
So I can know which orders were made
I want to assign each order to their corresponding item.

As a shop manager
So I can know which orders were made
I want to know on which date an order was placed. 

As a shop manager
So I can manage orders
I want to be able to create a new order.

NOUNS: shop_items, name, unit_price, quantity, orders, customer_name, order_date, item_id

Records            |     Properties
- - - - - - - - - - - - - - - - - - - - 
items              |     id, name, unit_price, quantity
orders             |     id, customer_name, order_date
orders_by_items    |     id, item_id, order_id

# table: items
id: SERIAL
name: text
unit_price: numeric
quantity: int

# table: orders
id: SERIAL
customer_name: text
order_date: date

# table: orders_by_items
id: SERIAL
item_id: int (foreign key referencing the items table)
order_id: int (foreign key referencing the orders table)

# file: shop_manager_tables.sql

-- table: items

CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name text,
  unit_price numeric,
  quantity int
);

-- table: orders

CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name text,
  order_date date
);

-- table: orders_by_items

CREATE TABLE orders_by_items (
  id SERIAL PRIMARY KEY,
  item_id int,
  order_id int,
  constraint fk_items foreign key (item_id) references items(id) on delete cascade,
  constraint fk_orders foreign key (order_id) references orders(id) on delete cascade
);