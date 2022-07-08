# Two Tables Design Recipe Template

_Copy this recipe template to design and create two related database tables from a specification._

## 1. Extract nouns from the user stories or specification

```
# EXAMPLE USER STORY:
# (analyse only the relevant part - here the final line).

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

stock, items, names, price, quantity
orders, customer name, date ordererd, item ordered. 
```

## 2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.

| Record                | Properties                                         |
| --------------------- | ---------------------------------------------------|
| items                 | id,item,price,quantity                             |
| orders                | id, customer_name, date_ordered, item_ordered(fk)  |

1. Name of the first table (always plural): `items` 

    Column names: `id`, `item`, `price`,`quantity` 

2. Name of the second table (always plural): `orders` 

    Column names: `id`, `customer_name`, `date_ordered`, `item_ordered`(fk)

## 3. Decide the column types.

[Here's a full documentation of PostgreSQL data types](https://www.postgresql.org/docs/current/datatype.html).

Most of the time, you'll need either `text`, `int`, `bigint`, `numeric`, or `boolean`. If you're in doubt, do some research or ask your peers.

Remember to **always** have the primary key `id` as a first column. Its type will always be `SERIAL`.

```
# EXAMPLE:

Table: items
id: SERIAL PRIMARY KEY
item: text,
price: numeric,
quantity: int  

Table: orders
id: SERIAL PRIMARY KEY  
customer_name: text, 
date_ordered: text, 
item_ordered: int(fk)
```

## 4. Decide on The Tables Relationship

Most of the time, you'll be using a **one-to-many** relationship, and will need a **foreign key** on one of the two tables.

To decide on which one, answer these two questions:

1. Can one [item] have many [orders]? (Yes
2. Can one [order] have many [items}? No)-- for purpose of exercise we will assum there can only be one item per order



```

*If you can answer YES to the two questions, you'll probably have to implement a Many-to-Many relationship, which is more complex and needs a third table (called a join table).*

## 4. Write the SQL.

```sql
-- EXAMPLE
-- file: albums_table.sql

-- Replace the table name, columm names and types.

-- Create the table without the foreign key first.
CREATE TABLE artists (
  id SERIAL PRIMARY KEY,
  name text,
);

CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  item text,
  price numeric,
  quantity int  
;

-- Then the table with the foreign key first.
CREATE TABLE albums (
  id SERIAL PRIMARY KEY,
  title text,
  release_year int,
-- The foreign key name is always {other_table_singular}_id
  artist_id int,
  constraint fk_artist foreign key(artist_id) references artists(id)
);

CREATE TABLE orders(
  id: SERIAL PRIMARY KEY,  
  customer_name: text, 
  date_ordered: text, 

  item_id: int
  contraint fk_item foreign key(item_id) references items(id)
  ON DELETE CASCADE
);


```

## 5. Create the tables.

```bash
psql -h 127.0.0.1 database_name < seeds_shop.sql
```

