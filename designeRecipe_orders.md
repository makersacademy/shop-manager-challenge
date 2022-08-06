# ORDERS Model and Repository Classes Design Recipe

## 1. Design and create the Table


```

Table: ORDERS
| Record                | Properties          |
| --------------------- | ------------------  |
| items                 | price,  quantity
| orders                  customer_name, orderdate, 'item_key'
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql

TRUNCATE TABLE items, orders  RESTART IDENTITY;

INSERT INTO items (item_name, price, quantity) 
VALUES ('GOLD WATCH', 3350, 5);
INSERT INTO orders (customer_name, order_date, item_key) VALUES ('Anna', 'May 2022', 1);
```

```bash
psql -h 127.0.0.1 shop-manager_test < seeds_items_orders.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: orders

# Model class
# (in lib/order.rb)
class Orders
end

# Repository class
# (in lib/orders_Repository.rb)
class OrdersRepository
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

  
  attr_accessor :id, :item_name, :price, :quantity
end

```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: orders

# Repository class
# (in lib/orders_Repository.rb)

class OrdersRepository

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

  # def create(student)
  # end

  # def update(student)
  # end

  # def delete(student)
  # end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all orderss

repo = OrdersRepository.new

orders = repo.all

orders.length # =>  2

orders[0].id # =>  1
orders[0].customer_name # =>  'David'
orders[0].cohort_date # =>  'April 2022'
orders[0].item_key #=> '3'

orders[1].id # =>  2
orders[1].customer_name # =>  'Anna'
orders[1].cohort_date # =>  'May 2022'
orders[1].item_key #=> '1'

# 2
# Get a single order

repo = OrdersRepository.new

orders = repo.find(1)

orders.id # =>  1
orders.customer_name # =>  'David'
orders.order_date # =>  'April 2022'
orders.item_key #=> '1'

# Add more examples for each method
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run


```ruby
# EXAMPLE

# file: spec/orders_Repository_spec.rb

def reset_items_orders_table
  seed_sql = File.read('spec/seeds_items_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe OrdersRepository do
  before(:each) do 
    reset_items_orders_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour
