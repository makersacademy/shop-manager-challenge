Two Tables Design Recipe Template

Social Network Database

## 1. Extract nouns from the user stories or specification

# EXAMPLE USER STORY:
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

Nouns: stock , shop items , orders, customerr name, customer item , order date, post views

2. Infer the Table Name and Columns
Put the different nouns in this table. Replace the example with your own nouns.

Record	 Properties
stock_items 	 name, unit price, quantity in stock,
orders   customer name, date, item_id

Name of the first table (always plural): stock_items

Column names: name, unit_price, stock_count

Name of the second table (always plural): orders

Column names: customer_name, date_of_order, item_id

3. Decide the column types.

Most of the time, you'll need either text, int, bigint, numeric, or boolean. If you're in doubt, do some research or ask your peers.

Remember to always have the primary key id as a first column. Its type will always be SERIAL.

# EXAMPLE:

Table: stock_items
id: SERIAL
name: text
unit_price: text
stock_count: int

Table: orders
id: SERIAL
customer_name: text
order_date: date
item_id : int

4. Decide on The Tables Relationship
Most of the time, you'll be using a one-to-many relationship, and will need a foreign key on one of the two tables.

To decide on which one, answer these two questions:

Can one post have many accounts? (No)
Can one account have many posts? (Yes)
You'll then be able to say that:

[item] has many [orders]
And on the other side, [order] belongs to [item]
In that case, the foreign key is in the table [orders]
Replace the relevant bits in this example with your own:


4. Write the SQL.
-- EXAMPLE
-- file: seeds_items.sql

-- Replace the table name, columm names and types.

-- Create the table without the foreign key first.
CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name text,
  unit_price text,
  stock_count int
);

-- Then the table with the foreign key first.
-- The foreign key name is always {other_table_singular}_id

CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name text,
  date date,
  item_id int,
  constraint fk_item foreign key(item_id)
    references items(id)
    on delete cascade
);

5. Create the tables.
psql -h 127.0.0.1 shop_manager_database < items_table.sql
psql -h 127.0.0.1 shop_manager_database < orders_table.sql
