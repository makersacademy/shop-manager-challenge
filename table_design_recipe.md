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

SHOP_ITEMS - 
  price, quantity, 
ORDERS - 
  customer name, forgien_key 'item_key', date,


```

## 2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.

| Record                | Properties          |
| --------------------- | ------------------  |
| items                 | price,  quantity
| orders                  customer_name, orderdate, 'item_key'


## 3. Decide the column types.

[Here's a full documentation of PostgreSQL data types](https://www.postgresql.org/docs/current/datatype.html).

Most of the time, you'll need either `text`, `int`, `bigint`, `numeric`, or `boolean`. If you're in doubt, do some research or ask your peers.

Remember to **always** have the primary key `id` as a first column. Its type will always be `SERIAL`.

```
# EXAMPLE:

Table: items 
id: SERIAL
item_name: text
price: int
quantity: int

Table: orders
id: SERIAL
customer_name: text
order_date: text
item_key: foreign key 
```

## 4. Decide on The Tables Relationship



To decide on which one, answer these two questions:

1. Can one [TABLE ONE] have many [TABLE TWO]? (Yes/No)
2. Can one [TABLE TWO] have many [TABLE ONE]? (Yes/No)



```
# EXAMPLE

1. Can one items have many orders? YES
2. Can one order have many items? NO

-> Therefore,
-> An item HAS MANY albums 
-> An order BELONGS TO an item 

-> Therefore, the foreign key is on the orders table.
```

*If you can answer YES to the two questions, you'll probably have to implement a Many-to-Many relationship, which is more complex and needs a third table (called a join table).*

## 4. Write the SQL.

```sql
-- EXAMPLE
-- file: items_table.sql

CREATE TABLE items (
  id SERIAL PRIMARY KEY,
 item_name text,
 quantity int
);

-- Then the table with the foreign key first.
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name text,
  order_date text,
  artist_id int,
  constraint fk_order foreign key(order_id)
    references orders(id)
    on delete cascade
);

```

## 5. Create the tables.

```bash
psql -h 127.0.0.1 shop_manger < items_orders_table.sql
```