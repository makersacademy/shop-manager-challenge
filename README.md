Shop Manager Project
=================

## Solo Project:
----- 

During week 3 of the Makers Bootcamp, we worked through a sequence of exercises and challenges with the following objectives:

* **Design a database schema with at least two tables** from a specification, including a one-to-many relationship between two tables, and create the schema in a database using SQL.
* **Use SQL to query a database** to read data from one table or resulting of a join, create new records, update and delete.
* **Integrate a relational database to a program** by test-driving classes which implement CRUD methods to send SQL queries to a database.
* **Explain how your program communicates with the database** by creating a sequence diagram.

At the end of the module, we were tasked to write a small terminal program allowing the user to manage a shop database containing some items and orders.

##  User stories:
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

Here's an example of the terminal output your program should generate:

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

See [Shop Manager Project](/shop_manager_project.md) for full details.

## Technical Approach:
-----

* **Integrated a database** using the `PG` gem, test-driving and building Repository classes. 
* **Mocked IO in integration tests** as program asks for user input
* **One to Many Table Design**
* **Object-Oriented Design:** Implemented Application, Repository and Model classes mapped out in recipe documents:
  - [Shop Manager Table Recipe](/recipe/shop_manager_table_recipe.md) 
  - [Shop Manager Repo Recipe](/recipe/shop_manager_repo_recipe.md) 
  - [Shop Manager App Recipe](/recipe/shop_manager_app_recipe.md) 
* **Test-driving using RSpec:** Green on all integration and unit tests
```
COVERAGE:  99.50% -- 399/401 lines in 12 files

+----------+--------+-------+--------+---------+
| coverage | file   | lines | missed | missing |
+----------+--------+-------+--------+---------+
|  94.44%  | app.rb | 36    | 2      | 55, 61  |
+----------+--------+-------+--------+---------+

```
* **Debugging** using debugging techniques and error message info.
* **Version control:** Git and Github
* **Languages:** Ruby, SQL
* **Relationship Database:** PostgreSQL


## Further considerations:
-----

* Integrate **loop** into interactive menu
* Additional **unit tests**
* **Many to Many** database design

