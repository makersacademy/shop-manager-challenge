

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

album, title, release year, artist, name
```

## 2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.

| Record                | Properties          |
| --------------------- | ------------------  |
| items                 | id, item_name, price, quantity, order_id
| orders                | id, customer_name, date

1. Name of the first table (always plural): `orders` 

    Column names: `customer_name`, `date`, `item_id`

2. Name of the second table (always plural): `items` 

    Column names: `item_name`, `price`, `quantity`

## 3. Decide the column types.

[Here's a full documentation of PostgreSQL data types](https://www.postgresql.org/docs/current/datatype.html).

Most of the time, you'll need either `text`, `int`, `bigint`, `numeric`, or `boolean`. If you're in doubt, do some research or ask your peers.

Remember to **always** have the primary key `id` as a first column. Its type will always be `SERIAL`.

```
# EXAMPLE:

Table: orders
id: SERIAL
costumer_name: text
date: date
item_id: int

Table: items
id: SERIAL
item_name: text
price: money
quantity: int
```

## 4. Decide on The Tables Relationship

Most of the time, you'll be using a **one-to-many** relationship, and will need a **foreign key** on one of the two tables.

To decide on which one, answer these two questions:

1. Can one [order] have many [items]? (Yes)
2. Can one [item] have many [orders]? (Yes)


Replace the relevant bits in this example with your own:

*If you can answer YES to the two questions, you'll probably have to implement a Many-to-Many relationship, which is more complex and needs a third table (called a join table).*

## 3. Join Table

Join table for tables: items and orders
Join table name: items_orders
Columns: item_id, post_id

## 4. Write the SQL.

```sql

CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  item_name text,
  price money,
  quantity int
);


CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name text,
  date date
);

-- Create the join table.
CREATE TABLE items_orders (
  item_id int,
  order_id int,
  constraint fk_item foreign key(item_id) references items(id),
  constraint fk_order foreign key(order_id) references orders(id),
  PRIMARY KEY (item_id, order_id)
);

```

## 5. Create the tables.

```bash
psql -h 127.0.0.1 shop_manager < shop_manager.sql
```
