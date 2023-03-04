Two Tables Design Recipe Template

1. Extract nouns from the user stories or specification

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

items, name, price, quantity, 
orders, item, date,customer_name

Verbs: create (new item)(new order)
Keep list (of orders)

2. Infer the Table Name and Columns
Put the different nouns in this table. Replace the example with your own nouns.

items, name, price, quantity 
orders, item_id, date, customer_name


Name of the first table (always plural): items

Column names: id, name, price, quantity

Name of the second table (always plural): orders

Column names: id, date, customer_name, item_id

3. Decide the column types.

Table: items
id: SERIAL
name: text
price: int
quantity: int

Table: orders
id: SERIAL
date: date
customer_name: text
item_id: foreign_key

4. Decide on The Tables Relationship
Most of the time, you'll be using a one-to-many relationship, and will need a foreign key on one of the two tables.

To decide on which one, answer these two questions:

Can one [TABLE ONE] have many [TABLE TWO]? (Yes/No)
Can one [TABLE TWO] have many [TABLE ONE]? (Yes/No)
You'll then be able to say that:

[item] has many [orders]
And on the other side, [orders] belongs to [item]
In that case, the foreign key is in the table [orders]
Replace the relevant bits in this example with your own:


4. Write the SQL.
-- file: seeds.sql

-- Replace the table name, columm names and types.

-- Create the table without the foreign key first.
CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name text,
  price int,
  quantity int
);

-- Then the table with the foreign key.
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  date date,
  customer_name text,
  item_id int,
  constraint fk_item foreign key(item_id)
    references items(id)
    on delete cascade
);

5. Create the tables.
psql -h 127.0.0.1 shop_manager < spec/seeds.sql
psql -h 127.0.0.1 shop_manager_test < spec/seeds.sql