## 1. Extract nouns from the user stories or specification

```
# USER STORIES:

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

## 2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.

| Record                | Properties          |
| --------------------- | ------------------  |
| itmes                 | name, unit_price, quantity
| orders                | customer_name, date_placed

1. Name of the first table (always plural): `items` 

    Column names: `name , unit_price, quantity`

2. Name of the second table (always plural): `orders` 

    Column names: `customer_name, date_placed`

## 3. Decide the column types.

Table: items
id: SERIAL
name: text
unit_price: decimal

Table: orders
id: SERIAL
customer_name: text
date_placed: date
```

Join table name: orders_items
Columns: order_id, item_id

```

## 5. Write the SQL.

-- Create the first table.
CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name text,
  unit_price decimal,
  quantity int
);

-- Create the second table.
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name text,
  date_placed date
);

-- Create the join table.
CREATE TABLE orders_items (
  order_id int,
  item_id int,
  constraint fk_post foreign key(order_id) references orders(id) on delete cascade,
  constraint fk_tag foreign key(item_id) references items(id) on delete cascade,
  PRIMARY KEY (order_id, item_id)
);
