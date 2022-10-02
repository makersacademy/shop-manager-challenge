# Shop Manager Design Recipe Template

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

items, stock, orders, customer names, order dates, quantity
```

## 2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.

| Record                | Properties          |
| --------------------- | ------------------  |
| order                 | id, customer name, order date, order number
| item                  | id, item name, quantity, 

1. Name of the first table (always plural): `orders` 

    Column names: `id`, `customer_name`, `order_date`, `order_number`

2. Name of the second table (always plural): `items` 

    Column names: `id`, `item_name`, `quantity`, 

## 3. Decide the column types.

[Here's a full documentation of PostgreSQL data types](https://www.postgresql.org/docs/current/datatype.html).

Most of the time, you'll need either `text`, `int`, `bigint`, `numeric`, or `boolean`. If you're in doubt, do some research or ask your peers.

Remember to **always** have the primary key `id` as a first column. Its type will always be `SERIAL`.

```
Table: orders
id: SERIAL
customer_name: text
order_number: int
order_date: DATE

Table: items
id: SERIAL
item_name: text
quantity: text
```

## 4. Decide on The Tables Relationship

Most of the time, you'll be using a **one-to-many** relationship, and will need a **foreign key** on one of the two tables.

To decide on which one, answer these two questions:

1. Can one [TABLE ONE] have many [TABLE TWO]? (Yes/No)
2. Can one [TABLE TWO] have many [TABLE ONE]? (Yes/No)

You'll then be able to say that:

1. **[A] has many [B]**
2. And on the other side, **[B] belongs to [A]**
3. In that case, the foreign key is in the table [B]

Replace the relevant bits in this example with your own:

```
1. Can one order have many albums? YES
2. Can one item have many orders? YES

-> Therefore,
-> An order HAS MANY items
-> An item BELONGS TO many orders

```

# *If you can answer YES to the two questions, you'll probably have to implement a Many-to-Many relationship, which is more complex and needs a third table (called a join table).*

As an example: a blog post can have many tags. But a tag can also be associated with many posts.

Can a post have many tags? - Yes
Can a tag have many posts? - Yes

When designing a many-to-many relationship, you will need a third table, acting as a “link” between to the tables. This is called a join table. It contains two columns, which are two foreign keys, each linking to the two tables.
The join table usually contains two columns, which are two foreign keys, each one linking to a record in the two other tables.
The naming convention is table1_table2.

# EXAMPLE

Join table for existing tables: orders & items
Join table name: items_orders
Columns: item_id, order_id

## 4. Write the SQL.

```sql
-- file: orders_items.sql

-- Replace the table name, columm names and types.

-- Create the first table.
CREATE TABLE orders  (
  customer_name text,
  order_number int,
  order_date DATE
);

-- Create the second table.
CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  item_name text,
  quantity int
);

-- Create the join table.
CREATE TABLE orders_items (
  order_id int,
  item_id int,
  constraint fk_order foreign key(order_id) references order(id) on delete cascade,
  constraint fk_item foreign key(item_id) references item(id) on delete cascade,
  PRIMARY KEY (order_id, item_id)
);

```

## 5. Create the tables.

```bash
psql -h 127.0.0.1 database_name < albums_table.sql
```

<!-- BEGIN GENERATED SECTION DO NOT EDIT -->

---

**How was this resource?**  
[😫](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Ftwo_table_design_recipe_template.md&prefill_Sentiment=😫) [😕](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Ftwo_table_design_recipe_template.md&prefill_Sentiment=😕) [😐](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Ftwo_table_design_recipe_template.md&prefill_Sentiment=😐) [🙂](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Ftwo_table_design_recipe_template.md&prefill_Sentiment=🙂) [😀](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Ftwo_table_design_recipe_template.md&prefill_Sentiment=😀)  
Click an emoji to tell us.

<!-- END GENERATED SECTION DO NOT EDIT -->