# items Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table
[See [table_design.md](shop-manager-challenge/items_repository_class_design.md)]

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- (file: spec/seeds_orders.sql)
TRUNCATE TABLE orders RESTART IDENTITY;

INSERT INTO orders (customer_name, order_date) VALUES ('Paul Jones', '2022-08-25');
INSERT INTO orders (customer_name, order_date) VALUES ('Isabelle Mayhew', '2022-10-13');
INSERT INTO orders (customer_name, order_date) VALUES ('Naomi Laine', '2022-10-14');
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 shop_manager < seeds_orders.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# Table name: order

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
  attr_accessor :id, :customer_name, :order_date  # :items?
end
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

```ruby
# Table name: orders

# Repository class
# (in lib/order_repository.rb)
class OrderRepository
  # Selecting all records
  # No arguments
  def list
    # Executes the SQL query:
    # SELECT id, customer_name, order_date FROM orders;

    # Returns an array of Order objects.
  end

  # Create a new order
  # One argument: Order object
  def create(order)
    # Executes the SQL query:
    # INSERT INTO orders (customer_name, order_date) VALUES($1,$2);

    # Returns nothing
    # TODO method to add item names to the order and update item order_id with new order.id
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# 1
# list all orders
repo = OrderRepository.new
orders = repo.list
orders.length # =>  3

orders[0].id # =>  '1'
orders[0].customer_name # =>  'Paul Jones'
orders[0].order_date # =>  '2022-08-25'

orders[1].id # =>  2
orders[1].customer_name # =>  'Isabelle Mayhew'
orders[1].order_date # =>  '2022-10-13'

orders[2].id # =>  3
orders[2].customer_name # =>  'Naomi Laine'
orders[2].order_date # =>  '2022-10-14'

# 2
# create a new order
repo = OrderRepository.new
order = Order.new
order.customer_name = 'Father Christmas'
order.order_date = '2022-12-25'

repo.create(order) # => nil

orders = repo.list
last_order = orders.last
last_order.customer_name # => 'Father Christmas'
last_order.order_date # => '2022-12-25'
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# file: spec/item_repository_spec.rb
def reset_orders_table
  seed_sql = File.read('spec/seeds_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager' })
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
