1. Extract nouns from the user stories

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

Nouns: Items, name, unit price, quantity, orders, customername, item_id, date

2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.

Record	      Properties
Items         name, unit price, quantity
Order	        customer name, date

Name of the first table (always plural): items

Column names: name, unit price, date,

Name of the second table (always plural): orders

Column names: customer name, date

3. Decide the column types.
Here's a full documentation of PostgreSQL data types.

Most of the time, you'll need either text, int, bigint, numeric, or boolean. If you're in doubt, do some research or ask your peers.

Table: items
id: SERIAL
name: text
unit price: money
quantity: int

Table: orders
id: SERIAL
customer_name: text
date: timestamp

4. Design the Many-to-Many relationship
To decide on which one, answer these two questions:

Can one item have many orders? YES
Can one order have many items? NO
You'll then be able to say that:

[A] has many [B]
And on the other side, [B] belongs to [A]
In that case, the foreign key is in the table [B]

4. Write the SQL.

-- file: posts_tags.sql


CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name text,
  unit_price money,
  quantity int
);


CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  customer_name text,
  date timestamp

  item_id int,
  constraint fk_item foreign key(item_id)
    references items(id)
    on delete cascade
);


5. Create the tables.
psql -h 127.0.0.1 shop_manager < items_orders.sql