Items and Orders Model and Repository Classes Design Recipe

Copy this recipe template to design and implement Model and Repository classes for a database table.

1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, follow this recipe to design and create the SQL schema for your table.

In this template, we'll use an example table students

# EXAMPLE

Table: students

Columns:
id | name | cohort_name
2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

-- EXAMPLE
-- (file: spec/seeds_items_orders.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE items, orders RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO items (name, unit_price, item_quantity) VALUES ('Mascara', 9, 30);
INSERT INTO items (name, unit_price, item_quantity) VALUES ('Foundation', 42, 40);
INSERT INTO items (name, unit_price, item_quantity) VALUES ('Lipstick', 19, 15);
INSERT INTO items (name, unit_price, item_quantity) VALUES ('Blusher', 22, 10);

INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Cindy', '2023-03-05', 2);
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Lucy', '2023-03-03', 2);
INSERT INTO orders (customer_name, order_date), item_id VALUES ('Jane', '2023-03-01', 1);
INSERT INTO orders (customer_name, order_date), item_id VALUES ('Alex', '2023-03-01', 4);


Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

psql -h 127.0.0.1 shop_manager < spec/seeds_items_orders.sql
3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by Repository for the Repository class name.

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

4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

# EXAMPLE
# Table name: items

# Model class
# (in lib/item.rb)

class Item

  # Replace the attributes by your own columns.
  attr_accessor :id, :name, :unit_price, :item_quantity
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
# Table name: items

# Repository class
# (in lib/item_repository.rb)

class ItemRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, unit_price, item_quantity FROM items;

    # Returns an array of Item objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, name, unit_price, item_quantity FROM items WHERE id = $1;

    # Returns a single Album object.
  end

  # RUN OUT OF TIME. WILL IMPLEMENT THE BELOW SOON.

  # def create(student)
  # end

  # def update(student)
  # end

  # def delete(student)
  # end
end
6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

# EXAMPLES

# 1
# Get all items

repo = ItemRepository.new

items = repo.all

items.length # =>  4

items[0].id # =>  1
items[0].name # =>  'Mascara'
items[0].unit_price # =>  9
items[0].item_quantity # =>  30


items[1].id # =>  2
items[1].name # =>  'Foundation'
items[1].unit_price # =>  42
items[1].item_quantity # =>  40

# 2
# Get a single item

repo = ItemRepository.new

item = repo.find(1)

item.id # =>  1
item.name # =>  'Mascara'
items.unit_price # =>  9
items.item_quantity # =>  30

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

After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.