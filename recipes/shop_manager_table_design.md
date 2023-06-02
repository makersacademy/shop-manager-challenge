# Shop-manager Tables Design Recipe Template

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

list of shop items, item_name, item_unit_price, stock_quantity;
list of orders, order_customer_name, order_date
```

## 2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.

| Record                | Properties                        |
| --------------------- | ------------------------          |
| item                  | name, unit_price, quantity
| order                 | customer_name, order_date
| order_item            | order_id, item_id, quantity

1. Name of the first table (always plural): `items` 

    Column names: `name`, `unit_price`, `quantity`

2. Name of the second table (always plural): `orders` 

    Column names: `customer_name`, `order_date`

3. Name of the third table (always plural): `orders` 

    Column names: `order_id`, `item_id`, `quantity`

## 3. Decide the column types.

[Here's a full documentation of PostgreSQL data types](https://www.postgresql.org/docs/current/datatype.html).

Most of the time, you'll need either `text`, `int`, `bigint`, `numeric`, or `boolean`. If you're in doubt, do some research or ask your peers.

Remember to **always** have the primary key `id` as a first column. Its type will always be `SERIAL`.

```
# EXAMPLE:

Table: items
id: SERIAL
name: text
unit_price: decimal
quantity: int

Table: orders
id: SERIAL
customer_name: text
order_date: date

Table: order_items
order_id: int
item_id: int
quantity: int
```

## 4. Design the Many-to-Many relationship

Make sure you can answer YES to these two questions:

1. Can one [TABLE ONE] have many [TABLE TWO]? (Yes/No)
2. Can one [TABLE TWO] have many [TABLE ONE]? (Yes/No)

```
# EXAMPLE

1. Can one item have many order? YES
2. Can one order have many items? YES
```

_If you would answer "No" to one of these questions, you'll probably have to implement a One-to-Many relationship, which is simpler. Use the relevant design recipe in that case._

## 5. Design the Join Table

The join table usually contains two columns, which are two foreign keys, each one linking to a record in the two other tables.

The naming convention is `order_items`.

```
# EXAMPLE

Join table for tables: items and orders
Join table name: order_items
Columns: order_id, item_id
```

## 4. Write the SQL.

```sql
-- EXAMPLE
-- file: schema_shop_manager.sql

-- Replace the table name, columm names and types.

-- Create the first table.
CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  unit_price DECIMAL(10, 2),
  quantity INTEGER DEFAULT 0
);

CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name VARCHAR(255),
  order_date DATE
);

CREATE TABLE order_items (
  order_id INT,
  item_id INT,
  quantity INT,
  CONSTRAINT fk_order FOREIGN KEY (order_id) REFERENCES orders (id) ON DELETE CASCADE,
  CONSTRAINT fk_item FOREIGN KEY (item_id) REFERENCES items (id) ON DELETE CASCADE,
  PRIMARY KEY (order_id, item_id)
);

```

## 5. Create the tables.

```bash
psql -h 127.0.0.1 database_name < schema_shop_manager.sql
```