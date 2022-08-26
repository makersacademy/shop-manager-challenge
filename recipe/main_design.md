# Two Tables Design Recipe Template

## 1. Extract nouns from the user stories or specification

```
# EXAMPLE USER STORY:

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

shop ITEMS, name, price, quantity,

create new item, 

orders, customer name, date_placed, create new order
# order will be accosiated with item
```

## 2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.

| Record                | Properties          |
| --------------------- | ------------------  |
| items                | name, price, quantity
| orders                | customer_name, date_placed, item_id

1. Name of the first table (always plural): `items` 

    Column names: `name`, `price`, `quantity`

2. Name of the second table (always plural): `orders` 

    Column names: `customer_name`, `date_placed`, `item_id`

## 3. Decide the column types.
```
# EXAMPLE:

Table: items
id: SERIAL
name: text
price: int
quantity: int

Table: orders
id: SERIAL
customer_name: text
date: date
item_id: int
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

## 4. Write the SQL.

```sql
-- EXAMPLE

CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name text,
  price int,
  quantity int
);

CREATE TABLE order (
  id SERIAL PRIMARY KEY,
  customer_name text,
  order_date date,
  item_id int,
  constraint fk_item foreign key(item_id) references item(id)
);

```

## 5. Create the tables.

```bash
psql -h 127.0.0.1 database_name < db.sql
```

