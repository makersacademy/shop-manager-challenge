Two Tables Design Recipe Template

1. Extract nouns from the user stories or specification
#  USER STORY:
# (analyse only the relevant part ).

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

items, name, unit price, quantity, new item, orders, customer name, corresponding item, order date, new order 

2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.

Record  |	 Properties
---------------------
items    |	name, price, quantity, 
orders   |  customer name, item, order date 


Name of the first table (always plural): items

Column names: name, price, quantity

Name of the second table (always plural): orders

Column names: customer_name, item, order_date

3. Decide the column types.

Here's a full documentation of PostgreSQL data types.

Most of the time, you'll need either text, int, bigint, numeric, or boolean. If you're in doubt, do some research or ask your peers.

Remember to always have the primary key id as a first column. Its type will always be SERIAL.

# tables:

Table: items
id: SERIAL
name: text
price: int
quantity: int

Table: orders
id: SERIAL
customer_name: text
order_date: date
item_id: int


4. Decide on The Tables Relationship
Most of the time, you'll be using a one-to-many relationship, and will need a foreign key on one of the two tables.

To decide on which one, answer these two questions:

Can one [item] have many [orders]? (Yes)
Can one [order] have many [items]? (No)
You'll then be able to say that:

-> Therefore,
-> An item HAS MANY orders
-> An order BELONGS TO an item.

-> Therefore, the foreign key is on the order table.

If you can answer YES to the two questions, you'll probably have to implement a Many-to-Many relationship, which is more complex and needs a third table (called a join table).

4. Write the SQL.
-- file: shop_manager.sql

-- Replace the table name, columm names and types.

-- Create the table without the foreign key first.
CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name text,
  price int,
  quantity int
);

-- Then the table with the foreign key first.
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name text,
  order_date date,
  item_id int,
  constraint fk_item foreign key(item_id)
    references items(id)
    on delete cascade
);
5. Create the tables.
psql -h 127.0.0.1 database_name < albums_table.sql

-- The foreign key name is always items_id
