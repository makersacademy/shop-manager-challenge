# {{TABLE NAME}} Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

see shop_table_design.md

```
# EXAMPLE


```

## 2. Create Test SQL seeds

````see shop_table_design.md


## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: items

# Model class
# (in lib/item.rb)
class Item
end

# Repository class
# (in lib/item_repository.rb)
class ItemRepository
end

# Table name: orders

# Model class
# (in lib/order.rb)
class Order
end

# Repository class
# (in lib/order_repository.rb)
class OrderRepository
end




````

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: items

# Model class
# (in lib/item.rb)

class Item

  # Replace the attributes by your own columns.
  attr_accessor :id, :item, :price, :quantity
end

# EXAMPLE
# Table name: orders

# Model class
# (in lib/order.rb)

class Order

  # Replace the attributes by your own columns.
  attr_accessor :id, :customer_name, :date_ordered, :item_id
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# student = Student.new
# student.name = 'Jo'
# student.name
```

_You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed._

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: items

# Repository class
# (in lib/item_repository.rb)

class ItemRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, item, price, quantity FROM items;
    items = []
    #loops through results and push them into array.

    # Returns an array of items objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, item, price, quantity FROM items; WHERE id = $1;

    # Returns a single Item object.
  end

  # Add more methods below for each operation you'd like to implement.

   def create(new_item)
   # Executes the SQL query:
    # INSERT INTO items  (id, item, price, quantity) VALUES ($1, $2, $3);

    # Returns nil.
  end

  # def update(student)
  # end

  # def delete(student)
  # end
end

class OrderRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, customer_name, date_ordered, item_id FROM orders;
    orders = []
    #loops through results and push them into array.

    # Returns an array of orders objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, customer_name, date_ordered, item_id FROM orders WHERE id = $1;

    # Returns a single Order object.
  end

  # Add more methods below for each operation you'd like to implement.

   def create(new_item)
   # Executes the SQL query:
    # INSERT INTO orders  (id, customer_name, date_ordered, item_id) VALUES ($1, $2, $3, $4);

    # Returns nil.
  end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all items

repo = ItemRepository.new

items = repo.all

items.length # =>  3

items[0].id # =>  1
items[0.item # =>  'item1'
items[0].price# =>  '1'
items[0].quantity # =>  '1'

items[1].id # =>  2
items[1.item # =>  'item2'
items[1].price# =>  '2'
items[1].quantity # =>  '2'



# 2
# Get a single item

repo = ItemRepository.new

item = repo.find(1)

item.id # =>  1
item.item # =>  'item1'
item.price # =>  '1'
item.quantity # =>  '1'

# EXAMPLES

# 1
# Get all orders

repo = OrderRepository.new

orders = repo.all

orders.length # =>  3

orders[0].id # =>  1
orders[0].customer_name # =>  'customer1'
orders[0].date_ordered # =>  '1/1/11'
orders[0].item_id # =>  '1'

orders[1].id # =>  2
orders[1].customer_name # =>  'customer2'
orders[1].date_ordered # =>  '2/2/22'
orders[1].item_id # =>  '2'




# 2
# Get a single order

repo = OrderRepository.new

order = repo.find(1)

order.id # =>  1
order.customer_name # =>  'customer1'
order.date_ordered # =>  '1'
order.item_id # =>  '1'

# Add more examples for each method
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/items_repository_spec.rb

def reset_items_table
  seed_sql = File.read('spec/seeds_shop.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_test' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do
    reset_items_table
  end

  # (your tests will go here).
end

# file: spec/orders_repository_spec.rb

def reset_orders_table
  seed_sql = File.read('spec/seeds_shop.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_test' })
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
