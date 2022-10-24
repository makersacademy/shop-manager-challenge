2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

-- EXAMPLE
-- (file: spec/seeds_tables.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE items RESTART IDENTITY; -- replace with your own table name.
TRUNCATE TABLE orders RESTART IDENTITY; -- replace with your own table name.
TRUNCATE TABLE items_orders RESTART IDENTITY CASCADE; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO items (name, price, quantity) VALUES ('Tartan Paint', '6.75', 30);
INSERT INTO items (name, price, quantity) VALUES ('Hens Teeth', '15.45', 3);
INSERT INTO items (name, price, quantity) VALUES ('Rocking Horse Droppings', '45.95', 1);

INSERT INTO orders (customer_name, date) VALUES ('Bob', '10-20-2022');
INSERT INTO orders (customer_name, date) VALUES ('Julie', '05-07-2022');
INSERT INTO orders (customer_name, date) VALUES ('Mavis', '08-10-2021');

INSERT INTO items_orders (item_id, order_id) VALUES ('1', '1')
INSERT INTO items_orders (item_id, order_id) VALUES ('3', '1')
INSERT INTO items_orders (item_id, order_id) VALUES ('2', '2')
INSERT INTO items_orders (item_id, order_id) VALUES ('3', '2')
INSERT INTO items_orders (item_id, order_id) VALUES ('1', '3')
INSERT INTO items_orders (item_id, order_id) VALUES ('2', '3')
INSERT INTO items_orders (item_id, order_id) VALUES ('3', '3')

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

psql -h 127.0.0.1 shop_manager < seeds_{table_name}.sql

4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

# EXAMPLE
# Table name: items

# Model class
# (in lib/item.rb)

class Item

  # Replace the attributes by your own columns.
  attr_accessor :id, :name, :price, :quantity, :orders
end

# Table name: orders

# Model class
# (in lib/order.rb)

class Order

  # Replace the attributes by your own columns.
  attr_accessor :id, :customer_name, :date, :items
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# student = Student.new
# student.name = 'Jo'
# student.name

You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.
5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

# EXAMPLE
# Table name: orders

# Repository class
# (in lib/order_repository.rb)

class OrderRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT orders.id AS ord_id, customer_name, date, items.id AS it_id, name, price, quantity
    # FROM orders
    # JOIN items_orders ON items_orders.order_id = orders.id
    # JOIN items ON items_orders.item_id = items.id;

    # Returns an array of Order objects.
  end

  def create(order)
    # Executes the SQL query:
    # INSERT INTO orders (customer_name, date) VALUES ($1, $2)
    # INSERT INTO items_orders (item_id, order_id) VALUES ($3, $4)

  end
end

# Table name: items

# Repository class
# (in lib/item_repository.rb)

class ItemRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT orders.id AS ord_id, customer_name, date, items.id AS it_id, name, price, quantity
    # FROM orders
    # JOIN items_orders ON items_orders.order_id = orders.id
    # JOIN items ON items_orders.item_id = items.id;

    # Returns an array of Item objects.
  end

  def create(item)
    # Executes the SQL query:
    # INSERT INTO items (name, price, quantity) VALUES ($1, $2, $3)
    # INSERT INTO items_orders (item_id, order_id) VALUES ($4, $5)

  end
end

6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

# Table orders
# EXAMPLES

# 1
# Get all orders

repo = OrderRepository.new

orders = repo.all

orders.length # =>  3

orders[0].id # =>  1
orders[0].customer_name # =>  'Bob'
orders[0].date # =>  '10-20-2022'
orders[0].items # => ['1', '3']

orders[2].id # =>  3
orders[2].customer_name # =>  'Mavis'
orders[2].cdate # =>  '08-10-2021'
orders[2].items # => ['1', '2', '3']

# 2
# Create an order

repo = OrderRepository.new

order = Order.new
order.custome_name = 'Andy'
order.date = '10-21-2022'
order.items = ['1', '2']

repo.create(order)

result = repo.all

result[3].id # =>  4
result[3].customer_name # =>  'Andy'
result[3].date # =>  '10-21-2022'
result[3].items # => ['1', '2']


# Table items
# EXAMPLES

# 1
# Get all items

repo = ItemRepository.new

items = repo.all

items.length # =>  3

items[0].id # =>  1
items[0].name # =>  'Tartan Paint'
items[0].price # =>  '6.75'
items[0].quantity # => '30'
items[0].orders # => ['1', '3']

items[2].id # =>  3
items[2].name # =>  'Rocking Horse Droppings'
items[2].price # =>  '15.45'
items[2].quantity # => '3'
items[2].orders # => ['1', '2', '3']

# 2
# Create an item

repo = ItemRepository.new

item = Item.new
item.name = 'Fairy Dust'
item.price = '200.85'
item.quantity = '0'
item.orders = []

repo.create(item)

result = repo.all

result[3].id # =>  4
result[3].name # =>  'Fairy Dust'
result[3].price # =>  '200.85'
result[3].quantity # => '0'
result[3].orders # => []



# Add more examples for each method

Encode this example as a test.
7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

# EXAMPLE

# file: spec/order_repository_spec.rb

def reset_tables
  seed_sql = File.read('spec/seeds_tables.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager' })
  connection.exec(seed_sql)
end

describe OrderRepository do
  before(:each) do 
    reset_tables
  end

  # (your tests will go here).
end

# file: spec/item_repository_spec.rb

def reset_tables
  seed_sql = File.read('spec/seeds_tables.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_tables
  end

  # (your tests will go here).
end

8. Test-drive and implement the Repository class behaviour

After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.