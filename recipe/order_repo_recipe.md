# {{TABLE NAME}} Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## User stories and Terminal outputs
```
As a shop manager
So I can know which items I have in stock
I want to keep a list of my shop items with their name and unit price. < table

As a shop manager
So I can know which items I have in stock
I want to know which quantity (a number) I have for each item.

As a shop manager
So I can manage items
I want to be able to create a new item.

As a shop manager
So I can know which orders were made
I want to keep a list of orders with their customer name.

As a shop manager
So I can know which orders were made
I want to assign each order to their corresponding item.

As a shop manager
So I can know which orders were made
I want to know on which date an order was placed. 

As a shop manager
So I can manage orders
I want to be able to create a new order.
```

Here's an example of the terminal output your program should generate (yours might be slightly different — that's totally OK):

```
Welcome to the shop management program!

What do you want to do?
  1 = list all shop items
  2 = create a new item
  3 = list all orders
  4 = create a new order

1 [enter]

Here's a list of all shop items:

 #1 Super Shark Vacuum Cleaner - Unit price: 99 - Quantity: 30
 #2 Makerspresso Coffee Machine - Unit price: 69 - Quantity: 15
 (...)
```
## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
TRUNCATE TABLE items, orders, items_orders RESTART IDENTITY;

INSERT INTO items (item_name, item_price, item_quantity) VALUES 
('Smart Watch', '250.0', '60'),
('USB C to USB adapter', '8.99', '430'),
('Wireless Earbuds', '24.64', '34'),
('Shower Head and Hose', '16.99', '4');

INSERT INTO orders (customer_name, order_date) VALUES 
('Jimothy', '2022-05-07'),
('Nick', '2022-04-25');

INSERT INTO items_orders (item_id, order_id) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 2),
(1, 2);
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
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
  attr_accessor :id, :customer_name, :order_date
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

  def all
    # Executes the SQL query:
    # SELECT * FROM orders;

    # Returns an array of order objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find_item_by_order_id(id)
    # Executes the SQL query:
    # SELECT id, name, cohort_name FROM orders WHERE id = $1;

    # Returns a single order object.
  end

  # Add more methods below for each operation you'd like to implement.

  # def create(order)
    #1 Add order to orders table with customer name and order date
      #customer_name = gets.chomp
      #order_date = Time.now --> format to the YYYY-MM-DD format
      #create(customer_name, order_date, [array of item_ids])
      # sql = 'INSERT INTO orders (customer_name, order_date) VALUES ($1, $2)
    #2 Look up the item_ids from the items table for each ordered item.
      #order.items_to_buy iterate through each do |record| ...
    #3 Add order number with matched items to the items_orders table

      # sql = SELECT order.id FROM orders WHERE order.customer_name = $1
      # params = [order.customer_name]

      # params = [record, all.last]
      # sql = 'INSERT INTO items_orders (item_id, order_id) VALUES ($1, $2)
  # end

  def find_items_by_order_id(id)
    #order_id as an argument
    #executes SQL query:
    #'SELECT items.id, items.name
      # FROM items 
      #   JOIN items_orders ON items_orders.item_id = items.id
      #   JOIN orders ON items_orders.order_id = orders.id
      #   WHERE orders.id = $1;'

    # returns array of items matching the order_id
  end


  # def update(order)
  # end

  # def delete(order)
  # end
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

orders.length # =>  2

orders[0].id # =>  1
orders[0].customer_name # =>  'Jimothy'
orders[0].order_date# =>  '2022-05-07'

orders[1].id # =>  2
orders[1].name # =>  'Nick'
orders[1].order_date# =>  '2022-04-25'

# 2
# # Get a single order

# repo = OrderRepository.new

# order = repo.find(1)

# order.id # =>  1
# order.name # =>  'David'
# order.order_date# =>  'April 2022'

# 3
# Create an order
 
  repo = OrderRepository.new

  order = Order.new
  order.customer_name = 'Patrick'
  order.order_date = '2022-08-25'
  order.items_to_buy = [1,2,3]

  repo.create(order)

  repo.all.length # => 3

  repo.all.last.customer_name # => 'Patrick'
  repo.all.last.order_date # => '2022-08-25'

#4
# Find_items_by_order_id

  repo = OrderRepository.new
  items = repo.find_items_by_order_id(1)
  
  expect(items.length).to eq 3

  expect(items.first.item_name).to eq 'Smart Watch'
  expect(items.first.item_price).to eq 250.0

# Add more examples for each method
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_students_table
  seed_sql = File.read('spec/seeds_students.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'students' })
  connection.exec(seed_sql)
end

describe StudentRepository do
  before(:each) do 
    reset_students_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._
