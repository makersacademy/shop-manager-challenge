Two Tables Design Recipe Template

Copy this recipe template to design and create two related database tables from a specification.

1. Extract nouns from the user stories or specification

# EXAMPLE USER STORY:
# (analyse only the relevant part - here the final line).

As a shop manager
So I can know which items I have in stock
I want to keep a list of my shop items with their name and unit price.

As a shop manager
So I can know which items I have in stock
I want to know which quantity (a number) I have for each item.

<!-- As a shop manager
So I can manage items
I want to be able to create a new item. -->

As a shop manager
So I can know which orders were made
I want to keep a list of orders with their customer name.

As a shop manager
So I can know which orders were made
I want to assign each order to their corresponding item.

As a shop manager
So I can know which orders were made
I want to know on which date an order was placed. 

<!-- As a shop manager
So I can manage orders
I want to be able to create a new order. -->

Nouns: item, unit_price, item_quantity, orders, customer_name, order_date  
2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.

Record	Properties
items,	item_name, item_price, item_quantity
orders,  order, customer_names, order_date
Name of the first table (always plural): posts

Column posts: title, content

Name of the second table (always plural): comments

Column comments: content, names

3. Decide the column types.

Here's a full documentation of PostgreSQL data types.

Most of the time, you'll need either text, int, bigint, numeric, or boolean. If you're in doubt, do some research or ask your peers.

Remember to always have the primary key id as a first column. Its type will always be SERIAL.

# EXAMPLE:

Table: items
id: SERIAL
item_name: text
item_price: int
item_quantity: int

Table: orders
id: SERIAL
order: text
cutstomer_name: text
order_date: int/date?


4. Decide on The Tables Relationship

Most of the time, you'll be using a one-to-many relationship, and will need a foreign key on one of the two tables.

To decide on which one, answer these two questions:

Can a item have many orders? YES
<!-- Can a order have many items? MAYBE? -->

items -> one-to-many -> orders

The foregin key is on items(orders_id)


4. Write the SQL.

-- EXAMPLE
-- file: shop_manager_table.sql

-- Replace the table name, columm names and types.

-- Create the table without the foreign key first.
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  order text,
  customer_name text,
  order_date int
);

-- Then the table with the foreign key first.
CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  item_name text,
  item_price text,
  item_quantity int,
-- The foreign key name is always {other_table_singular}_id
  order_id int,
  constraint fk_orders foreign key(order_id)
    references order(id)
    on delete cascade
);
5. Create the tables.

psql -h 127.0.0.1 shop_manager_directory < shop_manager_table.sql