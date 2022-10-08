# Shop Manager Project

<div align="left">
  <img alt="GitHub top language" src="https://img.shields.io/github/languages/top/EvSivtsova/shop-manager-challenge">
</div>
<div>
  <img src="https://img.shields.io/badge/postgres-%23316192.svg?style=for-the-badge&logo=postgresql&logoColor=white"/> 
  <img src="https://img.shields.io/badge/RSpec-blue?style=for-the-badge&logo=Rspec&logoColor=white" alt="Rspec"/>
  <img src="https://img.shields.io/badge/Test_coverage:_99.27-blue?style=for-the-badge&logo=Rspec&logoColor=white" alt="Rspec"/>
</div><br>

This is Makers' Academy challenge with the following requirements:

=================

* Feel free to use Google, your notes, books, etc. but work on your own
* If you refer to the solution of another coach or student, please put a link to that in your README
* If you have a partial solution, **still check in a partial solution**
* You must submit a pull request to this repo with your code next Monday morning

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

Technical Approach (by Makers):
-----

In this unit, you integrated a database by using the `PG` gem, and test-driving and building Repository classes. You can continue to use this approach when building this challenge.

[You'll also need to mock IO](https://github.com/makersacademy/golden-square/blob/main/mocking_bites/05_unit_testing_terminal_io_bite.md) in your integration or unit tests, since the program will ask for user input.

## TechBit

Technologies used: 
* Ruby(3.0.0)
* RVM
* Rspec(Testing)
* Rubocop(Linter)
* Simplecov(Test Coverage)

To clone the repository and install the dependencies within the project folder:

```
git clone https://github.com/EvSivtsova/shop-manager-challenge.git
cd shop-manager-challenge
bundle install
```
You will need to create a database to run the app:

```
createdb shop_database
```

You can either use data seeds to play with the program:

```
psql -h 127.0.0.1 shop_database < spec/seeds_shop_data.sql
```

or run the following command to create data tables without populating them:

```
psql -h 127.0.0.1 shop_database < lib/shop_database.sql
```

To run the program:

```
ruby app.rb
```

To run the tests:

```
createdb shop_database_test
psql -h 127.0.0.1 shop_database_tests < spec/seeds_shop_data.sql
rspec
```

## Code design

There are two model and two repository classes: 
1. Item and Item Repository class - allows to create and manage stock items.
2. Order and Order Repository classes - allow to create and manage customer orders.

These classes are integrated in the App class, which:
* lists all shop items and orders
* allows to create new items and orders
* prints order details to the console
* show orders and stock for a particular item

The program has a command line interface.

<img src="https://github.com/EvSivtsova/shop-manager-challenge/blob/main/outputs/List%20all%20shop%20items.png" width='500'>

Please view outputs for every option [here](https://github.com/EvSivtsova/shop-manager-challenge/tree/main/outputs)


Test coverage: 99.27% <br>
<img src='https://github.com/EvSivtsova/shop-manager-challenge/blob/main/outputs/shop-manager-challenge-coverage.png' width='300'>
