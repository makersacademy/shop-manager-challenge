Shop Manager Project
=================

I took this challenge very seriously and build an entire program out of it. 

I chose a many-to-many relationship between orders and items. One order can have many items and one item can also be found in many orders.

Currently, the program works pretty well. It still lacks some features such as input validity check but most of invalid inputs has been handled and it should run smoothly as long as the user follows the instructions and interact with existing data in database. Unfortunately there is no manual 'exit program' option for now for testing purposes.

If you happen to play around with the program, any feedbacks or bugs report will be highly appreciated :D I will be working on polishing this program as soon as I can find some spare time.

This repository includes a SQL file to create the tables
```
./orders_items.sql
```
and also a database seeds that contains 5 orders and 5 items to start with.
```
spec/seeds.sql
```

Getting started:
---------------
```
ruby app.rb
```

Description:
------------

When running the program, the user will be given the option to manage either orders or items. He will be able to switch repository from one to the other.

```
The Order Manager can:

 - print a formatted list of all orders
 - find and print, in a formatted form, an order along with the items sold
 - create a new order with items sold and automatically create links in the join table
 - update partially or entirely an existing order (date, customer name and/or items sold)
 - update items remaining stock when they are added to a new order
 - delete an existing order
 - print a feedback message when a task has been successfully executed

Exceptions handled:

 - most invalid input will prompt the user for a new answer
 - find method with id not found - the user will be prompt for a new order id
 - create a new order with non-valid items among valid ones - 
   non-valid items will be ignored, creation will be processed without them
   and a message "n items not found were ignored" will be printed.
 
Need to be fixed:

 - create method - adding multiple times the same item to the item list -> program crash
 - create and update methods - entering a non-valid format for date -> program crash
 - update method - entering non-existent item ids in list of item update prompt -> empty the list
 - update method - selecting a non-existent order -> program crash
 - update method - selecting a order with an empty list of items -> program crash
 - "0 items not found was ignored" dont need be displayed
 -
```
```
The Item Manager can:

 - find and print an item, just the item, in the formatted form
 - find and print, in the formatted form, an item with linked orders
 - create and automatcally add a new item
 - update partially or entirely an existing item (name, price and/or quantity)
 - delete an existing item
 - print a feedback message when a task has been successfully executed
 
Exceptions handled:
 
 - most invalid input will prompt the user for a new answer
 - find method with unknown id - the user will be ask for a new item id
 - 
 
Need to be fixed:
 - update method - selecting a non-existent item -> program crash
 -
```

General known issues:
--------------------
 
 - input validity check - the user can input anything in object attributes (text for prices, integer for names etc)
 - the program quit when it finishes a task 
   (tried to implement loops and a manual exit option but Rspec won't run if exit keyword is present)
 - maybe some formatting here and there
 - probably more ...
 
Update log:
----------
 - 06-03-2023 - general program refactoring
 - 06-03-2023 - initial release

The Challenge
-------------

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

Technical Approach:
------------------

In this unit, you integrated a database by using the `PG` gem, and test-driving and building Repository classes. You can continue to use this approach when building this challenge.

[You'll also need to mock IO](https://github.com/makersacademy/golden-square/blob/main/mocking_bites/05_unit_testing_terminal_io_bite.md) in your integration or unit tests, since the program will ask for user input.
