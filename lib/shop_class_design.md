# Shop Tables Design Recipe

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

items, name, price, quantity, orders, customer_name, date, new_order 
```

## 2. Infer the Table Name and Columns

| Record                | Properties          |
| --------------------- | ------------------  |
| items                 | name, price, quantity
| orders                | customer_name, date

1. Name of the first table (always plural): `items` 

    Column names: `name`, `price`, `quantity`

2. Name of the second table (always plural): `orders` 

    Column names: `customer_name`, `date`

## 3. Decide the column types.

```
Table: orders
id: SERIAL
customer_name: text
date: date DEFAULT now()

Table: items
id: SERIAL
name: text
unit_price: int
quantity: int
```

## 4. Design the Many-to-Many relationship

```
1. Can one item have many orders? YES
2. Can one order have many items? YES
```

## 5. Design the Join Table

```
Join table for tables: orders - items
Join table name: orders_items
Columns:  order_id, item_id
```

## 4. Write the SQL.

```sql
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name text,
  date_ordered date
);

CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name text,
  unit_price int,
  quantity int
);

CREATE TABLE orders_items (
  order_id int,
  item_id int,
  constraint fk_order foreign key(order_id) references orders(id) on delete cascade,
  constraint fk_item foreign key(item_id) references items(id) on delete cascade,
  PRIMARY KEY (order_id, item_id)
);

```

## 5. Create the tables.

```bash
psql -h 127.0.0.1 shop < ./lib/orders_items.sql
```