Solo project at the end of Week 3 at Makers
=================
## Practice of :

* database schema development
* using psql as the database
* writing sql statements
* test driving model and repository classes
* test driving an Application class with terminal interface
* mostly done from memory, but using reference where memory/knowledge fails

## Process:

## Extraction of schema data from the user stories:

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
items         id, name, unit_price, stock_quantity
orders        id, customer_name, item_id, order_date
```
A list of initial considerations/design decisions:
* The first thing to note is that the app will not be useable in real life but
as it is an exercise I'll match the specification rather than add extra specs.
* One design choice is whether to have a customers table. A better design would
have one, but as per specification it is not needed. 
* There are no requirements for updating stock numbers (refilling stock,
drecrease on order), checking about sufficient inventory on order, etc.
* By the specs, an order can have one item "assign each order to their
corresponding 'item'". This means one to many relationship, rather than many to
many which would make more sense if one order could have many items.

## Creating database schema and writing the sql
```sql
-- two tables, one-to-many connection of item to orders items pk will be in
-- orders table as fk (item_id)

-- file: "spec/seeds_shop_manager.sql"
-- sql to create and populate the tables

-- DROP TABLE items, orders; -- to use in case of issues/over iterations

CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name text,
  unit_price numeric,
  stock_quantity int);

CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name text,
  order_date date,
  item_id int,
  constraint fk_item_235163493048 foreign key(item_id) references items(id)
    on delete cascade);

-- to use below this point for test seeds file
TRUNCATE TABLE items, orders RESTART IDENTITY;

INSERT INTO items (name, unit_price, stock_quantity)
  VALUES ('Super Shark Vacuum Cleaner', 99, 30);
INSERT INTO items (name, unit_price, stock_quantity)
  VALUES ('Makerspresso Coffee Machine', 69, 15);

INSERT INTO orders (customer_name, order_date, item_id)
  VALUES ('John Doe', '2022-08-21', 2);
INSERT INTO orders (customer_name, order_date, item_id)
  VALUES ('John Doe The Second', '2022-08-22', 2);
INSERT INTO orders (customer_name, order_date, item_id)
  VALUES ('Jane Doe', '2022-08-23', 2);
INSERT INTO orders (customer_name, order_date, item_id)
  VALUES ('Jane Doe', '2022-08-24', 1);
```
```bash
createdb shop_manager
createdb shop_manager_test
psql -h localhost shop_manager < seeds_shop_manager.sql
psql -h localhost shop_manager_test < seeds_shop_manager.sql
```
## Design of model and model repository classes (done in respective files)

Completed in item_repository.rb and order_repository.rb.

## Design tests for repository classes

```ruby
# 1 - item_repository#all returns a list of all items as Item objects
item_repo = ItemRepository.new
items = item_repo.all
items.length # => 2
items.first.name # => "Super Shark Vacuum Cleaner"
items.first.unit_price # => 99
items.first.stock_quantity # => 30
items.last.name # => "Makerspresso Coffee Machine"
items.last.unit_price # => 69
items.last.stock_quantity # => 15

# 2 - item_repository#create(item) creates an item record from Item object
item_repo = ItemRepository.new
item = Item.new
item.name = "Super Smart Genius Toaster"
item.unit_price = 79.0
item.stock_quantity = 10
item_repo.create(item)
latest_item = item_repo.all.last
items.name # => "Super Smart Genius Toaster"
items.unit_price # => 79
items.stock_quantity # => 10
```
## Test driving the repository classes and the application class, notes

The code is now functional and with tests, but could be refactored a lot. There
is no input validation.

The application covers the specifications even though it isn't very usable. I'm
familiar with most things necessary, although a small part of the code is used
without much understanding (PG connection structure). Test driving worked ok.
Deviations from the recipe were useful for designing tests which had similar
structure, as they were easier and faster to change in _spec file code.

Things that need improvement or checking for feedback:

* the implementation of #all_with_item for order repository seems off
* only 98.85% test coverage - can't test Kernel and db connect raise error
* not sure about the approach to integration testing of each input/output
* need to see how the model class should change with extra repo class methods

<br/><br/>
Original md file:
<br/>

Shop Manager Project
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

Technical Approach:
-----

In this unit, you integrated a database by using the `PG` gem, and test-driving and building Repository classes. You can continue to use this approach when building this challenge.

[You'll also need to mock IO](https://github.com/makersacademy/golden-square/blob/main/mocking_bites/05_unit_testing_terminal_io_bite.md) in your integration or unit tests, since the program will ask for user input.

Notes on test coverage
----------------------

Please ensure you have the following **AT THE TOP** of your spec_helper.rb in order to have test coverage stats generated
on your pull request:

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

You can see your test coverage when you run your tests. If you want this in a graphical form, uncomment the `HTMLFormatter` line and see what happens!
