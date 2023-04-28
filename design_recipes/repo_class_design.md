1. Design and create the Table
If the table is already created in the database, you can skip this step.

Otherwise, follow this recipe to design and create the SQL schema for your table.

In this template, we'll use an example table students

2. Create Test SQL seeds
Your tests will depend on data stored in PostgreSQL to run.

-- (file: spec/seeds_shop_tables.sql)

-- First reset tables and create them:
DROP TABLE IF EXISTS items, orders;

TRUNCATE TABLE items, orders RESTART IDENTITY; -- replace with your own table name.

CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name text,
  unit_price decimal,
  quantity int
);

-- Then the table with the foreign key first.
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name text,
  date_placed date,

  item_id int,
  constraint fk_item foreign key(item_id)
    references items(id)
    on delete cascade
);

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO items (name, unit_price, quantity) 
            VALUES ('Hoover', 99.99, 20);
INSERT INTO items (name, unit_price, quantity) 
            VALUES ('Bicycle', 200, 2);

INSERT INTO orders (customer_name, date_placed, item_id)
            VALUES ('Louis', '2022-01-01', 1);
INSERT INTO orders (customer_name, date_placed, item_id)
            VALUES ('Lucy', '2023-01-01', 1);
INSERT INTO orders (customer_name, date_placed, item_id)
            VALUES ('Izzy', '2023-02-01', 2);

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

psql -h 127.0.0.1 shop_manager_test < spec/seeds_shop_tables.sql

3. Define the class names
# Table name: items

# Model item
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

4. Implement the Model class
Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

# Table name: items

# Model class
# (in lib/item.rb)

class Item
  attr_accessor :name, :unit_price, :quantity
end

# Model order
# (in lib/order.rb)

class Order
  attr_accessor :id, :customer_name, :date_placed, :item_id
end


5. Define the Repository Class interface
Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

# Table name: items

# Repository class
# (in lib/item_repository.rb)

class ItemRepository

  # Selecting all records in items table
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, unit_price, quantity
    # FROM items;

    # Returns an array of Item objects. (using Item model class)
  end

  # Add more methods below for each operation you'd like to implement.
  # adds a new item to the item table
  def create(item) # an instance of Item class
    # Executes the SQL query:
    # INSERT INTO items (name, unit_price, quantity) 
            VALUES ($1, $2, $3);
    # with parameters: [item.name, item.unit_price, item.quantity]

    # Returns nothing, just updates the database
  end
end

# Table name: orders

# Repository class
# (in lib/order_repository.rb)

class OrderRepository
  # Selecting all records in orders table
  # No arguments
  def all
    # Executes SQL query:
    # SELECT id, customer_name, date_placed, item_id
    # FROM orders;

    # Returns a list of Order objects (using Order model class)
  end

  # adds a new order to the order table
  def create(order) # an instance of Order class
    # Executes the SQL query:
    # INSERT INTO orders (customer_name, date_placed, item_id)
                  VALUES ($1, $2, $3);
    # with parameters: [order.name, order.unit_price, order.quantity]

    # Returns nothing, just updates the database... 
    # MAYBE update quantity of Item (from item_id).
  end
end


6. Write Test Examples
Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

## ITEMS
# 1
# Get all orders

repo = ItemRepository.new
items = repo.all

items.length # =>  2

items[0].id # => 1
items[0].name # => 'Hoover'
items[0].unit_price # => 99.99
items[0].unit_price # => 20

# 2
# Creates a new item and adds it to database

repo = ItemRepository.new
item = Item.new
item.name = 'Bike pump'
item.unit_price = 20
item.quantity = 3

repo.create(item)

items = repo.all

new_item = items.last

item.id # => 3
item.name # => 'Bike pump'
item.unit_price # => 20
item.quantity # => 3


## ORDERS
# 1
# Get all orders

repo = OrderRepository.new
orders = repo.all

orders.length # =>  3

orders[0].id # =>  1
orders[0].customer_name # => 'Louis'
orders[0].date_placed # => '2022-01-01'
orders[0].item_id # => 1

orders[1].id # =>  2
orders[1].customer_name # =>  'Lucy'
orders[1].date_placed # => '2023-01-01'
orders[1].item_id # => 1

# 2
# Creates a new order and adds it to database

repo = OrderRepository.new
order = Order.new
order.customer_name = 'Francesca'
order.date_placed = '2023-04-28'
order.item_id = 2

repo.create(order)

orders = repo.all
new_order = orders.last

new_order.id # =>  4
new_order.customer_name # => 'Francesca'
new_order.date_placed # => '2023-04-28'
new_order.item_id # => 2


# Get a single student

repo = StudentRepository.new

student = repo.find(1)

student.id # =>  1
student.name # =>  'David'
student.cohort_name # =>  'April 2022'

# Add more examples for each method
Encode this example as a test.

7. Reload the SQL seeds before each test run
Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

# EXAMPLE

# file: spec/item_repository_spec.rb

def reset_shop_tables
  seed_sql = File.read('spec/seeds_shop_tables.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_shop_tables
  end

  # (your tests will go here).
end

8. Test-drive and implement the Repository class behaviour
After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.