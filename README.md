Shop Manager Project
=================
This is a terminal program that allows a shop manager to manage a shop database containing items and orders. The program will prompt the user to select from a list of options and perform the appropriate action based on their selection.

Usage:
-------
1. Clone the repository to your local machine.
```bash
git clone https://github.com/aze5/shop-manager-challenge.git
```
2. Navigate to the repository and run the following to install the Gems:
```bash
bundle install
```
3. Create a new PostgreSQL database and name it `shop_manager`
```bash
createdb shop_manager
```
4. Run the following to create the neccessary tables in your new database:
```bash
psql -h 127.0.0.1 shop_manager < lib/orders_table.sql
```
5. Run the following to start the program.
```bash
ruby app.rb 
```
6. Follow the prompts to manage the shop items and orders.

User stories:
-------
_This app was built based on the following user stories:_
1. As a shop manager, I want to keep a list of my shop items with their name and unit price so I can know which items I have in stock.
2. As a shop manager, I want to know which quantity I have for each item so I can manage my stock.
3. As a shop manager, I want to be able to create a new item so I can manage items.
4. As a shop manager, I want to keep a list of orders with their customer name so I can know which orders were made.
5. As a shop manager, I want to assign each order to their corresponding item so I can know which item was ordered.
6. As a shop manager, I want to know on which date an order was placed so I can keep track of when orders were made.
7. As a shop manager, I want to be able to create a new order so I can manage orders.

Terminal Output
------
```
Welcome to the shop management program!

What do you want to do?
  1 = list all shop items
  2 = create a new item
  3 = list all orders
  4 = create a new order
  5 = Exit program

1 [enter]

Here's a list of all shop items:

 #1 Super Shark Vacuum Cleaner - Unit price: 99 - Quantity: 30
 #2 Makerspresso Coffee Machine - Unit price: 69 - Quantity: 15
 (...)
```


Test Coverage
----------------------
Testing was done using RSpec. and simplecov was used to help measure and report on the coverage of the code.

To run the tests, navigate to the repository and run:
```bash
rspec
```
To run tests for a specific file, run:
```bash
rspec spec/<TEST FILE NAME>
```

You can see the test coverage when you run the tests. If you want this in a graphical form, uncomment the `SimpleCov::Formatter::HTMLFormatter` line in spec_helper.rb and run:
```bash
open coverage/index.html
```
