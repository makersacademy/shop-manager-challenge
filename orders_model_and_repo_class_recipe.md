# Orders Model and Repository Classes Design Recipe: Shop Manager

## Designing and Creating the Table

```

Table: orders

Columns:
id | customer_name | date | item_id
```

## 2. Create Test SQL seeds

```sql

-- (file: spec/seeds_orders.sql)

-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE orders RESTART IDENTITY;

INSERT INTO orders (customer_name, date, item_id) VALUES ('customer_1', '2023-01-10 14:10:05', 1)
INSERT INTO orders (customer_name, date, item_id) VALUES ('customer_2', '2023-01-08 13:30:10', 2)
INSERT INTO orders (customer_name, date, item_id) VALUES ('customer_3', '2023-01-20 16:15:03', 1)

```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data.

```bash
psql -h 127.0.0.1 shop_manager_test < seeds_orders.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by Repository for the Repository class name.

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
  attr_accessor :id, :customer_name, :date, :item_id
end

```
## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

  ```ruby
# Table name: orders

# Repository class
# (in lib/order_repository.rb)

class OrderRepository

  # selecting all orders
  # no arguments
  def all
    # executes the SQL query:
    # SELECT id, customer_name, date, item_id FROM orders;

    # returns an array of Order objects.
  end
  
  # select a single order
  # given the id in argument (an integer)
  def find(id)
    # executes the SQL query:
    # SELECT id, customer_name, date, item_id FROM orders WHERE id = $1;

    # returns a single Order object
  end

   # insert a new order record
   # takes an Order object in argument
  def create(order)
   # executes the SQL query
   # INSERT INTO orders (customer_name, date, item_id) VALUES ($1, $2, $3);

   # returns nothing
  end
end
```

## 6. Write Test Examples

Ruby code that defining the expected behaviour of the Repository class, following the design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby

# 1
# Get all orders

repo = OrderRepository.new
orders = repo.all
orders.length # => 3
orders.first.id # => 1
orders.first.customer_name # => 'customer_1'

# 2
# Get a single order

repo = OrderRepository.new

order = repo.find(1)
order.customer_name # => 'customer_1'
order.date # => '2023-01-10 14:10:05'
order.item_id # => 1

# 3
# Get another single order

repo = OrderRepository.new

order = repo.find(2)
order.customer_name # => 'customer_2'
order.date # => '2023-01-08 13:30:10'
order.item_id # => 2

# 4
# Create a new item
repo = OrderRepository.new

new_order = Order.new
new_order.customer_name = 'customer_4'
new_order.date = '2023-01-02 12:05:01'
new_order.item_id = 3

repo.create(new_order) # => nil

orders = repo.all

orders.last.customer_name # => 'customer_4'
orders.last.date # => '2023-01-02 12:05:01'
orders.last.item_id # => 3


```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is to get a fresh table contents every time you run the test suite.

# file: spec/item_repository_spec.rb

def reset_items_table
  seed_sql = File.read('spec/seeds_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_items_table
  end

 # (your tests will go here).

## 8. Test-drive and implement the Repository class behaviour

After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.