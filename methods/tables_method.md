Two Tables (Many-to-Many) Design Recipe Template

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
```
Nouns:

item name, item price, item quantity, order customer, order item, order date

2. Infer the Table Name and Columns

Record	Properties
orders	customer_name, order_item, order_date
items	item_name, item_price, item_quantity

Name of the first table (always plural): orders

Column names: customer_name, order_item, order_date

Name of the second table (always plural): items

Column names: item_name, item_price, item-quantity

3. Decide the column types.

Table: orders
id: SERIAL
customer_name: text
order_item: text
order_date: int

Table: items
id: SERIAL
item_name: text
item_price: int
item_quantity: int

4. Design the Many-to-Many relationship

Can one [order] have many [items]? (Yes)
Can one [item] have many [orders]? (Yes)

5. Design the Join Table
The join table usually contains two columns, which are two foreign keys, each one linking to a record in the two other tables.

The naming convention is table1_table2.

# EXAMPLE

Join table for tables: orders and items
Join table name: orders_items
Columns: order_id, item_id

4. Write the SQL.

-- file: orders_items.sql

-- Create the first table.
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name: text,
  order_item: text,
  order_date: int
);

-- Create the second table.
CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  item_name: text,
  item_price: int,
  item_quantity: int
);

-- Create the join table.
CREATE TABLE orders_items (
  order_id int,
  item_id int,
  constraint fk_order foreign key(order_id) references orders(id) on delete cascade,
  constraint fk_item foreign key(item_id) references orders(id) on delete cascade,
  PRIMARY KEY (order_id, item_id)
);

5. Create the tables.
psql -h 127.0.0.1 shop_challenge < orders_items.sql