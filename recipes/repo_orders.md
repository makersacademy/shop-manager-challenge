# Orders Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `orders`*

```
# EXAMPLE

Table: orders

Columns:
id | customer | date
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

TRUNCATE TABLE orders RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO orders (name, cohort_name) VALUES ('David', 'April 2022');
INSERT INTO orders (name, cohort_name) VALUES ('Anna', 'May 2022');
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: orders

# Model class
# (in lib/order.rb)
class Order
end

# Repository class
# (in lib/order_repository.rb)
class OrderRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: orders

# Model class
# (in lib/order.rb)

class Order

  # Replace the attributes by your own columns.
  attr_accessor :id, :customer, :date, :items
  @items = [] # this will be an array of Item objects
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# order = order.new
# order.name = 'Jo'
# order.name
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: orders

# Repository class
# (in lib/order_repository.rb)

class OrderRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, customer, date FROM orders;

    # Returns an array of order objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, customer, date FROM orders WHERE id = $1;

    # Returns a single order object.
  end

  # Add more methods below for each operation you'd like to implement.

  def create(order) # needs to assign items to the order using the join table
    # INSERT INTO orders (customer, date, items) VALUES ($1, $2, $3); # items will be an array of Item objects - with quantity one less
    # INSERT INTO items_orders (item_id, order_id) VALUES ($4, $5); # will need to loop through item array and do a new insert for every item

    # when an item is added to the order, need to change the quantity - do this in app.rb?
    # item_repo = ItemRepository.new
    # item_repo.update(order.item) # loop through item array
  end

  # def update(order)
  # end

  # def delete(order)
  # end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all orders
repo = OrderRepository.new
orders = repo.all

orders.length # =>  3
orders[0].id # =>  1
orders[0].customer # =>  'Quack Overflow'
orders[0].date # =>  '04/01/23'

# 2
# Get a single order
repo = OrderRepository.new
order = repo.find(1)

order.id # =>  '1'
order.customer # =>  'Quack Overflow'
order.date # =>  '04/01/23'

# 3
# Adds a new order to the database
new_order = Order.new
item_repo = ItemRepository.new
items = item_repo.all
order_repo = OrderRepository.new

new_order.customer = 'Big Bird'
new_order.date = '03/29/23'
new_order.items.push(items[3], items[2])

order_repo.create(new_order)
orders = order_repo.all
last_order = orders.last

last_order.id # => '4'
last_order.customer # => 'Big Bird'
last_order.date # => '03/29/23'
last_order.items # => [items[3], items[2]]
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/order_repository_spec.rb

def reset_orders_table
  seed_sql = File.read('spec/seeds_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'orders' })
  connection.exec(seed_sql)
end

describe orderRepository do
  before(:each) do
    reset_orders_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._

