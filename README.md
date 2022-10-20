Shop Manager Project
=================

Challenge:
-------

We are going to write a small terminal program allowing the user to manage a shop database containing some items and orders.

User stories:
-------

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

Here's an example of the terminal:

```
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
 (...)
```

Two Table (Many-to-Many) Design:
-------

## 1. Extract nouns from user stories or specification

```
Nouns:

item, unit price, quantity, order, customer name, order date
```

## 2. Table Names and Columns

| Record                | Properties          |
| --------------------- | ------------------  |
| items                 | name, unit price, quantity
| orders                | customer name, order date

1. First table: `items`

Column names: `item`, `unit_price`, `quantity`

2. Second table: `orders`

Column names: `order_date`, `customer_name`

## 3. Column Types

```
Table: items
id: SERIAL
item: text
unit_price: float
quantity: integer

Table: orders
id: SERIAL
order_date: date
customer_name: text
```

## 4. Join Table

```
Join table for tables: items and orders
Join table name: items_orders
Columns: item_id, order_id
```

## 5. SQL Query
```sql
-- First table
CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  item text,
  unit_price float,
  quantity int
);

-- Second table
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  order_date date,
  customer_name text
);

-- Joint table
CREATE TABLE items_orders (
  item_id int,
  order_id int,
  constraint fk_item foreign key(item_id) references items(id) on delete cascade,
  constraint fk_order foreign key(order_id) references orders(id) on delete cascade,
  PRIMARY key (item_id, order_id)
);
```

## Model and Repository Classes

- [Items Model and Repository Classes Design](docs/items-model-repository-classes.md)
- [Orders Model and Repository Classes Design](docs/orders-model-repository-classes.md)