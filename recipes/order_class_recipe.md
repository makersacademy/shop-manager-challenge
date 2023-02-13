# Shop Manager Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `students`*


## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_{table_name}.sql)

TRUNCATE TABLE items, orders RESTART IDENTITY;

INSERT INTO orders (id, customer_name, order_date) VALUES (1, 'Pedro Pascal', 'March 10');
INSERT INTO orders (id, customer_name, order_date) VALUES (2, 'Alex de Souza', 'September 11');
INSERT INTO orders (id, customer_name, order_date) VALUES (3, 'Princess Diana', 'January 5');

INSERT INTO items (title, price, stock, order_id) VALUES ('Sweater', 30, 5, 1);
INSERT INTO items (title, price, stock, order_id) VALUES ('Jeans', 40, 10, 2);
INSERT INTO items (title, price, stock, order_id) VALUES ('Skirt', 20, 7, 3);

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: students

# Model class
# (in lib/student.rb)
class Order
end

# Repository class
# (in lib/student_repository.rb)
class OrderRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: students

# Model class
# (in lib/student.rb)

class Order

  # Replace the attributes by your own columns.
  attr_accessor :id, :customer_name, :order_date
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
    # SELECT id, customer_name, order_date FROM orders;

    # Returns an array of Order objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, customer_name, order_date FROM orders WHERE id = $1;

    # Returns a single Order object.
  end

  # Add more methods below for each operation you'd like to implement.

  def create(order)
    # Executes the SQL query:
    # INSERT INTO orders (customer_name, order_date) VALUES($1, $2);

    # Doesn't need to return anything (only creates the record)
  end

  # Delete an order record
  # given its id
  def delete(id)
    # Executes the SQL:
    # DELETE FROM orders WHERE id = $1;

    # Returns nothing (only deletes the record)
  end

  # Updates an order record
  # Takes an Order object (with the updated fields)
  def update(user)
    # Executes the SQL:
    # UPDATE artists SET customer_name = $1, order_date = $2 WHERE id = $3;

    # Returns nothing (only updates the record)
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

orders.length # =>  3

orders[0].id # =>  1
orders[0].customer_name # =>  'Pedro Pascal'
orders[0].order_date # =>  'March 10'

orders[1].id # =>  2
orders[1].customer_name # =>  'Alex de Souza'
orders[1].order_date # =>  'September 11'

# 2
# Get a single order

repo = OrderRepository.new

order = repo.find(1)

order.id # =>  1
order.customer_name # =>  'Princess Diana'
order.order_date # =>  'January 5'

# 3
# Create new order

repo = OrderRepository.new

new_order = Order.new

new_order.customer_name = 'Hugh Grant'
new_order.order_date = 'February 3'

repo.create(new_order) # => nil

orders = repo.all
last_order = orders.last
last_order.customer_name # => 'Hugh Grant'
last_order.order_date #  => 'Februrary 3'

#3 
# Delete an order
repo = OrderRepository.new
id_to_delete = 1

repo.delete(id_to_delete)

all_orders = repo.all

all_orders.length # => 2
all_orders.first.id # => '2'

#4
# Updates an order

repo = OrderRepository.new

order = repo.find(1)
order.customer_name = 'Zendaya'
order.order_date = '01.05.2022'

repo.update(order)

updated_order = repo.find(1)
updated_order.customer_name # => 'Zendaya'
updated_order.order_date # => 'May 1'
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/order_repository_spec.rb

def reset_shop_manager
  seed_sql = File.read('spec/shop_manager_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager' })
  connection.exec(seed_sql)
end

describe OrderRepository do
  before(:each) do 
    reset_shop_manager
  end

  
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._

<!-- BEGIN GENERATED SECTION DO NOT EDIT -->

---

**How was this resource?**  
[😫](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😫) [😕](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😕) [😐](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😐) [🙂](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=🙂) [😀](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😀)  
Click an emoji to tell us.

<!-- END GENERATED SECTION DO NOT EDIT -->