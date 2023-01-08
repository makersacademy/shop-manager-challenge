# Orders Model and Repository Classes Design Recipe

## 1. Design and create the Table

```
Table: orders

Columns:
id | customer_name | date | item_id
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

TRUNCATE TABLE orders, items RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.
INSERT INTO items (name, price, quantity) VALUES ('Mustang', 47630, 200);
INSERT INTO items (name, price, quantity) VALUES ('Fiesta', 19060, 600);
INSERT INTO orders (customer_name, date, item_id) VALUES ('M. Jones', 07.01.23, 1);
INSERT INTO orders (customer_name, date, item_id) VALUES ('R. Davids', 08.01.23, 2);
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_orders.sql
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
```
## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# Table name: orders

# Repository class
# (in lib/order_repository.rb)

class OrderRepository
  def all
    # Executes the SQL query:
    # SELECT id, customer_name, date, item_id FROM orders;

    # Returns an array of Student objects.
  end
  # Gets a single record by its ID
  # One argument: the id (number)
  def create(order)
    # Executes SQL query;
    # INSERT INTO items (customer_name, date, item_id) VALUES ($1, $2, $3)
    # Nothing returned
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

expect(orders.length).to eq(2)

expect(orders[0].id).to eq(1)
expect(orders[0].customer_name).to eq 'M. Jones'
expect(orders[0].date).to eq '2023-01-07'
expect(orders[0].item_id).to eq 1

expect(orders[1].id).to eq(1)
expect(orders[1].customer_name).to eq 'R. Davids'
expect(orders[1].date).to eq '2023-01-08'
expect(orders[1].item_id).to eq 2

# 2
# Create an order 

repo = OrderRepository.new

new_order = Order.new
new_order.customer_name = 'B. Young'
new_order.date = '2022-12-22'
new_order.item_id = 2
repo.create(new_order)
expect(repo.all).to include(
  have_attributes(customer_name: 'B. Young', date: '2022-12-22', item_id: 2)
)
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/order_repository_spec.rb

def reset_order_table
  seed_sql = File.read('spec/seeds_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'stop_manager_test' })
  connection.exec(seed_sql)
end

describe OrderRepository do
  before(:each) do 
    reset_order_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._