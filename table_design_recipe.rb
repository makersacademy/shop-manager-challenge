# Single Table Design Recipe Template

_Copy this recipe template to design and create a database table from a specification._

## 1. Extract nouns from the user stories or specification

```
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name text,
  date text
);
-- for one

-- Create the table without the foreign key first.
CREATE TABLE items (
  id SERIAL PRIMARY KEY,
item_name text,
price int,
quantity int
);


-- Then the table with the foreign key first.
CREATE TABLE albums (
  id SERIAL PRIMARY KEY,
  title text,
  release_year int,
-- The foreign key name is always {other_table_singular}_id
  artist_id int,
  constraint fk_artist foreign key(artist_id)
    references artists(id)
    on delete cascade
);
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

items : item_name / price / quantity 
orders : customer_name / date 
all / list
create
```

## 2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.

| Record                | Properties          |
| --------------------- | ------------------  |
| items               | item_name / price / quantity
  orders                customer_name / date 
  

Name of the table (always plural): 'items', 'orders'

Column names: item_name / price / quantity  :  customer_name / date 

## 3. Decide the column types.

[Here's a full documentation of PostgreSQL data types](https://www.postgresql.org/docs/current/datatype.html).

Most of the time, you'll need either `text`, `int`, `bigint`, `numeric`, or `boolean`. If you're in doubt, do some research or ask your peers.

Remember to **always** have the primary key `id` as a first column. Its type will always be `SERIAL`.

```
# EXAMPLE:
ITEMS
id: SERIAL
item_name: text
price: int
quantity: int


ORDERS
id: SERIAL
customer_name: text
date: text


## 3.5 Decide on The Tables Relationship

1. Can one order have many items? YES
2. Can one item have many orders? NO

-> Therefore, the foreign key is on the items.

## 4. Write the SQL.

```sql
-- EXAMPLE
-- file: albums_table.sql

-- Replace the table name, columm names and types.

CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name text,
  date text
);

CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  item_name text,
  price int,
  quantity int,
  order_id int,
  constraint fk_order foreign key(order_id)
    references orders(id)
    on delete cascade
);



-- for tables where there is a foreign key

```

## 5. Create the table.
shop_manager_test
shop_manager
```bash
psql -h 127.0.0.1 database_name < albums_table.sql
```

<!-- BEGIN GENERATED SECTION DO NOT EDIT -->

---
