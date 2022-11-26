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
To run the application asit is intended to be used, comment out the break in the run method in app.rb. Then run appp.rb.

```
## Project Description

This challenges purpose was:
*To practice test driven development
*Use doubles for testing
*Use postgreSQL for data bases (including many-to-many mappings)
*Practice object oriented programing.  
  
This application allows a user to:
> List all items in stock, including quantities and unit prices 
> Create new items to be added to the stock list, which also updates the database
> List all previous orders, including customer name, item(s) purchased, date of purchase
> Create a new order, including quanity required, which updates the database.
> It also doesn't allow an order to be created if stock is too low
