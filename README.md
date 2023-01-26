Shop Manager Project
=================

This my solution for the solo project of the [Makers bootcamp databases module](https://github.com/atcq9876/databases-sql) (week 3 of the bootcamp). For this challenge, I was tasked with writing a small terminal program allowing the user to manage a shop database containing some items and orders. The user is able to list shop items, create items, list orders and create orders.

The objectives of this module were to:

- Design a database schema with at least two tables from a specification, including a one-to-many relationship between two tables, and create the schema in a database using SQL.
- Use SQL to query a database to read data from one table or resulting of a join, create new records, update and delete.
- Integrate a relational database to a program by test-driving classes which implement CRUD methods to send SQL queries to a database.
Explain how your program communicates with the database by creating a sequence diagram.

This challenge supported me in achieving these objectives. The challenge instructions I followed are outlined below.

Challenge:
-------

Please start by [forking this repo](https://github.com/makersacademy/shop-manager-challenge/fork), then clone your fork to your local machine. Work into that directory.

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

Technical Approach:
-----

In this unit, you integrated a database by using the `PG` gem, and test-driving and building Repository classes. You can continue to use this approach when building this challenge.

[You'll also need to mock IO](https://github.com/makersacademy/golden-square/blob/main/mocking_bites/05_unit_testing_terminal_io_bite.md) in your integration or unit tests, since the program will ask for user input.
