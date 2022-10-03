# 1. Extract nouns from the user stories or specification

User stories:
-------

```
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

Nouns: itsms, name, price, quantity, orders, customer_name, order_id, date


# 2. Infer the Table Name and Columns


|     Record	   |           Properties          |
|----------------+-------------------------------|
|     item       |     name, price, quantity     |
|----------------+-------------------------------|
|     order      |   customer, order_id, date    |


Name of the first table (always plural): items

Column names: name, price, quantity

Name of the second table (always plural): orders

Column names: customer, order_id, date

# 3. Decide the column types.

Most of the time, you'll need either text, int, bigint, numeric, or boolean. If you're in doubt, do some research or ask your peers.

Remember to always have the primary key id as a first column. Its type will always be SERIAL.

Table: items
id: SERIAL
name: text
price: numeric
quantity: int

Table: orders
id: SERIAL
customer: text
date: date

# 4. Design the Many-to-Many relationship
Make sure you can answer YES to these two questions:

Can one ITEM have many ORDERS? Yes
Can one ORDER have many ITEMS? Yes

# 5. Design the Join Table

Join table for tables: items and orders
Join table name: items_orders
Columns: item_id, order_id

# 6. Write the SQL.

-- file: items_orders_tables.sql

-- Create the first table.
CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name text,
  price numeric,
  quantity int
);

-- Create the second table.
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer text,
  date date
);

-- Create the join table.
CREATE TABLE items_orders (
  item_id int,
  order_id int,
  constraint fk_item foreign key(item_id) references items(id) on delete cascade,
  constraint fk_order foreign key(order_id) references orders(id) on delete cascade,
  PRIMARY KEY (item_id, order_id)
);

# 7. Create the tables.

psql -h 127.0.0.1 shop_manager < items_orders_tables.sql
