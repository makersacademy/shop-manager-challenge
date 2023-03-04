# Two Tables (Many-to-Many) Design Recipe Template

## 1. Extract nouns from the user stories or specification

```
As a shop manager
So I can know which items I have in stock
I want to keep a list of my shop items with their name and unit price.
I want to know which quantity (a number) I have for each item.

So I can manage items
I want to be able to create a new item.


So I can know which orders were made
I want to keep a list of orders with their customer name.
I want to assign each order to their corresponding item.
I want to know on which date an order was placed. 

So I can manage orders
I want to be able to create a new order.
```

```
Nouns:
items item_name quantity price
orders customer_name item_ordered date_of_order
```

## 2. Infer the Table Name and Columns

| Record                | Properties          |
| --------------------- | ------------------  |
items = id, name, quantity, price
orders = id, customer, date


## 3. Decide the column types.

```
# EXAMPLE:
Table: items
id: SERIAL
name: text
quantity: int
price: int

Table: orders
id: SERIAL
customer: name
date: date
```

## 4. Design the Many-to-Many relationship

```
1. Can one ITEM have many ORDERS? YES
2. Can one ORDER have many ITEM? YES
```

## 5. Design the Join Table

```
Join table for tables: orders and items
Join table name: orders_items
Columns: order_id, item_id
```

## 4. Write the SQL.

```sql
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  date date,
  customer text
);

CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name text,
  quantity int,
  price int
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
psql -h 127.0.0.1 database_name < posts_tags.sql
```