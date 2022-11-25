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

list of products(shop items), name, unit price, quanitity, 
Create new item
list of orders, customer name, item_id, date, 
Create new order
```

## 2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.

| Record                | Properties          |
| --------------------- | ------------------  |
| stock                 | name, unit price, quantity
| order                 | customer_name, item_id, date


## 3. Decide the column types.

[Here's a full documentation of PostgreSQL data types](https://www.postgresql.org/docs/current/datatype.html).

Most of the time, you'll need either `text`, `int`, `bigint`, `numeric`, or `boolean`. If you're in doubt, do some research or ask your peers.

Remember to **always** have the primary key `id` as a first column. Its type will always be `SERIAL`.

```
# EXAMPLE:

Table: Products
id: SERIAL 
name: text
unit_price: float
quantity: int

Table: Orders
id: SERIAL
customer_name: text
item_id: int
date: date
```

## 4. Decide on The Tables Relationship

Most of the time, you'll be using a **one-to-many** relationship, and will need a **foreign key** on one of the two tables.

To decide on which one, answer these two questions:

1. Can one product have many orders? (Yes/No) YES
2. Can one order have many products? (Yes/No) YES

You'll then be able to say that:

1. **[User] has many [Posts]**
2. And on the other side, **[Posts] belongs to [User]**
3. In that case, the foreign key is in the table [Posts]

## 5. Design the Join Table

# EXAMPLE
The join table usually contains two columns, which are two foreign keys, each one linking to a record in the two other tables.

The naming convention is table1_table2.

Join table for tables: products and orderss
Join table name: products_orders
Columns: order_id, post_id

## 6. Write the SQL.




```sql
CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  name text,
  unit_price float,
  quantity int
);

-- Create the second table.
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name text,
  date date
);

-- Create the join table.
CREATE TABLE products_orders (
  product_id int,
  order_id int,
  constraint fk_product foreign key(product_id) references products(id) on delete cascade,
  constraint fk_order foreign key(order_id) references orders(id) on delete cascade,
  PRIMARY KEY (product_id, order_id)
);

```

## 5. Create the tables.

```bash
psql -h 127.0.0.1 database_name < albums_table.sql
```