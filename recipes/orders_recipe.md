# {{orders}} Model and Repository Classes Design order

_Copy this order template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this order to design and create the SQL schema for your table](./single_table_design_order_template.md).

*In this template, we'll use an example table `orders`*

```
# EXAMPLE

Table: orders

Columns:
id | customer_name | date
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
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
# EXAMPLE
# Table name: orders

# Model class
# (in lib/order.rb)

class Order

  # Replace the attributes by your own columns.
  attr_accessor :id, :customer_name, :date
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
# (in lib/order_repository.rb)

class OrderRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, cohort_name FROM orders;

    # Returns an array of order objects.
  end

  # Adding an order to the table
  # order: Order - order to add to table
  def create(order)
    # Executes the SQL query:
    # INSERT INTO orders (customer_name, date) VALUES ($1,$2)

    # Returns nil
  end

  # Find all the orders attached to an item
  # item_id: int - the id of the item to filter by
  def find_by_item(item_id)
    # Executes the SQL query:
  #  SELECT 
	#   items.id AS "item_id",
	#   items.name,
	#   items.unit_price,
	#   items.quantity,
	#   orders.id AS "order_id",
	#   orders.customer_name,
	#   orders.date
	# FROM items
	# JOIN items_orders
	#   ON items.id = items_orders.item_id
	# JOIN orders
	#   ON items_orders.order_id = orders.id
	# WHERE item_id = $1;

    # Returns an array of order objects. 
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

orders.first.id # =>  1
orders.first.customer_name # =>  'Sam'
orders.first.date # =>  '2023-03-31'

# 2
# Create an order

repo = OrderRepository.new

order = Order.new
order.customer_name = 'Laura'
order.date = '2023-04-01'

repo.create(order)

created_order = repo.all.last
created_order.id # => 4
created_order.customer_name # => 'Laura'
created_order.date # => '2023-04-01'

# 3
# Find order attached to an order

repo = OrderRepository.new

orders = repo.find_by_item(1)

orders.length # => 2
orders.first.id # => 1
orders.first.customer_name # => 'Sam'
orders.first.date # => '2023-03-31'


```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/order_repository_spec.rb

def reset_tables
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'items_orders_test' })
  connection.exec(seed_sql)
end

describe OrderRepository do
  before(:each) do 
    reset_tables
  end

end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._

