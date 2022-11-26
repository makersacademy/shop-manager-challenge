# Shop Manager Tables Design Recipe 

## 1. Extract nouns from the user stories or specification

```
# USER STORIES:

As a shop manager
So I can know which items I have in stock
I want to keep a list of my shop items with their name and unit price.

As a shop manager
So I can know which items I have in stock
I want to know which quantity (a number) I have for each item.

As a shop manager
So I can manage items
I want to be able to create a new item.
≈

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

list of items, item_name, unit_price, quantity
list of orders, customer_name, date
```

### Notes_and observations 
* Mininum Viable Product will be: 
  * Create function needed for items 
  * Create function needed for orders 
* Orders and Items will be many-to many. Three tables needed 

## 2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.

| Record                | Properties          |
| --------------------- | ------------------  |
| items                 | name, unit_price, quanity
| orders                | customer_name, date

1. Name of the first table (always plural): `items` 

    Column names: `name`, `unit_price`, `quantity`

2. Name of the second table (always plural): `orders` 

    Column names: `customer_name`, `date`

## 3. Decide the column types.

[Here's a full documentation of PostgreSQL data types](https://www.postgresql.org/docs/current/datatype.html).

Most of the time, you'll need either `text`, `int`, `bigint`, `numeric`, or `boolean`. If you're in doubt, do some research or ask your peers.

Remember to **always** have the primary key `id` as a first column. Its type will always be `SERIAL`.

```
# EXAMPLE:

Table: items
id: SERIAL
name: text
unit_price: numeric (5,2)
quantity: int 

Table: orders
id: SERIAL
customer_name: text
date: date 
```

### Note: 'Money' is deliberately not being selected for unit price. See the following guidance from PSQL 

- 'If you require exact storage and calculations (such as for monetary amounts), use the numeric type instead.'

## 4. Design the table relationship


1. Can one [item] have many [orders]? Yes
2. Can one [order] have many [items]? Yes

Therefore, items and orders have a many-to-many relationship


## 5. Design the Join Table

The join table usually contains two columns, which are two foreign keys, each one linking to a record in the two other tables.

The naming convention is `table1_table2`.

```
# EXAMPLE

Join table for tables: items and orders
Join table name: items_orders
Columns: item_id, order_id
```

## 4. Write the SQL.

```sql

CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name text,
  unit_price numeric(3, 2),
  quantity int
);


CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name text,
  date  date
);


CREATE TABLE items_orders (
  item_id int,
  order_id int,
  constraint fk_item foreign key(item_id) references items(id) on delete cascade,
  constraint fk_order foreign key(order_id) references orders(id) on delete cascade,
  PRIMARY KEY (item_id, order_id)
);

```

## 5. Create the tables.

```bash
psql -h 127.0.0.1 database_name < posts_tags.sql
```
