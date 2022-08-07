# Two Tables Design Recipe Template

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

```
Nouns:

items, name, unit price
item, quantity
order, customer name, date placed, item
```

## 2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.

| Record                | Properties                 |
| --------------------- | -------------------------- |
| item                  | name, unit price, quantity |
| order                 | customer name, date placed |

1. Name of the first table (always plural): `items` 

    Column names: `name`, `unit_price`, `qty`

2. Name of the second table (always plural): `orders` 

    Column names: `customer_name`, `date_placed`

## 3. Decide the column types.

```
Table: items
id: SERIAL
name: text
unit_price: int
qty: int

Table: orders
id: SERIAL
customer_name: text
date_placed: text
```

## 4. Decide on The Tables Relationship

```
1. Can one item have many orders? YES
2. Can one order have many items? YES
```

## 5. Design the Join Table

```
Join table for tables: items and orders
Join table name: items_orders
Columns: item_id, order_id
```

## 6. Write the SQL.

```sql
-- file: items_orders.sql

-- Create the first table.
CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name text,
  unit_price int,
  qty int
);

-- Create the second table.
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name text,
  date_placed text
);

-- Create the join table.
CREATE TABLE items_orders (
  item_id int,
  order_id int,
  item_qty int,
  constraint fk_item foreign key(item_id) references items(id) on delete cascade,
  constraint fk_order foreign key(order_id) references orders(id) on delete cascade,
  PRIMARY KEY (item_id, order_id)
);
```

## 7. Create the tables.

```bash
psql -h 127.0.0.1 shop_manager < items_orders.sql
```