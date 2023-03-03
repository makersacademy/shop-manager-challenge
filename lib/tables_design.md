# Two Tables Design Recipe Template

_Copy this recipe template to design and create two related database tables from a specification._

## 1. User stories 

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

shop, item, name, price, quantity, orders, customer, date
```
## 2. Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.

| Record                | Properties          |
| --------------------- | ------------------  |
| items                 | name, price, content
| orders                | customer, date



## 3. Column types.

```

Table: items
id: SERIAL
name: text
price: float
dat: date

Table: orders
id: SERIAL
customer: text
date: date
```

## 4. Tables Relationship


1. **[order] has many [items]**
2. In that case, the foreign key is in the table [items]


## 4. Write the SQL.

```sql
-- file: order_table.sql


CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer TEXT,
  date DATE
);

-- Then the table with the foreign key first.
CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name TEXT,
  price FLOAT,
  quantity INT
  order_id INT,
  constraint fk_order foreign key(order_id)
    references orders(id)
    on delete cascade
);

```

## 5. Create the tables.

```bash
psql -h 127.0.0.1 shop_manager < orders_table.sql
```
