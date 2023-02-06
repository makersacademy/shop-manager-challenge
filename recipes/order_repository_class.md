# Order Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).


```
# EXAMPLE

Table: orders
id: SERIAL
customer_name: text
date: date
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_shop.sql)

TRUNCATE TABLE items,orders RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO orders (customer_name, date, item_id) VALUES ('Dave','2023-02-03',1);
INSERT INTO orders (customer_name, date, item_id) VALUES ('John','2023-02-03',2);


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
  attr_accessor :id, :customer_name, :date, :item_id
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
    # SELECT id, customer_name, date, item_id FROM orders;

    # Returns an array of Order objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, customer_name, date, item_id FROM orders WHERE id = $1;

    # Returns a single Order object.
  end

  # Add more methods below for each operation you'd like to implement.

  def create(order)
    #INSERT INTO orders (customer_name, date, item_id) VALUES($1,$2,$3);

    #Doesn't need to return as only creates
  end

  def delete(id)
    #DELETE FROM orders WHERE id = $1;

    #Doesn't need to return as only deletes
  end

  def update(order)
    #UPDATE orders SET customer_name = $1, date = $2, item_id = $3 WHERE id = $4;
    #Doesn't need to return as only updates
  end

end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all Orders

repo = OrderRepository.new

order = repo.all
order.length # => 2
order.first.id # => '1'
order.first.customer_name # => 'Dave'

# 2
# Find 1 order by id 

repo = OrderRepository.new

order = repo.find(1)

order.customer_name # => "Dave"

# 3
# Creates a new order

repo = OrderRepository.new

order = Order.new
order.customer_name = 'Geoff'
order.date = '2023-01-01'
order.item_id = '2'
repo.create(order)
repo.all.last.customer_name # => order.name

# 4 
# Delete an order
repo = OrderRepository.new
order = repo.find(1)
repo.delete(order.id)

repo.all.length # => 1
repo.all.first.id #=> 2

# 5
# update an order
repo = OrderRepository.new

order = repo.find(1)


order.date = '2023-01-01'

repo.update(order)

updated_order = repo.find(1)

updated_order.date # => '2023-01-01'

```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/order_repository_spec.rb

def reset_orders_table
  seed_sql = File.read('spec/seeds_shop.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
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
