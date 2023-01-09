# Two Tables Design Recipe Template

_Copy this recipe template to design and create two related database tables from a specification._

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

stock, quantity, unit price, customer name, time, date

Verbs:
Create new items, list orders, create new orders
```



## 2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.

| items                 | orders          |
| --------------------- | ----------------|
| quantity               customer name
| unit price            
                         date
  

1. Name of the first table (always plural): `items` 

    Column names: `quantity`, `unit_price`

2. Name of the second table (always plural): `orders` 

    Column names: `customer_name`, 'date'

Methods for items

list_all
create_new_item

Methods for orders
List orders
create orders



## 3. Decide the column types.

```
# EXAMPLE:

Table: items
id: SERIAL
quantity: int
unit_price: int

Table: orders
id: SERIAL
customer_name: text
date: date
```

## 4. Decide on The Tables Relationship

Most of the time, you'll be using a **one-to-many** relationship, and will need a **foreign key** on one of the two tables.

To decide on which one, answer these two questions:

1. Can one orders have many items? (Yes/No) Yes
2. Can one item have many orders? (Yes/No) No

You'll then be able to say that:

1. **[A] has many [B]**
2. And on the other side, **[B] belongs to [A]**
3. In that case, the foreign key is in the table [B]

Replace the relevant bits in this example with your own:

```

## 4. Write the SQL.

```sql
CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  quantity int,
  unit_price int
);

CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name text,
  date date
);

-- Create the join table.
CREATE TABLE posts_tags (
  item_id int,
  order_id int,
  constraint fk_item foreign key(item_id) references items(id) on delete cascade,
  constraint fk_order foreign key(order_id) references orders(id) on delete cascade,
  PRIMARY KEY (item_id, order_id)
);

```

## 5. Create the tables.

```bash
psql -h 127.0.0.1 shop_manager < shop_tables.sql
```
