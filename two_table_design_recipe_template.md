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
item, item name item unit price, item quantity, order, customer name, date

```

## 2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.

| Record                | Properties          |
| --------------------- | ------------------  |
| items                 | name, unit_price, quantity
| orders                | customer_name, corresponding_item, date

1. Name of the first table (always plural): `items` 

    Column names: `name`, `unit_price`, quantity

2. Name of the second table (always plural): `orders` 

    Column names: `customer_name`, corresponding_item, date

## 3. Decide the column types.

[Here's a full documentation of PostgreSQL data types](https://www.postgresql.org/docs/current/datatype.html).

Most of the time, you'll need either `text`, `int`, `bigint`, `numeric`, or `boolean`. If you're in doubt, do some research or ask your peers.

Remember to **always** have the primary key `id` as a first column. Its type will always be `SERIAL`.

```
# EXAMPLE:

Table: items
id: SERIAL
name: text
unit_price: int
quantity: int

Table: orders
id: SERIAL
customer_name: text
corresponding_item: text
date: date
```

## 4. Decide on The Tables Relationship

Most of the time, you'll be using a **one-to-many** relationship, and will need a **foreign key** on one of the two tables.

To decide on which one, answer these two questions:

1. Can one [ITEM] have many [ORDERS]? (Yes)
2. Can one [ORDER] have many [ITEMS]? (No)

You'll then be able to say that:

1. **[ITEM] has many [ORDERS]**
2. And on the other side, an **[ORDER] belongs to [ITEM]**
3. In that case, the foreign key is in the table [ORDERS]

Replace the relevant bits in this example with your own:

```
# EXAMPLE

<!-- 1. Can one artist have many albums? YES
2. Can one album have many artists? NO

-> Therefore,
-> An artist HAS MANY albums
-> An album BELONGS TO an artist

-> Therefore, the foreign key is on the albums table. -->

1. Can one item have many orders? YES
2. Can one order have many items? NO

-> Therefore,
-> An item HAS MANY orders
-> An order BELONGS TO an item

-> Therefore, the foreign key is on the orders table.
```

*If you can answer YES to the two questions, you'll probably have to implement a Many-to-Many relationship, which is more complex and needs a third table (called a join table).*

## 4. Write the SQL.

```sql
-- EXAMPLE
-- file: items_table.sql

-- Replace the table name, column names and types.

-- Create the table without the foreign key first.
CREATE TABLE items (
    id SERIAL PRIMARY KEY,
    name text,
    unit_price float8,
    quantity int
);

-- Then the table with the foreign key first.
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_name text,
    name text,
    date date,
-- The foreign key name is always {other_table_singular}_id
  item_id int,
  constraint fk_item foreign key(item_id)
    references items(id)
    on delete cascade
);

```

## 5. Create the tables.

```bash
psql -h 127.0.0.1 shop_stock < shop_stock_database.sql
```