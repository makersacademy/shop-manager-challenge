# Shop Manager Database Model and Repository Classes Design Recipe

## 1. The Tables

```
Table: items

Columns:
id | name | price | quantity

Table: orders
id | customer_name | date

Table: items_orders
item_id | order_id
```

## 2. Test SQL seeds

```sql
-- (file: spec/seeds_shop_manager.sql)

TRUNCATE TABLE items, orders, items_orders RESTART IDENTITY; -- replace with your own table name.

INSERT INTO items (name, price, quantity) VALUES ('shirt', 35, 5);
INSERT INTO items (name, price, quantity) VALUES ('jeans', 50, 6);
INSERT INTO items (name, price, quantity) VALUES ('hoodie', 40, 3);

INSERT INTO orders (customer_name, date) VALUES ('Jack', '2023-02-21');
INSERT INTO orders (customer_name, date) VALUES ('George', '2023-03-10');

INSERT INTO items_orders (item_id, order_id) VALUES (1, 1);
INSERT INTO items_orders (item_id, order_id) VALUES (1, 2);
INSERT INTO items_orders (item_id, order_id) VALUES (2, 1);
INSERT INTO items_orders (item_id, order_id) VALUES (3, 2);
```

```bash
psql -h 127.0.0.1 shop_manager < seeds_shop_manager.sql
```

## 3. The class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby

