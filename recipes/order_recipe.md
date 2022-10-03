{{TABLE NAME}} Model and Repository Classes Design Recipe

## 1. Design and create the Table
If the table is already created in the database, you can skip this step.

Tables is already created

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

INSERT INTO orders (customer_name, date_order_placed, item_id) VALUES ('Lauren', 30.09.2022, 1);
INSERT INTO orders (customer_name, date_order_placed, item_id) VALUES ('Tom', 29.09.2022, 2);
INSERT INTO orders (customer_name, date_order_placed, item_id) VALUES ('James', 29.09.2022, 1);
INSERT INTO orders (customer_name, date_order_placed, item_id) VALUES ('Emily', 28.09.2022, 2);
INSERT INTO orders (customer_name, date_order_placed, item_id) VALUES ('Grace', 28.09.2022, 3);

-- Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.
```
```bash
#create test database, load in the file with data which was provided by coaches (psql -h 127.0.0.1 music_library_test < music_database.sql) and then push this test database to our spec/seeds_artist file 9psql -h 127.0.0.1 music_library_test < spec/seeds_artists.sql;)

psql -h 127.0.0.1 shop_manager_test < shop_manager_table.sql

```

## 3. Define the class names
Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by Repository for the Repository class name.

# EXAMPLE
# Table name: artists

# Model class
# (in lib/order.rb)
class Order
end

# Repository class
# (in lib/student_repository.rb)
class OrderRepository
end

## 4. Implement the Model class
Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

# EXAMPLE
# Table name: orders

# Model class
# (in lib/order.rb)

class Order

  # Replace the attributes by your own columns.
  attr_accessor :id, :customer_name, :date_order_placed, :item_id
end


You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.

## 5. Define the Repository Class interface
Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

# EXAMPLE
# Table name: order

# Repository class
# (in lib/order_repository.rb)

class OrderRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, customer_name, date_order_placed, item_id FROM orders;

    # Returns an array of Order objects.
  end
  def create(order)
  end
end

## 6. Write Test Examples
Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.
```ruby
# EXAMPLES

# 1
# Get all items

repo = OrderRepository.new

orders = repo.all
orders.length # => 5
orders.first.id # => '1'
orders.first.customer_id # => 'Lauren'

#4 create a new order 
repo = OrderRepository.new

order = Order.new
order.customer_name = 'Harry'
order.date_order_placed = '30.09.2022'
order.item_id = '2'

repo.create(order)

orders = repo.all

orders.length # => 6

last_order = orders.last
last_order.name # => 'Harry'
last_order.id # => '6'

# Add more examples for each method
Encode this example as a test.
```

7. Reload the SQL seeds before each test run
Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_students_table
  seed_sql = File.read('spec/seeds_artists.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music-library' })
  connection.exec(seed_sql)
end

describe ArtistRepository do
  before(:each) do 
    reset_artist_table
  end

  # (your tests will go here).
end

## 8. Test-drive and implement the Repository class behaviour
After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.