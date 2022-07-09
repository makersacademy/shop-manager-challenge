Create Test SQL seeds
Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

-- EXAMPLE
-- (file: spec/seeds_{table_name}.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE students RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO students (name, cohort_name) VALUES ('David', 'April 2022');
INSERT INTO students (name, cohort_name) VALUES ('Anna', 'May 2022');
Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
3. Define the class names
Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by Repository for the Repository class name.

# EXAMPLE
# Table name: orders

# Model class
# (in lib/student.rb)
class Order
end

# Repository class
# (in lib/student_repository.rb)
class OrderRepository
end

Item class

class Item
end

class ItemRepository
end
4. Implement the Model class
Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

# EXAMPLE
# Table name: students

# Model class
# (in lib/student.rb)

class Order

  # Replace the attributes by your own columns.
  attr_accessor :id, :customer_name, :date
end

class Item

  # Replace the attributes by your own columns.
  attr_accessor :id, :item_name, :unit_price, quantity
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
# Table name: students

# Repository class
# (in lib/student_repository.rb)

class ItemRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, item_name, unit_price, quantity FROM shop_items;

    # Returns an array of Item objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, item_name, unit_price, quantity FROM shop_items WHERE id = $1;

    # Returns a single Student object.
  end

  def create(item)
    # INSERT INTO shop_items (item_name, unit_price, quantity) VALUES ($1,$2, $3);

    #Doesn't return anything
  end

end

class OrderRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, customer_name, date FROM orders;

    # Returns an array of Order objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, customer_name, date FROM orders WHERE id = $1;

    # Returns a single Order object.
  end

  def create(order)
    # INSERT INTO orders (customer_name, date) VALUES ($1,$2);

    #Doesn't return anything
  end

end
6. Write Test Examples
Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

# EXAMPLES - ITEMS

# 1
# Get all items

repo = ItemRepository.new
items = repo.all

items.length # =>  6

items[0].id # =>  1
items[0].item_name # =>  'Milk'
items[0].unit_price # =>  '1.50'
items[0].quantity # => '150'

items[3].id # =>  3
items[3].item_name # =>  'Cherries'
items[3].unit_price # =>  '368'
items[3].quantity # => '150'

# 2
# Get a single item

repo = ItemRepository.new

item = repo.find(1)

item.id # =>  1
item.item_name # =>  'David'
item.unit_price # =>  'April 2022'
item.quantity # => '150'

# 3 Create a single item

repo = ItemRepository.new
item = Item.new
item.item_name = 'Soup'
item.unit_price = '3'
item.quantity = '50'

repo.create(item) => nil

items = repo.all

last_item = item.last
last_item.item_name = 'Soup'
last_item.unit_price = '3'
item.quantity = '50'

# EXAMPLES - ORDER
# 1
# Get all items

repo = OrderRepository.new
orders = repo.all

orders.length # =>  4

orders[0].id # =>  1
orders[0].customer_name # =>  'Milk'
orders[0].date # =>  '2022-07-03 00:00:00'

orders[3].id # =>  3
orders[3].customer_name # =>  'Julien'
orders[3].date # =>  '2022-07-02 00:00:00'

# 2
# Get a single item

repo = OrderRepository.new

order = repo.find(3)

order.id # =>  3
order.customer_name # =>  'Julien'
order.date # =>  '2022-07-02 00:00:00'

# 3 Create a single order

repo = OrderRepository.new
order = Order.new
order.customer_name = 'Timmy'
order.date = '2021-07-02 00:00:00'

repo.create(order) => nil

order = repo.all

last_order = order.last
last_order.customer_name = 'Soup'
last_order.date = '2021-07-02 00:00:00'

# Add more examples for each method
Encode this example as a test.

7. Reload the SQL seeds before each test run
Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

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
8. Test-drive and implement the Repository class behaviour
