# Two Tables (Many-to-Many) Design Recipe Template

## 1. Extract nouns from the user stories or specification

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

# should be able to update the item quantity as well?

As a shop manager
So I can know which orders were made
I want to keep a list of orders with their customer name.

As a shop manager
So I can know which orders were made
I want to assign each order to their corresponding item.  

# => one order = one item 

As a shop manager
So I can know which orders were made
I want to know on which date an order was placed. 

# => reads today's date? should also be in the correct format for postgres

As a shop manager
So I can manage orders
I want to be able to create a new order.

# => if someone orders an item, the quantity should be reduced by one


EXAMPLE:

Welcome to the shop management program!

What do you want to do?
  1 = list all shop items
  2 = create a new item
  3 = list all orders
  4 = create a new order

1 [enter]

Here's a list of all shop items:

 #1 Super Shark Vacuum Cleaner - Unit price: 99 - Quantity: 30
 #2 Makerspresso Coffee Machine - Unit price: 69 - Quantity: 15
```

```
Nouns:

items, name, price, quantity
orders, customer_name, item, date
```

## 2. Infer the Table Name and Columns

## 4. Design the Many-to-Many relationship

## 5. Design the Join Table

## 4. Write the SQL.

```sql
-- Create the first table.
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name text,
  order_date date
);

-- Create the second table.
CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name text,
  price decimal(5,2),
  quantity int
);

-- Create the join table.
CREATE TABLE orders_items (
  order_id int,
  item_id int,
  constraint fk_order foreign key(order_id) references orders(id) on delete cascade,
  constraint fk_item foreign key(item_id) references items(id) on delete cascade,
  PRIMARY KEY (order_id, item_id)
);

```

## 5. Create the tables.
