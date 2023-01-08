# Orders Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

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

```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby


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
  attr_accessor :id, :customer_name, :order_date, :item_id
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# order = Order.new
# order.order_date = '2023-01-01'
# order.quantity
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
  def all
    # Takes no args
    # Executes the SQL query:
    #   SELECT id, customer_name, order_date, item_id FROM orders;
    
    # Returns an array of order objects 
  end

  def find(id)
    # Takes id as arg
    # Executes the SQL query:
    #   SELECT id, customer_name, order_date, item_id FROM orders WHERE id = $1;'
    #   query paramater:  [id]

    # Returns an array containing one order object with the queried id
  end
    
  
  def create(order)
    # Takes Order object as arg

    # Executes the SQL query:
    #        INSERT INTO orders(customer_name, order_date, item_id) 
    #        VALUES($1, $2, $3)
    #        RETURNING *; 

    #        Query parameters: [order.customer_name, order.order_date, order.item_id]
    #        Returns the record of the created order
end

    

end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1 
# all
# Get all orders
repo = OrderRepository.new
orders = repo.all
orders.length # => 4 
orders.first.id # => 1 
orders.first.customer_name # => 'Joe Bloggs' 
orders.first.order_date # => '2022-12-31'

# 2 
# find(id)
# Gets a single order
repo = OrderRepository.new
order = repo.find(2)
order.id # => 2
order.customer_name # => 'John Smith'
order.item_id # => 2

# 3
# create(order)
# Creates an order
order = Order.new()
repo = OrderRepository.new
order.customer_name = 'Mark'
order.order_date = '2023-01-05'
order.item_id = 3
repo.all[-1].order_date#  = > '2023-01-05'
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/order_repository_spec.rb

def reset_tables
  seed_sql = File.read('spec/seeds_shop_manager.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe OrderRepository do
  before(:each) do 
    reset_tables
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._
