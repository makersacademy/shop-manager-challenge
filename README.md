Shop Manager Project
=================

Challenge:
-------

Write a small terminal program allowing the user to manage a shop database containing some items and orders.

My Programme Description:
-------

This is shop database that manages items and orders, with the following capabilites:

* Show all shop items 
* Create a new shop item
* Show all shop orders
* Create a new shop order 

Features: 

* Using SQL joins, the order and items table are able to interact, allowing the app to display an order and include its contents 

Notes:

* This is an MVP to demonstrate my ability to design, create and implement database schema, repository and model classes, and an application class

Features I would add:

* Dynamic stock management (quantity is depleted when item is ordered, not allowing out of stock items to be ordered)
* Allowing orders with multiple items to be created 
* Expanded error handling 
* More scalable order creation function - currently displays item menu to users and asks for ID - as shop grows this will lead to a poor UX
* Implementing Update, and Delete functions 




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

Here's an example of the terminal output your program should generate (yours might be slightly different — that's totally OK):

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
