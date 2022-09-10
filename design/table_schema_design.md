# Shop Manager - Database Tables Design

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

items: name, price
stock: quantity
order: customer name, item, date
customer: name
```

## 2. Infer the Table Name and Columns


| Record (Table)        | Properties                  |
| --------------------- | --------------------------- |
| items                 | name, price, stock_qty      |
| orders                | customer, item_id, date     |

1. Table 1 name: `items` 

    Column names: `name`, `price`, `stock_qty`

2. Table 2 name: `orders` 

    Column names: `customer`, `item_id`, `date`

## 3. Decide the column types.

```
# EXAMPLE:

Table: items
id: SERIAL
name: text
price: int
stock_qty: int

Table: orders
id: SERIAL
customer: text
item_id: int
date: date
```

## 4. Design the Many-to-Many relationship

```
1. Can one order have many items? YES
2. Can one item have many orders? YES
```

## 5. Design the Join Table

```
Join table for tables: items and orders
Join table name: items_orders
Columns: item_id, order_id
```

## 4. Write the SQL.

```sql

CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name text,
  price int,
  stock_qty int
);

CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer text,
  item_id int,
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
psql -h 127.0.0.1 shop_manager < items_orders.sql
```