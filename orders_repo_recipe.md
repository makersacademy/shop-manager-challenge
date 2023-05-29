# Orders Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `students`*

```
# EXAMPLE

Table: orders

Columns:
customer_name | date_of_order | order_id
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

INSERT INTO orders (customer_name, date_of_order) VALUES('Khuslen', '2023-05-26');
INSERT INTO orders (customer_name, date_of_order) VALUES('John', '2023-05-26');
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
e.g psql -h 127.0.0.1 database_orders < spec/seeds.sql
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
# (in lib/order_repo.rb)
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
  attr_accessor :id, :customer_name, :date_of_order
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# order = order.new
# order.name = 'Trompe le Monde'
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
# (in lib/order_repo.rb)

class OrderRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, customer_name, date_of_order FROM orders;

    # Returns an array of order objects.
  end

  def create(order)
  end

    # Select a single record
    # 'INSERT INTO orders (customer_name, date_of_order) VALUES ($1, $2) RETURNING id, customer_name, date_of_order'
    # Given the id in argument(a number)

  def find(id) 
    # Executes the SQL query:
    # SELECT id, customer_name, date_of_order FROM orders WHERE id = $1
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

repo = OrderRepository.new

orders = repo.all
orders.length # => 2
orders.first.id # => '1'
orders.first.customer_name # => 'Khuslen'
orders.first.date_of_order # => '23-05-26'

# 2
# Get a single order

repo = OrderRepository.new
order = repo.find(1)
order.id # => '1'
order.customer_name # => 'Khuslen' 
order.date_of_order # => '23-05-26'
#3 
# Get another single artist 

repo = OrderRepository.new
order = repo.find(2)
order.id # => '2'
order.customer_name # => 'John'
order.date_of_order #=> '2023-05-25'

#4
# Creates a new order
repo = OrderRepository.new
new_order = repo.create(customer_name: 'Billy', date_of_order: '2023-05-01')

new_order.id 
new_order.customer_name
new_order.date_of_order

# Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/orders_repo_spec.rb

def reset_orders_table
  seed_sql = File.read('spec/seeds_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'database_orders_test' })
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

<!-- BEGIN GENERATED SECTION DO NOT EDIT -->