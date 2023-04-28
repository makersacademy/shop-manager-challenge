# Design Recipe for Shop Manager Challenge

## 1. Extract nouns from the user stories or specification

```plain
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

```plain
Nouns/key elements:

list of shop items - name, unit price, quantity
list of orders - customer name, item_id, date placed

items - list all, create new item
orders - list all, create new item
Assign order to corresponding item - item_id will be fk
```

## 2. Infer the Table Name and Columns

| Record    | Properties                          |
| --------- | ----------------------------------- |
| shop_item | name, unit_price, quantity          |
| order     | customer_name, item_id, date_placed |

1. Name of the first table (always plural): `shop_items`

   Column names: `name`, `unit_price`, `quantity`

2. Name of the second table (always plural): `orders`

   Column names: `customer_name`, `shop_item_id`, `date_placed`

## 3. Decide the column types

```plain
Table: shop_items
id: SERIAL
name: text
unit_price: money
quantity: int

Table: orders
id: SERIAL
customer_name: text
date_placed: timestamp
shop_item_id: int
```

## 4. Decide on The Tables Relationship

```plain
1. Can one shop item have many orders? YES
2. Can one order have many shop items? NO

**NOTE**
One order could have many shop items. I have taken from the user story 'I want to assign each order to their corresponding item' and the menu options that this is singular for the purposes of this challenge.

-> Therefore,
-> A shop item HAS MANY orders
-> An order BELONGS TO a shop item

-> Therefore, the foreign key is on the orders table.
```

## 5. Write the SQL

```sql
-- file: shop_manager_tables.sql

-- Create the table without the foreign key first.
CREATE TABLE shop_items (
  id SERIAL PRIMARY KEY,
  name text,
  unit_price money,
  quantity int
);

-- Then the table with the foreign key first.
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name text,
  date_placed timestamp,
-- The foreign key name is always {other_table_singular}_id
  shop_item_id int,
  constraint fk_shop_item foreign key(shop_item_id)
    references shop_items(id)
    on delete cascade
);
```

## 6. Create the databases and tables

```bash
createdb shop_manager
createdb shop_manager_test
psql -h 127.0.0.1 shop_manager < shop_manager_tables.sql
psql -h 127.0.0.1 shop_manager_test < shop_manager_tables.sql
```

## 7. Create Test SQL seeds
