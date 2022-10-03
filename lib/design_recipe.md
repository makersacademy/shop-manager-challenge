# Two Tables Design Recipe Template

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

```
Nouns:

stock, name, unit price, quantity, create item, orders, customer name, order number with time, order date, create new order
```

## 2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.

| Record                | Properties          |
| --------------------- | ------------------  |
| stocks                | name, price, quantity
| orders                | name, order number, date

1. Name of the first table (always plural): `stocks` 

    Column names: `name`, `price`, 'quantity'

2. Name of the second table (always plural): `orders` 

    Column names: `name`, 'order_number', 'date'

## 3. Decide the column types.

[Here's a full documentation of PostgreSQL data types](https://www.postgresql.org/docs/current/datatype.html).

Most of the time, you'll need either `text`, `int`, `bigint`, `numeric`, or `boolean`. If you're in doubt, do some research or ask your peers.

Remember to **always** have the primary key `id` as a first column. Its type will always be `SERIAL`.

```
# EXAMPLE:

Table: stocks
id: SERIAL
name: text
price: int
quantity: int


Table: orders
id: SERIAL
name: text
order_number: int
date: DATE
```

## 4. Decide on The Tables Relationship

Most of the time, you'll be using a **one-to-many** relationship, and will need a **foreign key** on one of the two tables.

To decide on which one, answer these two questions:

1. Can one stock have many orders? Yes
2. Can one order have many stocks? Yes

You'll then be able to say that:

1. **[A] has many [B]**
2. And on the other side, **[B] belongs to [A]**
3. In that case, the foreign key is in the table [B]

Replace the relevant bits in this example with your own:

```
As an example: a blog post can have many tags. But a tag can also be associated with many posts.

Can a post have many tags? - Yes
Can a tag have many posts? - Yes
When designing a many-to-many relationship, you will need a third table, acting as a "link" between to the tables. This is called a join table. It contains two columns, which are two foreign keys, each linking to the two tables.

The join table usually contains two columns, which are two foreign keys, each one linking to a record in the two other tables.

The naming convention is table1_table2.

# EXAMPLE

Join table for tables: stocks and orders
Join table name: stocks_orders
Columns: stock_id, order_id


## 4. Write the SQL.
-- EXAMPLE
-- file: stocks_orders.sql

-- Replace the table name, columm names and types.

-- Create the first table.
CREATE TABLE stocks (
  id SERIAL PRIMARY KEY,
  name text,
  price int,
  quantity int
);

-- Create the second table.
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  name text,
  order_number int,
  date DATE
);

-- Create the join table.
CREATE TABLE stocks_orders (
  stock_id int,
  order_id int,
  constraint fk_stock foreign key(stock_id) references stocks(id) on delete cascade,
  constraint fk_order foreign key(order_id) references orders(id) on delete cascade,
  PRIMARY KEY (order_id, stock_id)
);

<!-- BEGIN GENERATED SECTION DO NOT EDIT -->

---

**How was this resource?**  
[😫](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Ftwo_table_design_recipe_template.md&prefill_Sentiment=😫) [😕](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Ftwo_table_design_recipe_template.md&prefill_Sentiment=😕) [😐](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Ftwo_table_design_recipe_template.md&prefill_Sentiment=😐) [🙂](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Ftwo_table_design_recipe_template.md&prefill_Sentiment=🙂) [😀](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Ftwo_table_design_recipe_template.md&prefill_Sentiment=😀)  
Click an emoji to tell us.

<!-- END GENERATED SECTION DO NOT EDIT -->