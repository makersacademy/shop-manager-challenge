
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

Nouns:
itmes
items name
items price
items stock
item order_id
order
order customer name
order date

Relationship Type
Can an item have many orders? NO
Can an order have many items? NO
One-tom-many
Each item belongs to an order

Table: items
id: SERIAL PRIMARY KEY
name: text
price: int 
stock: int

Table: orders
id: SERIAL PRIMARY KEY
customer: text
date: text
item_id: int FOREIGN KEY

Classes:
Order
OrderRepository
Item
ItemRepository

Methods:
OrderRepository#create(order)
OrderRepository#all_with_items

ItemRepository#create(item)
ItemRepository#all





Example terminal:

```
Welcome to the shop management program!

What do you want to do?
  1 = list all shop items
  2 = create a new item
  3 = list all orders
  4 = create a new order

1 [enter]

Here's a list of all shop items:

 #1 Super Shark Vacuum Cleaner - Unit price: 99 - Quantity: 30
 #2 Makerspresso Coffee Machine - Unit price: 69 - Quantity: 15
 (...)
```

