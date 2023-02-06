Shop Manager Project
=================

A challenge by Makers Academy, [forked from this repo](https://github.com/makersacademy/shop-manager-challenge/fork).

This challenge involves writing a small terminal program that allows the user to manage a shop database containing some items and orders.

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

An example of the terminal output the program generates:

```
Welcome to the shop manager!

1 - List all shop items
2 - Find info on a specific item
3 - Create a new item
4 - List all orders
5 - Find info on a specific order
6 - Create a new order
7 - Quit

1 [enter]

Here is the list of shop items:
1. 叉烧包 - ID: 1
2. Chicken Rice - ID: 2
 (...)
```

Technicalities:
-----

This program integrates the shop's database by using the `PG` gem, and through test-driven Repository classes. 

The program also mocks IO in the integration & unit tests, since the program asks for user input.

Notes on test coverage
----------------------

The following is located **AT THE TOP** of your spec_helper.rb in order to have test coverage stats generated
on my pull request to Makers Academy:

```ruby
require 'simplecov'
require 'simplecov-console'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::Console,
  # Want a nice code coverage website? Uncomment this next line!
  # SimpleCov::Formatter::HTMLFormatter
])
SimpleCov.start
```

The test coverage can be seen when the tests are run. To get this in a graphical form, uncomment the `HTMLFormatter` line.
