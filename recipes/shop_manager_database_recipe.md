# Shop Manager Database Design Recipe Template


## 1. User stories and nouns

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
Nouns: shop items, name, unit price, quantity, orders, customer name, date, 
```

## 2. Table Names and Columns

Put the different nouns in this table. Replace the example with your own nouns.

| Record                | Properties          |
| --------------------- | ------------------  |
| items                 | name, price, quantity
| orders                | customer name, date

1. Name of the first table (always plural): `items` 

    Column names: `name`, `price`, `quantity`

2. Name of the second table (always plural): `orders` 

    Column names: `customer_name`, `date`

## 3. Decide the column types.

[Here's a full documentation of PostgreSQL data types](https://www.postgresql.org/docs/current/datatype.html).

Most of the time, you'll need either `text`, `int`, `bigint`, `numeric`, or `boolean`. If you're in doubt, do some research or ask your peers.

Remember to **always** have the primary key `id` as a first column. Its type will always be `SERIAL`.

```
# EXAMPLE:

Table: item
id: SERIAL
name: text
price: 
quantity: int

Table: orders
id: SERIAL
customer_name: text
date: date
```

## 4. Design the Many-to-Many relationship

Make sure you can answer YES to these two questions:

1. Can one [TABLE ONE] have many [TABLE TWO]? (Yes/No)
2. Can one [TABLE TWO] have many [TABLE ONE]? (Yes/No)

```
# EXAMPLE

1. Can one item be ordered multiple times? YES
2. Can one order have many items? YES
```

_If you would answer "No" to one of these questions, you'll probably have to implement a One-to-Many relationship, which is simpler. Use the relevant design recipe in that case._

## 5. The Join Table

The join table usually contains two columns, which are two foreign keys, each one linking to a record in the two other tables.

The naming convention is `table1_table2`.

```
Join table for tables: items and orders
Join table name: items_orders
Columns: item_id, order_id
```

## 4. The SQL.

```sql
-- file: items_orders.sql

-- The first table.
CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name text,
  price money,
  quantity int
);

-- The second table.
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name text,
  date date
);

-- The join table.
CREATE TABLE items_orders (
  item_id int,
  order_id int,
  constraint fk_item foreign key(item_id) references items(id) on delete cascade,
  constraint fk_order foreign key(order_id) references orders(id) on delete cascade,
  PRIMARY KEY (item_id, order_id)
);

```

## 5. Create the database and tables.

```bash
createdb shop_manager;
psql -h 127.0.0.1 shop_manager < items_orders.sql;
```