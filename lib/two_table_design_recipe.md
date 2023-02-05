# Two Tables Design Recipe Template

_Copy this recipe template to design and create two related database tables from a specification._

## 1. Extract nouns from the user stories or specification

``As a shop manager
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
Nouns:
stock -  item, price, quantity
orders - customer, item, date_of_order 
(#find)
(#create)
```

## 2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.

| Record                | Properties          |
| --------------------- | ------------------  |
| stocks              | item, price, quantity
| orders               | customer, item, order_date 

1. Name of the first table (always plural): `stocks` 

    Column names: `items`, `price`, `quantity`

2. Name of the second table (always plural): `orders` 

    Column names: `customer`, `item`, `order_date`

## 3. Decide the column types.

[Here's a full documentation of PostgreSQL data types](https://www.postgresql.org/docs/current/datatype.html).

Most of the time, you'll need either `text`, `int`, `bigint`, `numeric`, or `boolean`. If you're in doubt, do some research or ask your peers.

Remember to **always** have the primary key `id` as a first column. Its type will always be `SERIAL`.

```
# EXAMPLE:

Table: stocks
id: SERIAL
item: text
price: text
quantity: text

Table: orders
id: SERIAL
customer: text
item: text
order_date: date


```

## 4. Decide on The Tables Relationship

Most of the time, you'll be using a **one-to-many** relationship, and will need a **foreign key** on one of the two tables.

To decide on which one, answer these two questions:

1. Can one [TABLE ONE-stock] have many [TABLE TWO-orders]? (/No)
2. Can one [TABLE TWO-order] have many [TABLE ONE-stocks]? (Yes)

You'll then be able to say that:

1. **[A-order] has many [B-stock]**
2. And on the other side, **[B-stock] belongs to [A-orders]**
3. In that case, the foreign key is in the table [stock]

Replace the relevant bits in this example with your own:

```
# EXAMPLE
`
1. Can one order have many items? NO
2. Can one stock/item have many orders? YES
-> Therefore,
-> An item/stock HAS MANY orders
-> An order BELONGS TO an item/stock
-> Therefore, the foreign key is on the orders table.
```

*If you can answer YES to the two questions, you'll probably have to implement a Many-to-Many relationship, which is more complex and needs a third table (called a join table).*

## 4. Write the SQL.

```sql
-- EXAMPLE
-- file: stocks_table.sql

-- Replace the table name, columm names and types.

-- Create the table without the foreign key first.
CREATE TABLE stocks (
  id SERIAL PRIMARY KEY,
  item text,
  price: text,
  quantity: int
);

-- Then the table with the foreign key first.
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer text,
  item text,
  order_date,
-- The foreign key name is always {other_table_singular}_id
  stock_id int,
  constraint fk_artist foreign key(stock_id)
    references(id)
    on delete cascade
);

```

## 5. Create the tables.

```bash
psql -h 127.0.0.1 database_name < albums_table.sql
```