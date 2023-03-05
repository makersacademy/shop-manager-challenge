# Items Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table



## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql

TRUNCATE TABLE orders, items RESTART IDENTITY; 

INSERT INTO orders (customer_name, order_date) VALUES ('Sarah', '3/3/2023');
INSERT INTO orders (customer_name, order_date) VALUES ('Emma', '2/3/2023');

INSERT INTO items (item_name, price, quantity, order_id) VALUES ('Bread', '2', '1', '1');
INSERT INTO items (item_name, price, quantity, order_id) VALUES ('Milk', '1', '2', '1');
INSERT INTO items (item_name, price, quantity, order_id) VALUES ('Yoghurt', '1.5', '1', '2');



```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 shop_manager_test < seeds_orders.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: students
# Model class
# (in lib/student.rb)
class Item
end
# Repository class
# (in lib/student_repository.rb)
class ItemRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: students
# Model class
# (in lib/student.rb)
class Item
  # Replace the attributes by your own columns.
  attr_accessor :id, :item_name, :price, :quantity, :order_id
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
# Table name: students
# Repository class
# (in lib/student_repository.rb)
class ItemRepository
  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, cohort_name FROM students;
    # Returns an array of Student objects.
  end
  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, name, cohort_name FROM students WHERE id = $1;
    # Returns a single Student object.
  end
  # Add more methods below for each operation you'd like to implement.
  def create(order)
   end
  def update(order)
  end
  def delete(order)
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES
# 1
# Get all order
repo = ItemRepository.new
items = repo.all
items.length # =>  2
items[0].id # =>  1
items[0].item_name # =>  'Bread'
items[0].price # =>  '2'
items[0].quantity # =>  '1'
items[0].order_id # =>  '1'
items[1].id # =>  2
items[1].item_name # =>  'Milk'
items[1].price # =>  '1'
items[1].quantity # =>  '2'
items[1].order_id # =>  '1'
items[2].id # =>  3
items[2].item_name # =>  'Yoghurt'
items[2].price # =>  '1.5'
items[2].quantity # =>  '1'
items[2].order_id # =>  '2'

# 2
# Get a single order
repo = ItemRepository.new
item = repo.find(1)
item.id # =>  1
item.item_name # =>  'Bread'
item.price # =>  '2'
item.quantity # =>  '1'
item.order_id # =>  '1'
# Add more examples for each method

#3
#Create an order

#4
#Update an order

#5
#Delete an order


```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE
# file: spec/student_repository_spec.rb
def reset_items_table
  seed_sql = File.read('spec/seeds_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager' })
  connection.exec(seed_sql)
end

  before(:each) do 
    reset_items_table
  end
  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._