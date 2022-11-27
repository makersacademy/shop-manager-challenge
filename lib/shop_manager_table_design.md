# Shop Manager Two Tables Design Recipe

_Copy this recipe template to design and create two related database tables from a specification._

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
Nouns:

shop manager, stock, name, unit price, quantity, orders, customer name, corresponding item, order date, 
```

## 2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.

| Record                | Properties          |
| --------------------- | ------------------  |
| stocks                | item, unit_price, quantity
| orders                | customer_name, oder_date, stock_id

1. Name of the first table (always plural): `stocks`

    Column names: `item`,`unit_price`, `quantity`

2. Name of the second table (always plural): `orders`

    Column names: `customer_name`, `order_date`, `stock_id`

## 3. Decide the column types.

[Here's a full documentation of PostgreSQL data types](https://www.postgresql.org/docs/current/datatype.html).

Most of the time, you'll need either `text`, `int`, `bigint`, `numeric`, or `boolean`. If you're in doubt, do some research or ask your peers.

Remember to **always** have the primary key `id` as a first column. Its type will always be `SERIAL`.

```

Table: stocks
id: SERIAL
item: text
unit_price: numeric
quantity: int

Table: orders
id: SERIAL
customer_name: text
order_date: date
stock_id: int

```

## 4. Decide on The Tables Relationship

Most of the time, you'll be using a **one-to-many** relationship, and will need a **foreign key** on one of the two tables.

To decide on which one, answer these two questions:

1. Can one stock have many orders? (Yes/No) Yes
2. Can one order have stocks? (Yes/No) No

You'll then be able to say that:

-> Therefore,
-> A stock HAS MANY orders
-> An order BELONGS TO a single order

-> Therefore, the foreign key is on the stocks table.
```

*If you can answer YES to the two questions, you'll probably have to implement a Many-to-Many relationship, which is more complex and needs a third table (called a join table).*

## 4. Write the SQL.

```sql
-- EXAMPLE
-- file: albums_table.sql

-- Replace the table name, columm names and types.

-- Create the table without the foreign key first.
CREATE TABLE stocks (
  id SERIAL PRIMARY KEY,
  item text,
  unit_price numeric,
  quantity int
);

-- Then the table with the foreign key first.
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name text,
  order_date date,
  stock_id int,
-- The foreign key name is always {other_table_singular}_id
  constraint fk_order foreign key(stock_id)
    references stocks(id)
    on delete cascade
);

```

## 5. Create the tables.

```bash
psql -h 127.0.0.1 shop_manager_test < shop_manager.sql
```