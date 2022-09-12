# Two Tables (Many-to-Many) Design Recipe Template

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

shop_items, name, unit_price, quantity, order, customer_name, date
```

## 2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.

| Record                | Properties          |
| --------------------- | ------------------  |
| item                  | name, price, quantity
| order                 | customer, date

1. Name of the first table (always plural): `items` 

    Column names: `name`, `price`, `quantity`

2. Name of the second table (always plural): `orders` 

    Column names: `cutomer`, `date`

## 3. Decide the column types.

```


Table: items
id: SERIAL
name: text
price: float
quantity: integer

Table: orders
id: SERIAL
customer: text
date: date
```

## 4. Design the Many-to-Many relationship

```
1. Can one item have many orders? YES
2. Can one order have many items? YES
```


## 5. Design the Join Table

The join table usually contains two columns, which are two foreign keys, each one linking to a record in the two other tables.

The naming convention is `item_order`.

```

Join table for tables: items and orders
Join table name: item_order
Columns: item_id, order_id
```

## 4. Write the SQL.

```sql
-- file: items_orders.sql

CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name text,
  price float,
  quantity integer
);

CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer text,
  date date
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
psql -h 127.0.0.1 book_store_solo < items_orders.sql
```
