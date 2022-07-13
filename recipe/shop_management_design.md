# {{SHOP MANAGEMENT}} Model and Repository Classes Design Recipe


## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

## 3. Define the class names

```ruby
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
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby

# Table name: items

# Model class
# (in lib/item.rb)
class Item
  attr_accessor :id, :name, :unit_price, :quantity
end

# Table name: orders

# Model class
# (in lib/order.rb)
class Order
  attr_accessor :id, :customer, :date
end
```

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# Table name: items

# Repository class
# (in lib/item_repository.rb)
class ItemRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, unit_price, quantity FROM items;
    # Returns an array of Item objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, name, unit_price, quantity FROM items WHERE id = $1;
    # Returns a single Item object.
  end

   def find_with_orders(id)
    # Executes the SQL query:
    # SELECT items.id,
          #         items.name,
          #         items.unit_price,
          #         items.quantity,
          #         orders.id AS order_id,
          #         orders.customer,
          #         orders.date
          # FROM items
          # JOIN items_orders ON items_orders.item_id = items.id
          # JOIN orders ON items_orders.order_id = orders.id
          # WHERE items.id = $1;
    # Returns a single Item object with accociated orders.
  end

  def create(item)
    # Executes the SQL query:
    # INSERT into items (name, unit_price, quantity) VALUES ($1, $2, $3);
    # Returns nothing
  end

  # def delete(id)
  #   # Executes the SQL query:
  #   # DELETE from items WHERE id = $1;
  #   # Returns nothing
  # end

  # def update(item)  
  #   # Executes the SQL query:
  #   # UPDATE items SET name = $1, unit_price = $2, quantity = $3 WHERE id = $4;
  #   # Returns nothing
  # end
end

# Table name: orders

# Repository class
# (in lib/order_repository.rb)
class OrderRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, customer, date FROM orders;
    # Returns an array of Order objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, customer, date FROM orders WHERE id = $1;
    # Returns a single Order object.
  end

  def find_with_items(id)
    # Executes the SQL query:
    # SELECT id, name, unit_price, quantity FROM items WHERE id = $1;
    # SELECT orders.id,
    #               orders.customer,
    #               orders.date,
    #               items.name AS item,
    #               items.unit_price,
    #               items.quantity
    #       FROM orders
    #       JOIN items_orders ON items_orders.order_id = orders.id
    #       JOIN items ON items_orders.item_id = items.id
    #       WHERE orders.id = $1;
    # Returns a single Order object with accociated items.
  end

  def create(order)
    # Executes the SQL query:
    # INSERT into orders (customer, date) VALUES ($1, $2);
    # Returns nothing
  end

  # def delete(id)
  #   # Executes the SQL query:
  #   # DELETE from orders WHERE id = $1;
  #   # Returns nothing
  # end

  # def update(id, attr, value)  
  #   # Executes the SQL query:
  #   # attr is Order's attribute to update
  #   # value is a value provided 
  #   # UPDATE orders SET attr = $1 WHERE id = $2;
  #   # Returns nothing
  # end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# 1
# Get all items

repo = ItemRepository.new

stock = repo.all

stock.length # =>  5

stock[0].id # =>  1
stock[0].name # =>  'milk'
stock[0].unit_price # =>  "$1.00"
stock[0].quantity # =>  35

stock[3].id # =>  4
stock[3].name # =>  '6 eggs'
stock[3].unit_price # =>  "$2.33"
stock[3].quantity # =>  28


# 2
# Get a single item

repo = ItemRepository.new

item = repo.find(1)

item.id # =>  1
item.name # =>  'milk'
item.unit_price # =>  "$1.00"
item.quantity # =>  35

# 3
# Create an Item object

repo = ItemRepository.new
new_item = Item.new
new_item.name = 'minced beef'
new_item.unit_price = 3.99
new_item.quantity = 15
repo.create(new_item)
stock = repo.all
stock.length # => 6
stock #=> to have attributes 'minced beef', "$3.99", 15

# 4
# when looking for an Item with orders data by item's ID
#returns an Item with associated orders

repo = ItemRepository.new
item = repo.find_with_orders(1)
item.name # => 'milk'
item.orders.length # => 3
end

# 5
#returns nil if the Item with given index does not exist
repo = ItemRepository.new
item = repo.find_with_orders(199)
item # => ni

# 1
# Get all orders

repo = OrderRepository.new

orders = repo.all

orders.length # =>  3

orders[0].id # =>  1
orders[0].customer # =>  'Anna'
orders[0].date # =>  '2022-06-21'

orders[1].id # =>  2
orders[1].customer # =>  'John'
orders[1].date # =>  '2022-06-23'


# 2
# Get a single order

repo = OrderRepository.new

order = repo.find(3)

order.id # =>  3
order.customer # =>  'Rachel'
order.date # =>  '2022-07-01'

# 3 
# Adds new order

repo = OrderRepository.new
new_order = Order.new
new_order.customer = 'Alice'
new_order.date = '2022-07-09'
repo.create(new_order)
orders = repo.all
orders.length # => 4
orders # => to have attributes 'Alice', '2022-07-09'

# 4
# when looking for an Order with items data by order's ID
# returns an order with associated items

repo = OrderRepository.new
order = repo.find_with_items(1)
order.customer # => 'Anna'
order.items.length # => 3
end

# 5
#returns nil if the order with given index does not exist
repo = OrderRepository.new
order = repo.find_with_items(199)
order # => nil
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# file: spec/item_repository_spec.rb

def reset_items_table
  seed_sql = File.read('spec/seeds_shop_data.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'items' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_items_table
  end

  # (your tests will go here).
end

# file: spec/order_repository_spec.rb

def reset_orders_table
  seed_sql = File.read('spec/seeds_shop_data.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_database_test' })
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
