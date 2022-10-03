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

Nouns: shop items, name, price, quantity, orders, customer name, date

2. Infer the Table Name and Columns
Put the different nouns in this table. Replace the example with your own nouns.

3


Name of the first table (always plural): items

Column names: name, price, quantity

Name of the second table (always plural): orders

Column names: customer, order_date

3. Decide the column types.

Table: items
id: SERIAL
name: text
price: text
quantity: int

Table: orders
id: SERIAL
customer: text
order_date: text

4. Design the Many-to-Many relationship

Can one item have many orders? Yes
Can one order have many items? Yes

5. Design the Join Table

The join table usually contains two columns, which are two foreign keys, each one linking to a record in the two other tables.

The naming convention is table1_table2.

# EXAMPLE

Join table for tables: items and orders
Join table name: items_orders
Columns: item_id, order_id

4. Write the SQL.

-- file: items_orders.sql

CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name text,
  price text,
  quantity int
);

CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer text,
  order_date text
);

CREATE TABLE items_orders (
  item_id int,
  order_id int,
  constraint fk_item foreign key(item_id) references items(id) on delete cascade,
  constraint fk_order foreign key(order_id) references orders(id) on delete cascade,
  PRIMARY KEY (item_id, order_id)
);

5. Create the tables.

psql -h 127.0.0.1 shop < spec/items_orders.sql

psql -h 127.0.0.1 shop_test < spec/items_orders.sql

