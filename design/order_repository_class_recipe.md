# Order Model and Repository Classes Design

_Copy this template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_tests.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE orders RESTART IDENTITY; -- replace with your own table customer_name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Mantas Volkauskas', '7 Jan 2023', 2);
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Bob Boberto', '25 Dec 2022', 2);

```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 shop_manager_test < shop_manager_tables_seeds.sql
psql -h 127.0.0.1 shop_manager_test < spec/seeds_tests.sql
```

## 3. Define the class customer_names

Usually, the Model class customer_name will be the capitalised table customer_name (single instead of plural). The same customer_name is then suffixed by `Repository` for the Repository class customer_name.

```ruby
# EXAMPLE
# Table customer_name: orders

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
# Table customer_name: orders

# Model class
# (in lib/order.rb)

class Order
  attr_accessor :id, :customer_name, :order_date, :item_id
end

```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table customer_name: orders

# Repository class
# (in lib/order_repository.rb)

class OrderRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, customer_name, order_date, item_id FROM orders;

    # Returns an array of Order objects.
  end

  # Adds new record
  # one argument - Order Object
    def create(order)
      # Executes the SQL query:
      # INSERT INTO orders (customer_name, order_date, item_id) VALUES ($1, $2, $3);
      
      # Returns nil.
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

orders[0].id # => 1
orders[1].customer_name # => "Bob Boberto"
orders[0].order_date # => '7 Jan 2023'
orders[1].item_id # => 2

# 2
# Adds a new order

repo = OrderRepository.new

order = Order.new
order.customer_name = 'Bugs Bunny'
order.order_date = '8 Jan 2023'
order.item_id = 1

repo.create(order)

all_orders = repo.all

all_orders.length # => 3
all_orders.last.id # => 3
all_orders.last.customer_name # => 'Bugs Bunny'
all_orders.last.item_id # => 1

```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table order_dates every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/order_repository_spec.rb

describe OrderRepository do
  def reset_orders_table
    seed_sql = File.read('spec/seeds_tests.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_orders_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._
