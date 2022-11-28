Shop Manager Project
=================

Challenge:
-------

We are going to write a small terminal program allowing the user to manage a shop database containing some items and orders.

User stories:
-------

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

## Getting started

`git clone https://github.com/jillwones/shop-manager-challenge.git`
`bundle install`       

Create 2 databases using PostgreSQL:
1. shop_challenge
2. shop_challenge_test

Create the relevant tables in both databases using:

```sql
-- Create the first table.
CREATE TABLE shop_items (
  id SERIAL PRIMARY KEY,
  name text,
  unit_price decimal,
  quantity int
);

-- Create the second table.
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name text,
  date_placed date
);

-- Create the join table.
CREATE TABLE shop_items_orders (
  shop_item_id int,
  order_id int,
  quantity int,
  constraint fk_shop_item foreign key(shop_item_id) references shop_items(id) on delete cascade,
  constraint fk_order foreign key(order_id) references orders(id) on delete cascade,
  PRIMARY KEY (shop_item_id, order_id)
);
```
Then populate the non test database with:
```sql
INSERT INTO orders (customer_name, date_placed) VALUES ('David', '08-Nov-2022');
INSERT INTO orders (customer_name, date_placed) VALUES ('Anna', '10-Nov-2022');
INSERT INTO orders (customer_name, date_placed) VALUES ('Jill', '11-Nov-2022');
INSERT INTO shop_items (name, unit_price, quantity) VALUES ('sandwich', 2.99, 10);
INSERT INTO shop_items (name, unit_price, quantity) VALUES ('bananas', 1.99, 15);
INSERT INTO shop_items (name, unit_price, quantity) VALUES ('toilet roll', 3.00, 20);
INSERT INTO shop_items (name, unit_price, quantity) VALUES ('crisps', 0.99, 15);
INSERT INTO shop_items (name, unit_price, quantity) VALUES ('sausage roll', 1.50, 10);
INSERT INTO shop_items_orders (shop_item_id, order_id, quantity) VALUES (1,1,2);
INSERT INTO shop_items_orders (shop_item_id, order_id, quantity) VALUES (4,1,1);
INSERT INTO shop_items_orders (shop_item_id, order_id, quantity) VALUES (5,1,5);
INSERT INTO shop_items_orders (shop_item_id, order_id, quantity) VALUES (2,2,1);
INSERT INTO shop_items_orders (shop_item_id, order_id, quantity) VALUES (3,3,1);
INSERT INTO shop_items_orders (shop_item_id, order_id, quantity) VALUES (1,3,1);
```



## Usage

Uncomment the following lines in the app.rb file:
```ruby
# app = Application.new('shop_challenge_test', Kernel, OrderRepository.new, ShopItemRepository.new)
# app.run
```
Then in the terminal:
`ruby app.rb`

## Running tests

`rspec`