# Application class
# file: app.rb
class Application

  # The Application class initializer
  # takes four arguments:
  #  * The database name to call `DatabaseConnection.connect`
  #  * the Kernel object as `io` (so we can mock the IO in our tests)
  #  * the ItemRepository object (or a double of it)
  #  * the OrderRepository object (or a double of it)
  def initialize(database_name, io, album_repository, artist_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @album_repository = album_repository
    @artist_repository = artist_repository
  end

  def run
    # "Runs" the terminal application
    # so it can ask the user to enter some input
    # and then decide to run the appropriate action
    # or behaviour.

    # Use `@io.puts` or `@io.gets` to
    # write output and ask for user input.
  end
end

# Don't worry too much about this if statement. It is basically saying "only
# run the following code if this is the main file being run, instead of having
# been required or loaded by another file.
# If you want to learn more about __FILE__ and $0, see here: https://en.wikibooks.org/wiki/Ruby_Programming/Syntax/Variables_and_Constants#Pre-defined_Variables
if __FILE__ == $0
  app = Application.new(
    'shop_manager',
    Kernel,
    ItemRepository.new,
    OrderRepository.new
  )
  app.run
end

# Table name: items

# Model class
# (in lib/item.rb)
class Item
    attr_accessor :id, :name, :price, :quantity, :orders

    def initialize
        @orders = []
    end
end

# Repository class
# (in lib/item_repository.rb)
class ItemRepository
  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, price, quantity FROM items;

    # Returns an array of Item objects.
  end

  def find(id)
    # Executes the SQL query:
    # SELECT id, name, price, quantity FROM items WHERE id = $1;

    # Returns a single Item object.
  end

  def find_with_orders(id)
    # Executes the SQL query:
    # SELECT
    #     items.id,
    #     items.name
    #     items.price
    #     items.quantity
    #     orders.id AS orders_id
    #     orders.customer_name
    #     orders.date
    # FROM
    #     items
    # JOIN items_orders ON items_orders.item_id = items.id
    # JOIN orders ON items_orders.order_id = orders.id
    # WHERE items.id = $1

    # Returns a single Item object with associated Order objects.
  end

  def create(item)
    # Executes the SQL query:
    # INSERT INTO items (name, price, quantity) VALUES ($1, $2, $3);
    # Returns nil
  end
end

# Table name: orders

# Model class
# (in lib/order.rb)
class Item
    attr_accessor :id, :customer_name, :date, :items

    def initialize
        @items = []
    end
end

# Repository class
# (in lib/order_repository.rb)
class OrderRepository
  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, customer_name, date FROM orders;

    # Returns an array of Order objects.
  end

  def find(id)
    # Executes the SQL query:
    # SELECT id, customer_name, date FROM orders WHERE id = $1;

    # Returns a single Order object.
  end

  def find_with_orders(id)
    # Executes the SQL query:
    # SELECT
    #     orders.id
    #     orders.customer_name
    #     orders.date
    #     items.id AS items_id,
    #     items.name
    #     items.price
    #     items.quantity
    # FROM
    #     orders
    # JOIN items_orders ON items_orders.order_id = orders.id
    # JOIN items ON items_orders.item_id = items.id
    # WHERE orders.id = $1

    # Returns a single Order object with associated Item objects.
  end

  def create(item)
    # Executes the SQL query:
    # INSERT INTO orders (customer_name, date) VALUES ($1, $2);
    # Returns nil
  end
end
```

## 4. Test Examples

```ruby
# UNIT TESTS

# 1 Application class
$ ruby app.rb
# Welcome to the shop management program!

# What do you want to do?
#   1 = list all shop items
#   2 = create a new item
#   3 = list all orders
#   4 = create a new order

# 1 [enter]

# Here's a list of all shop items:

#  #1 Super Shark Vacuum Cleaner - Unit price: 99 - Quantity: 30
#  #2 Makerspresso Coffee Machine - Unit price: 69 - Quantity: 15

# -----

# ItemRepository

# 1
# Get all items

repo = ItemRepository.new

items = repo.all

items.length # =>  3

items[0].id # =>  '1'
items[0].name # =>  'shirt'

items[1].id # =>  '2'
items[1].name # =>  'jeans'

items[2].id # => '3'
items[1].name # =>  'hoodie'

# 2
# Get a single item

repo = ItemRepository.new

item = repo.find(1)

item.id # =>  '1'
item.name # =>  'shirt'
item.price # =>  '35.00'
item.quantity # => '5'

item = repo.find(2)

item.id # =>  '2'
item.name # =>  'jeans'
item.price # =>  '50.00'
item.quantity # => '6'

# 3
# Get an item and orders
repo = ItemRepository.new

item = repo.find_with_orders(1)

items.length # =>  3

items[0].id # =>  '1'
items[0].customer_name # =>  'Jack'

items[1].id # => '1'
items[1].customer_name # => 'shirt'

items[2].id # => '2'
items[2].customer_name # => 'jeans'

item = repo.find_with_orders(2)

items.length # =>  3

items[0].id # =>  '3'
items[0].name # =>  'hoodie'

items[1].id # => '1'
items[1].customer_name # => 'George'

# 4
# Create an item
repo = ItemRepository.new
item = Item.new
item.name = 'jacket'
item.price = 65
item.quantity = 4new

repo.create(item)

items = repo.all

items.length # =>  4

items.last.id # =>  '4'
items.last.name # =>  'jacket'

# -----

# OrderRepository

# 1
# Get all Orders

repo = OrderRepository.new

orders = repo.all

orders.length # =>  2

orders[0].id # =>  '1'
orders[0].customer_name # =>  'Jack'

orders[1].id # =>  '2'
orders[1].name # =>  'George'

# 2
# Get a single order

repo = OrderRepository.new

order = repo.find(1)

order.id # =>  '1'
order.customer_name # =>  'Jack'
order.date # =>  '2023-02-21'

order = repo.find(2)

order.id # =>  '2'
order.name # =>  'George'
order.date # =>  '2023-03-10'

# 3
# Get an order and items
repo = OrderRepository.new

order = repo.find_with_items(1)

orders.length # =>  3

orders[0].id # =>  '1'
orders[0].customer_name # =>  'Jack'

orders[1].id # => '1'
orders[1].name # => 'shirt'

orders[2].id # => '2'
orders[2].name # => 'jeans'

order = repo.find_with_orders(3)

orders.length # =>  3

orders[0].id # =>  '2'
orders[0].customer_name # =>  'George'

orders[1].id # => '1'
orders[1].name # => 'shirt'

orders[2].id # => '3'
orders[2].name # => 'hoodie'

# 4
# Create an order
repo = OrderRepository.new
order = order.new
order.customer_name = 'Rachel'
order.date = '2023-03-24'

repo.create(order)

orders = repo.all

orders.length # =>  3

orders.last.id # =>  '3'
orders.last.name # =>  'Rachel'
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_tables
  seed_sql = File.read('spec/seeds_tests.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

RSpec.describe [table]Repository do
  before(:each) { reset_tables }

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._
