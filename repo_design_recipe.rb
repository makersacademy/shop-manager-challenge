# {{TABLE NAME}} Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._
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


## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `students`*

```
# EXAMPLE

Table: students

Columns:
id | name | cohort_name
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_{table_name}.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE students RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO students (name, cohort_name) VALUES ('David', 'April 2022');
INSERT INTO students (name, cohort_name) VALUES ('Anna', 'May 2022');

-- If there is a table that uses foreign key, you may enounter issues, they either need to be inserted in the correct order or truncated at the same time eg


TRUNCATE TABLE user_accounts, posts RESTART IDENTITY;

INSERT INTO user_accounts (email_address, username) VALUES ('abc@gmail.com', 'abc123');
INSERT INTO user_accounts (email_address, username) VALUES ('xyz@gmail.com', 'xyz123');

INSERT INTO posts (title, content, views, user_account_id) VALUES ('birthday', 'meal', 1, 1);
INSERT INTO posts (title, content, views, user_account_id) VALUES ('anniversary', 'happy', 3, 1);
INSERT INTO posts (title, content, views, user_account_id) VALUES ('wedding', 'congrats', 2, 2);
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
```
shop_manager_test
shop_manager

## 3. Define the class names - do for all classes

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: items / orders

# Model class
# (in lib/item.rb)
# (in lib/order.rb)
class Item
end

class Order
end

# Repository class
# (in lib/Item_repository.rb)
# (in lib/Order_repository.rb)
class ItemRepository
end
class OrderRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Model class
# (in lib/item.rb)
# (in lib/order.rb)
class Item
  attr_accessor :item_name, :price, :quantity, :order_id
end

class Order
  attr_accessor :customer_name, :date
end

```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

SQL can be broken down over several lines to make more readable

```ruby
# EXAMPLE
# Repository class
# (in lib/Item_repository.rb)
# (in lib/Order_repository.rb)
class ItemRepository

  def all
    # Executes the SQL query:
    # SELECT item_name, price, quantity, order_id
    # FROM items;

    # Returns an array of item objects.
  end

  def create
    #'INSERT INTO items (item_name, price, quantity, order_id) 
    # VALUES($1, $2, $3, $4);'
    # return nil
  end

end

class OrderRepository

  def all
    # Executes the SQL query:
    # SELECT customer_name, date
    # FROM orders;
    # Returns an array of order objects.
  end

  def create
    #'INSERT INTO orders (customer_name, date) 
    # VALUES($1, $2);'
    # return nil
  end

end

```
## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES
# items
# 1
# Get all items

repo = ItemRepository.new
items = repo.all
items[0].id # => 1
items[0].item_name # => 'cheese'
items[0].price # => 2
items[0].quantity # => 5
items[0].order_id # => 1

repo = ItemRepository.new
items = repo.all
items[1].id # => 2
items[1].item_name # => 'hot crossed buns'
items[1].price # => 3
items[1].quantity # => 10
items[1].order_id # => 1

repo = ItemRepository.new
items = repo.all
items[2].id # => 3
items[2].item_name # => 'sausage'
items[2].price # => 1
items[2].quantity # => 5
items[2].order_id # => 2


# 2

# Add a new ...
repo = ItemRepository.new
item = Item.new
item.item_name = 'chips' 
item.price = '2' 
item.quantity = '4' 
item.order_id = '2'

repo.create(item)

items = repo.all
items.length # => 4
items[3].item_name # => 'chips' 
items[3].price = #'2' 
items[3].quantity # => '4' 
items[3].order_id #=> '2'

# orders spec repo

# 1
repo = OrderRepository.new
orders = repo.all
order[0].id # => 1
order[0].customer_name # => 'Joe'
order[0].date # => 'sept'

repo = OrderRepository.new
orders = repo.all
order[1].id # => 2
order[1].customer_name # => 'Dave'
order[1].date # => 'oct'


# 2

# Add a new ...
repo = OrderRepository.new
order = Order.new
order.customer_name = 'Jim' 
order.date = 'aug' 

repo.create(order)

orders = repo.all
orders.length # => 3
orders[2].customer_name # => 'Jim' 
orders[2].date = # 'aug' 


# Add more examples for each method
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_students_table
  seed_sql = File.read('spec/seeds_students.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'students' })
  connection.exec(seed_sql)
end

describe StudentRepository do
  before(:each) do 
    reset_students_table
  end

  # (your tests will go here).
end
'''
8. Test-drive and implement the Repository class behaviour
##After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.
'''