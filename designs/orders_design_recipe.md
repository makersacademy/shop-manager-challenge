# Items Model and Repository Classes Design Recipe

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

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
# (in lib/item_repository.rb)
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
  attr_accessor :id, :customer, :date, :item_id
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# student = Student.new
# student.name = 'Jo'
# student.name
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
    # SELECT id, customer, date, item_id FROM orders;

    # Returns an array of Order objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, customer, date, item_id FROM orders WHERE id = $1;

    # Returns a single Order object.
  end
  
  # Adds new record to the 'orders' table
  # One argument: the new order
  def create(new_order)
    # Executes the SQL query:
    # INSERT INTO orders (id, customer, date FROM orders) VALUES (4, 'name4', '2022-07-10');

    # Returns nothing
  end
end

```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all orders

repo = OrdersRepository.new

orders = repo.all

orders.length # =>  3

orders[0].id # =>  1
orders[0].customer # =>  'name1'
orders[0].date # =>  2022-07-8
orders[0].item_id # =>  1

orders[1].id # =>  2
orders[1].customer # =>  'name2'
orders[1].date # =>  2022-07-9
orders[1].item_id # =>  2

orders[2].id # =>  3
orders[2].customer # =>  'name3'
orders[2].date # =>  2022-07-10
orders[2].item_id # =>  3

# 2
# Get a single order

repo = OrderRepository.new

order = repo.find(3)

order.id # =>  3
order.customer # =>  'name3'
order.date # =>  2022-07-10
order.item_id # =>  3

# 3 
# Adds new order

repo = OrderRepository.new

new_order = Order.new
new_order.id # =>  4
new_order.customer # =>  'name4'
new_order.date # =>  2022-07-10
new_order.item_id # =>  4
repo.create( new_order)
all_orders = repo.all
all_orders.length # => 4

```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/order_repository_spec.rb

def reset_orders_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager' })
  connection.exec(seed_sql)
end

describe OrderRepository do
  before(:each) do 
    reset_orders_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._