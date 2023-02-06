# Two Tables (Many-to-Many) Design Recipe Template
## 1. Extract nouns from the user stories or specification

```
# EXAMPLE USER STORIES:

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

items, item name, unit price, quantity, orders, customer name, order date
```

## 2. Infer the Table Name and Columns

| Record                | Properties          |
| --------------------- | ------------------  |
| items                 | id, name, price, quantity
| orders                | id, customer name, order date

1. Name of the first table (always plural): `items` 

    Column names: `id`, `name`, `price`, `quantity`

2. Name of the second table (always plural): `orders` 

    Column names: `id`, `customer name`, `order date`

## 3. Decide the column types.


```

Table: items
id: SERIAL
name: text
price: int
quantity: int

Table: orders
id: SERIAL
customer name: text
order date: date
```

## 4. Design the Many-to-Many relationship

Make sure you can answer YES to these two questions:

1. Can one item have many orders? Yes
2. Can one order have many items? Yes

```
# EXAMPLE


```

_If you would answer "No" to one of these questions, you'll probably have to implement a One-to-Many relationship, which is simpler. Use the relevant design recipe in that case._

## 5. Design the Join Table

The join table usually contains two columns, which are two foreign keys, each one linking to a record in the two other tables.

The naming convention is `table1_table2`.

```
# EXAMPLE

Join table for tables: items orders
Join table name: items_orders
Columns: item_id, order_id
```

## 4. Write the SQL.

```sql
-- EXAMPLE


CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name text,
  price int,
  quantity int
);

CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name text,
  order_date date
);

-- Create the join table.
CREATE TABLE items_orders (
  item_id int,
  order_id int,
  constraint fk_post foreign key(item_id) references items(id) on delete cascade,
  constraint fk_tag foreign key(order_id) references orders(id) on delete cascade,
  PRIMARY KEY (item_id, order_id)
);

```

## 5. Create the tables.

```bash
psql -h 127.0.0.1 database_name < posts_tags.sql
```


