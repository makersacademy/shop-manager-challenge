# ITEMS Model and Repository Classes Design Recipe

## 1. Design and create the Table

Table is created. Details are in **table_design_schema.md**

```
Table: orders

Columns:
customer | date | item_id
```

## 2. Create Test SQL seeds

```sql
-- (file: spec/seeds_orders.sql)

TRUNCATE TABLE orders RESTART IDENTITY; 

INSERT INTO orders (customer, date, item_id) VALUES ('Dai Jones', '01/30/2023', '1');
INSERT INTO orders (customer, date, item_id) VALUES ('Bobby Price', '02/03/2023', '2');
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 shop_manager_test < seeds_orders.sql
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
  attr_accessor :id, :customer, :date, :item_id
end
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
    # SELECT id, customer, date, item_id FROM orders;
    # Returns an array of Order objects.
  end

  def create(order)
  # INSERT INTO orders (customer, date, item_id) VALUES ($1, $2, $3);
  # No return, just creates new Order object
  end

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

orders.length # =>  2

orders[0].id # =>  1
orders[0].customer # =>  'Dai Jones'
orders[0].date # =>  '30/01/2023'
orders[0].item_id # => '1'

orders[1].id # =>  1
orders[1].customer # =>  'Bobby Price'
orders[1].date # =>  '03/02/2023'
orders[1].item_id # => '2'

# 2
# Create an order

repo = OrderRepository.new

order = Order.new
order.customer = 'Annalise Keating'
order.date = '05/02/2023'
order.item_id = '1'

repo.create(order) # => nil

order = repo.all
last_order = order.last
last_order.customer # => 'Annalise Keating'
last_order.date # => '05/02/2023'
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

describe OrderRepository do
  before(:each) do 
    reset_orders_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._
