# {{items}} Model and Repository Classes Design item

_Copy this item template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this item to design and create the SQL schema for your table](./single_table_design_item_template.md).

*In this template, we'll use an example table `items`*

```
# EXAMPLE

Table: items

Columns:
id | name | unit_price | quantity
```
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
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: items

# Model class
# (in lib/item.rb)

class Item

  # Replace the attributes by your own columns.
  attr_accessor :id, :name, :unit_price, :quantity
end
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

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
    # SELECT * FROM items;

    # Returns an array of item objects.
  end

  # Adding an item to the table
  # item: Item - item to add to table
  def create(item)
    # Executes the SQL query:
    # INSERT INTO items (name, unit_price, quantity) VALUES ($1,$2,$3)

    # Returns nil
  end

  # Find all the items attached to an order
  # order_id: int - the id of the order to filter by
  def find_by_order(order_id)
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
	# WHERE order_id = 1;

    # Returns an array of item objects. 
  end
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

items.length # =>  7

items.first.id # =>  1
items.first.name # =>  'Pizza'
items.first.unit_price # =>  9.99
items.first.quantity # =>  100

# 2
# Create an item

repo = ItemRepository.new

item = Item.new
item.name = 'Doughnut'
item.unit_price = 3.99
item.quantity = 250

repo.create(item)

created_item = repo.all.last
created_item.id # => 8
created_item.name # => 'Doughnut'
created_item.unit_price # => 3.99
created_item.quantity # => 250

# 3
# Find items attached to an order

repo = ItemRepository.new

items = repo.find_by_order(1)

items.length # => 4
items.first.id # => 1
items.first.name # => 'Pizza'
items.first.unit_price # => 9.99
items.first.quantity # => 100

```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/item_repository_spec.rb

def reset_tables
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'items_orders_test' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_tables
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._

