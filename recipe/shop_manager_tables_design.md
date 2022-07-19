# Two Tables Design Recipe Template

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

shop items, items' names, items' unit price, items' quantity (number)

methods: list, create

orders (list), orders customer names, orders date

methods: list, create

assign each order to their corresponding item.
```

## 2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.

| Record                | Properties                 |
| --------------------- | ---------------------------|
| item                  | name, unit price, quantity | 
| order                 | customer_name, date             |

1. Name of the first table (always plural): `item` 

    Column names: `name`, `unit_price`, `quantity`

2. Name of the second table (always plural): `orders` 

    Column names: `customer_name`, `date`

## 3. Decide the column types.
```

Table: items
id: SERIAL
name: text
unit_price: money
quantity: int

Table: orders
id: SERIAL
customer_name: text
date: date
```

## 4. Decide on The Tables Relationship

1. Can one [TABLE ONE] have many [TABLE TWO]? Yes
2. Can one [TABLE TWO] have many [TABLE ONE]? Yes

## 5. Design the Join Table

The join table usually contains two columns, which are two foreign keys, each one linking to a record in the two other tables.

```
Join table for tables: items and orders
Join table name: items_orders
Columns: item_id, order_id
```
## 6. Write the SQL.

```sql

-- file: seeds_shop_data.sql

-- Create the first table.
CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name: text,
  unit_price: money,
  quantity: int
);

-- Create the second table.
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer: text,
  order_quantity: int,
  date: date
);

-- Create the join table.
CREATE TABLE items_orders (
  item_id int,
  order_id int,
  constraint fk_item foreign key(item_id) references items(id),
  constraint fk_order foreign key(order_id) references orders(id),
  PRIMARY KEY (item_id, order_id)
);

INSERT INTO items (name, unit_price, quantity) VALUES
('milk', 1, 35),
('cheese', 3.50, 55),
('bread', 2.75, 10),
('6 eggs', 2.33, 28),
('orange juice', 1.30, 20);

INSERT INTO orders (customer, order_quantity, date) VALUES
('Anna', '2022-06-21'),
('John', '2022-06-23'),
('Rachel', '2022-07-01');

INSERT INTO items_orders (item_id , order_id) VALUES
( 1, 1),
( 1, 2),
( 1, 3),
( 2, 1),
( 3, 2),
( 3, 3),
( 4, 2),
( 4, 3),
( 5, 1),
( 5, 2),
( 5, 3);
```

## 7. Create the tables.

```bash
psql -h 127.0.0.1 shop_database < seeds_shop_data.sql
```