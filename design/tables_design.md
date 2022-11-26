Two Tables (Many-to-Many) Design Recipe Template

## 1. Extract nouns from the user stories or specification

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

stock, item name, item price, item quantity,  
create new item, order, list of order, customer name
assign order to item,  date of order,  create new order 

```


2. Infer the Table Name and Columns
Put the different nouns in this table. Replace the example with your own nouns.


| Record      | Properties                |
| ----------- | -----------------------   |
| items       | name, price, quantity     |
| orders      | customer_name, order_date






3. Decide the column types.

# EXAMPLE:

Table: items
id: SERIAL
item_name: text
item_price: money
item_quantity: int

Table: orders
id: SERIAL
customer_name: text
order_date: date 



4. Design the Many-to-Many relationship
Make sure you can answer YES to these two questions:


1. Can one items have many orders? YES

2. Can one orders have many ? YES



5. Design the Join Table
The join table usually contains two columns, which are two foreign keys, each one linking to a record in the two other tables.

The naming convention is table1_table2.

# EXAMPLE

Join table for tables: items and orders
Join table name: items_orders
Columns: item_id, order_id


4. Write the SQL.

-- EXAMPLE
-- file: item_orders.sql


-- Create the first table.
CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  item_name text,
  item_price money,
  item_quantity int
);

-- Create the second table.
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name text,
  order_date date
);

-- Create the join table.
CREATE TABLE items_orders (
  item_id int,
  order_id int,
  constraint fk_item foreign key(item_id) references items(id) on delete cascade,
  constraint fk_order foreign key(order_id) references orders(id) on delete cascade,
  PRIMARY KEY (item_id, order_id)
);

