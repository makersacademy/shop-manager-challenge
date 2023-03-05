Shop_manager Model and Repository Classes Design Recipe
Copy this recipe template to design and implement Model and Repository classes for a database table.

1. Design and create the Table
If the table is already created in the database, you can skip this step.


2. Create Test SQL seeds
Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

-- EXAMPLE
-- (file: spec/test_seeds.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

# TRUNCATE TABLE items RESTART IDENTITY; 
# TRUNCATE TABLE orders RESTART IDENTITY;

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

# INSERT INTO items (name, price, quantity) VALUES ('Carbonara', 10, 2);
# INSERT INTO orders (date, customer_name, item_id) VALUES (05/02/2023, 'Paolo', 1);
Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

psql -h 127.0.0.1 shop_manager_test < spec/test_seeds.sql
3. Define the class names
Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by Repository for the Repository class name.

--# EXAMPLE
--# Table name: students 
--# Model class
--# (in lib/student.rb)
--class Student
--end

# Table name: items
# Model class
# (in lib/item.rb)
class Item
end

# Table name: orders
# Model class
# (in lib/order.rb)
class Order
end


--# Repository class
--# (in lib/student_repository.rb)
--class StudentRepository
--end

# Repository class
# (in lib/item_repository.rb)
class ItemRepository
end

# Repository class
# (in lib/order_repository.rb)
class OrderRepository
end

4. Implement the Model class
Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

--# EXAMPLE
--# Table name: students

--# Model class
--# (in lib/student.rb)

--class Student

--  # Replace the attributes by your own columns.
 -- attr_accessor :id, :name, :cohort_name
--end

# Table name: items
# Model class
# (in lib/item.rb)
class Item
  attr_accessor :id, :name, :price, :quantity 
end

# Table name: orders
# Model class
# (in lib/order.rb)
class Order
  attr_accessor :id, :date, :customer_name, :item_id
end

5. Define the Repository Class interface
Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

--# EXAMPLE
--# Table name: students
--# Repository class
--# (in lib/student_repository.rb)

--class StudentRepository

  --# Selecting all records
  --# No arguments
  --def all
    --# Executes the SQL query:
    --# SELECT id, name, cohort_name FROM students;

    --# Returns an array of Student objects.
  --end

  --# Gets a single record by its ID
  --# One argument: the id (number)
  --def find(id)
    --# Executes the SQL query:
    --# SELECT id, name, cohort_name FROM students WHERE id = $1;

    --# Returns a single Student object.
  --end

  --# Add more methods below for each operation you'd like to implement.
  --# def create(student)
  --# end

  --# def update(student)
  --# end

  --# def delete(student)
  --# end

  # Table name: items
# Repository class
# (in lib/item_repository.rb)
class ItemRepository
  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, price, quantity FROM items;

    # Returns an array of Items objects.
  end

  # def create(item)
    # Executes the SQL query:
    # sql = 'INSERT INTO items (name, price, quantity) VALUES ($1, $2, $3)';
    # DataConnection.exec_params(sql, [item.name, item.price, item.quantity])

    # it does not return anything
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
    # SELECT id, date, customer_name, item_id FROM orders;

    # Returns an array of Order objects.
  end

  # def create(order)
    # Executes the SQL query:
    # sql = 'INSERT INTO orders (date, customer_name, item_id) VALUES ($1, $2, $3)';
    # DataConnection.exec_params(sql, [order.date, order.customer_name, order.item_id])

    # it does not return anything
  # end
end
6. Write Test Examples
Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

--# EXAMPLES

--# 1
--# Get all students

--repo = StudentRepository.new

--students = repo.all

--students.length # =>  2

--students[0].id # =>  1
--students[0].name # =>  'David'
--students[0].cohort_name # =>  'April 2022'

--students[1].id # =>  2
--students[1].name # =>  'Anna'
--students[1].cohort_name # =>  'May 2022'

# 1 
# Get all items
```ruby
repo = ItemRepository.new

items = repo.all

items.length # =>  2

items[0].id # =>  1
items[0].name # =>  'Carbonara'
items[0].price # =>  10
items[0].quantity # => 2

items[1].id # =>  2
items[1].name # =>  'Milk'
items[1].price # =>  2
items[1].quantity # => 3
```
# 2 
# Create one item
```ruby
repo = ItemRepository.new
item = Item.new
item.name = 'Coffee'
item.price = 3
item.quantity = 10

repo.create(item) # Performs the INSERT query
all_items = repo.all # => # Performs a SELECT query to get all records 
#all_items should contain the item 'Coffee' created above.
```

# 3
# Get all orders
```ruby
repo = OrderRepository.new

order = repo.all

order.length # =>  2

order[0].id # =>  1
order[0].date # =>  '2023-02-06'
order[0].customer_name # =>  'Paolo'
order[0].item_id # => 1

order[1].id # =>  2
order[1].date # =>  '2023-02-21'
order[1].customer_name # =>  'Anna'
order[1].item_id # => 2
```
# Create one order
```ruby
repo = OrderRepository.new
order = Order.new
order.date = '2023/02/25'
order.customer_name = 'Gino'
order.item_id = 3

repo.create(order) # Performs the INSERT query
all_orders = repo.all # => # Performs a SELECT query to get all records 
#all_orders should contain the order '' created above.
```


7. Reload the SQL seeds before each test run
Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

--# EXAMPLE

--# file: spec/student_repository_spec.rb

--def reset_students_table
 -- seed_sql = File.read('spec/seeds_students.sql')
 -- connection = PG.connect({ host: '127.0.0.1', dbname: 'students' })
  --connection.exec(seed_sql)
--end

--describe StudentRepository do
  --before(:each) do 
   -- reset_students_table
  --end

  --# (your tests will go here).
--end

# file: spec/item_repository_spec.rb

def reset_items_table
  seed_sql = File.read('spec/test_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
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
  seed_sql = File.read('spec/test_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe OrderRepository do
  before(:each) do 
    reset_orders_table
  end

  # (your tests will go here).
end


8. Test-drive and implement the Repository class behaviour
After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.