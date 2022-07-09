1. Description
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

Nouns: 
List of shop items: name, unit price, quantity
List of orders, customer name, date

2. Table : Shop items
Columns: item_name, unit_price, quantity

Table: Orders
Columns: customer_name, date

3. Columns types

Shop_items
id SERIAL
item_name text,
unit_price money,
quantity int

Orders
id SERIAL
customer_name text,
date timestamp

4. Relationship
Can order have multiple items? YES
Can shop item belong to many orders? YES

5. Design the join table
Join table for tables: orders and items
Join table name: orders_items
Columns: order_id, item_id

6. SQL

CREATE TABLE shop_items (
  id SERIAL PRIMARY KEY,
  item_name text,
  unit_price money,
  quantity int
);

CREATE TABLE orders (
  customer_name text,
  date timestamp
);

CREATE TABLE orders_items (
  order_id int,
  item_id int,
  constraint fk_order foreign key(order_id) references orders(id),
  constraint fk_item foregn key(item_id) references shop_items(id),
  PRIMARY KEY (order_id, item_id)
)