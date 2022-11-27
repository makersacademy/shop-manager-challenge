1. Extract nouns from the user stories or specification
# EXAMPLE USER STORY
# (analyse only the relevant part - here the final line).

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

items, name, unit_price, quantity 
orders, customer_name, item, order_date

2. Infer the Table Name and Columns
Put the different nouns in this table. Replace the example with your own nouns.

Record	Properties
items name, unit_price, quantity 
orders, customer_name, item_id, order_date

Name of the first table (always plural): items

Column names: name, unit_price, quantity 

Name of the second table (always plural): orders

Column names: customer_name, item_id, order_date

3. Decide the column types.
Here's a full documentation of PostgreSQL data types.

Most of the time, you'll need either text, int, bigint, numeric, or boolean. If you're in doubt, do some research or ask your peers.

Remember to always have the primary key id as a first column. Its type will always be SERIAL.

# EXAMPLE:

Table: items
id: SERIAL
name: text
unit_price: text
quantity: int

Table: orders
id: SERIAL
customer_name: text
item_id: int
order_date: text

4. Decide on The Tables Relationship

# EXAMPLE

1. Can one item have many orders? YES
2. Can one order have many items? NO

-> Therefore,
-> An item HAS MANY orders
-> An order BELONGS TO an item

-> Therefore, the foreign key is on the orders table.

4. Write the SQL.
-- EXAMPLE
-- file: orders_table.sql

-- Replace the table name, columm names and types.

-- Create the table without the foreign key first.
CREATE TABLE items (
  item_id SERIAL PRIMARY KEY,
  item_name text,
  unit_price int,
  quantity int
);

-- Then the table with the foreign key first.
CREATE TABLE orders (
  order_id SERIAL PRIMARY KEY,
  customer_name text,
  item_id int,
  order_date text,
  constraint fk_item foreign key(item_id)
    references items(item_id)
    on delete cascade
);

CREATE TABLE ordersitems (
  order_id SERIAL PRIMARY KEY,
  customer_name text,
  item_id int,
  order_date text,
  constraint fk_item foreign key(item_id)
    references items(item_id)
    on delete cascade
);

5. Create the tables.
psql -h 127.0.0.1 shop_manager < orders_table.sql