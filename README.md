Shop Manager Project
===

A small project allowing a shop manager to manage a database of items
in their inventory and the orders placed in their shop.

This project responds to the following user story:
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

In order to run the shop manager command line app, run
`ruby app.rb`
from within the home directory.
This app allows the user to
* list all items
* create a new item
* list all orders
* create a new order

---

Technical details
---

The app interfaces with the `shop-manager` database.
This database contains two main tables `items` and `orders`
which share a many-to-many relationship through the `items_orders` join table.
These tables can be created by running `items_orders.sql`, and seeded
with either `spec/seeds_items.sql` or `spec/seeds_orders.sql`.

The interface with the database is done through the `ItemRepository`
and `OrderRepository` classes, and their associated model classes
`Item` and `Order` respectively.
Both classes have a method to return all reports in their aassociated
tables, and a method to create a new record.

*Note:* In order to create an order, the user must supply an array of item ids
in order to link both tables together.

The `ItemRepository` class also has a method that allows for the retrieval of all item records associated with a given order.

Both repository classes are tested on a test database `shop_manager_test` using RSpec.
The Application class is also tested in RSpec using mock io.

---

Things to add
---

 - Currently the app doesn't show the relationship between the items and
 the orders.
 For instance the function to show all orders could show an itemized
 receipt for each order.
 Or for instance it might be useful for the shop manager to be able to see a
 list of all orders associated with a given item.

- Currently the app does not modify the item quantities when a new order is placed.

- Other CRUD (ie update and delete) features can be added to give the shop manager
more control over the database.

- We could potentially auto-generate an order's submission date depending
on the date it is submitted using the app.

---

Skills used in this project
---

- Designing and creating a database schema with two tables and a many-to-many
relationship.

- Using SQL queries to fetch data from a database with joins for fetching from multiple tables.
Using SQL to create now records in a table.

- Integrate relational databases into a program by test-driving
repository classes which implement Create and Read methods to send SQL queries
to the database.