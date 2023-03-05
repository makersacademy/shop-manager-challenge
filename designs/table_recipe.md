# Two Tables Design Recipe Template

## 1. Extract nouns from the user stories or specification

```
# USER STORY:

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

items, name, unit_price, quantity, orders, customer_name, date
```

## 2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.

| Record                | Properties          |
| --------------------- | ------------------  |
| item                  | item_name, unit_price, quantity
| order                 | customer_name, order_date, item_id

1. Name of the first table: `items` 

    Column names: `item_name`, `unit_price`, `quantity`

2. Name of the second table: `order` 

    Column names: `customer_name`, `order_date`, `item_id`

## 3. Decide the column types.

```

Table: items
id: SERIAL
item_ame: text
unit_price: numeric
quantity: int


Table: orders
id: SERIAL
customer_name: text
order_date: date
item_id: int(foreign key)
```

## 4. Decide on The Tables Relationship


```
# EXAMPLE

1. Can one item have many orders? YES
2. Can one order have many items? NO

-> Therefore,
-> An item HAS MANY orders
-> An order BELONGS TO an item

-> Therefore, the foreign key is on the orders table.
```

## 4. Write the SQL.

```sql
-- file: schema/items_orders_table.sql

CREATE TABLE items(
  id SERIAL PRIMARY KEY,
  item_name text,
  unit_price numeric,
  quantity int
);

CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name text,
  order_date date,
  item_id int,
  constraint fk_item foreign key(item_id)
    references items(id)
    on delete cascade
);

```

## 5. Create the tables.

```bash
psql -h 127.0.0.1 shop < schema/items_orders_table.sql
psql -h 127.0.0.1 shop_test < schema/items_orders_table.sql
```

