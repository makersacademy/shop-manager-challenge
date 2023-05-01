# {orders} Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

```

Table: orders

Columns:
id | customer_name | date | item_id
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- (file: spec/seeds_orders.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE orders RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO orders (customer_name, date, item_id) VALUES ('David', '03/03/2023', 1);
INSERT INTO orders (customer_name, date, item_id) VALUES ('David', '01/05/2023', 1);
INSERT INTO orders (customer_name, date, item_id) VALUES ('Anna', '01/05/2023', 2);
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
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
# order = Order.new
# order.name = 'Jo'
# order.name
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
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

  # creates a new record
  # one argument: an Order object
  def create(order)
    # Executes the SQL query
    # INSERT INTO artists (customer_name, date, item_id) VALUES ($1, $2, $3);
    
    # returns nothing
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
# 1
# Get all orders

repo = OrderRepository.new

orders = repo.all

orders.length # =>  3

orders[0].id # =>  '1'
orders[0].customer_name # =>  'David'
orders[0].date # =>  '2023-03-03'
orders[0].item_id # =>  '1'

orders[1].id # =>  '2'
orders[1].customer_name # =>  'David'
orders[1].date # =>  '2023-05-01'
orders[1].item_id # =>  '1'

orders[2].id # =>  '3'
orders[2].customer_name # =>  'Anna'
orders[2].date # =>  '2023-05-01'
orders[2].item_id # =>  '2'

# 2
# Get the first order

repo = OrderRepository.new

order = repo.find(1)

order.id # =>  '1'
order.customer_name # =>  'David'
order.date # =>  '2023-03-03'
order.item_id # =>  '1'

# 3
# Get the second order

repo = OrderRepository.new

order = repo.find(2)

order.id # =>  '2'
order.customer_name # =>  'David'
order.date # =>  '2023-05-01'
order.item_id # =>  '1'

# 4
# creates a new order

repo = OrderRepository.new

order = Order.new

order.customer_name = 'Will'
order.date = '2023-05-01'
order.item_id = 1

repo.create(order) # => nil

orders = repo.all

last_order = orders.last

last_item.id # => '4'
last_order.customer_name # => 'Will'
last_order.date # => '2023-05-01'
last_order.item_id # => '1'
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# file: spec/order_repository_spec.rb

def reset_orders_table
  seed_sql = File.read('spec/seeds_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

RSpec.describe OrderRepository do
  before(:each) do 
    reset_orders_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._