# Shop Manager Tables Design Recipe

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

shop items, item name, item unit price, item quantity, orders, customer name, order item, order date
```

## 2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.

| Record                | Properties          |
| --------------------- | ------------------  |
| item                  | name, price, quantity
| order                 | customer, date, item_id

1. Name of the first table (always plural): `items` 

    Column names: `name`, `price`, `quantity`

2. Name of the second table (always plural): `orders` 

    Column names: `customer`, `date`

## 3. Decide the column types.

```
Table: items
id: SERIAL
name: text
price: int          ie (0.45)/(12)
quantity: int

Table: orders
id: SERIAL
customer: text
date: date
```

## 4. Decide on The Tables Relationship

1. Can one [item] have many [orders]? (Yes)
2. Can one [order] have many [items]? (No)

You'll then be able to say that:

1. **[items] has many [orders]**
2. And on the other side, **[orders] belongs to [items]**
3. In that case, the foreign key is in the table [orders]

```
-> Therefore, the foreign key is on the albums table.       => (item_id)
```

## 4. Write the SQL.

```sql
-- file: items_table.sql

CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name text, 
  price int, 
  quantity int
);

CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer text,
  date int,
  item_id int,
  constraint fk_item foreign key(item_id)
    references items(id)
    on delete cascade
);

```

## 5. Create the tables.

```bash
psql -h 127.0.0.1 database_name < albums_table.sql
```
