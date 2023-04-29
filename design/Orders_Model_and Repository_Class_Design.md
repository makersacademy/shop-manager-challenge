# {{Orders}} Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

```

As a shop manager
So I can know which orders were made
I want to **keep a list of orders** with their customer name.

As a shop manager
So I can know which orders were made
I want to **assign** each order to their corresponding item.

As a shop manager
So I can know which orders were made
I want to know on which date an order was placed. 

As a shop manager
So I can manage orders
I want to be able to **create** a new order.

Table: orders
id: SERIAL
customer_name: text
order_date: date
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_orders.sql)


TRUNCATE TABLE items, orders, items_orders RESTART IDENTITY; 

INSERT INTO items (name, price, quantity) VALUES 
('item_one', 1, 1),
('item_two', 2, 2),
('item_three', 3, 3),
('item_four', 4, 4),
('item_five', 5, 5);

INSERT INTO orders (customer_name, order_date) VALUES	
('Jeff', '2023-10-16'),
('John', '2023-11-16'),
('Jerry', '2023-12-16'),
('George', '2024-01-16');


INSERT INTO items_orders (item_id, order_id)
		VALUES(1, 1), (2, 4), (3, 2), (4, 3), (5, 1);
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
  attr_accessor :id, :customer_name, :order_date
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
    # SELECT * FROM orders;

    # Returns an array of order objects.
  end

  # creates a new order
  # returns nothing
  def create(order)
    # Executes the SQL query:
    # INSERT INTO order (customer_name, order_date) VALUES ($1, $2);
  end

  # adds an item to an order. 
  # fails if item is already on order?
  def assign_item_to_order(item_id, order_id)
    # Executes the SQL query:
    # INSERT INTO items_orders VALUES ($1, $2)
    # returns nothing.
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

orders.length => 4

orders[0].id # => 1
orders[0].customer_name # => 'Jeff'
orders[0].order_date # => '2023-10-16'

orders[-1].id # => 4
orders[-1].customer_name # => 'George'
orders[-1].order_date # => '2024-01-16'

# 2 
# create an order

repo = OrderRepository.new
new_order = Order.new

new_order.customer_name = 'Barry'
new_order.order_date = '2024-02-16'

repo.create(new_order)

orders = repo.all 

orders.length # => 5

latest_order = orders.last

latest_order.id # => 5  
latest_order.customer_name # => 'Barry'
latest_order.starting_date # => '2024-02-16'


# 3 
# Assigns an existing item to an order with one item already

order_repo = OrderRepository.new

order_repo.assign_item_to_order(1, 3)

item_repo = ItemRepository.new

items_on_order = item_repo.find_by_order(order_id)

items_on_order.length # => 2
items_on_order.include?(item_repo.find_by_id(1)) # => true

# 4
# Assigns an existing item to an empty order

order_repo = OrderRepository.new
new_order = Order.new

new_order.customer_name = 'Barry'
new_order.order_date = '2024-02-16'

order_repo.create(new_order)

order_repo.assign_item_to_order(1, 5)

item_repo = ItemRepository.new
items_on_order = item_repo.find_by_order(order_id)

items_on_order.length # => 1
items_on_order.first.id # => 1



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