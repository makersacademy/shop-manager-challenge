Items Model and Repository Classes Design Recipe

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, follow this recipe to design and create the SQL schema for your table.

In this template, we'll use an example table students


-- EXAMPLE
-- (file: spec/seeds_items.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

```Ruby 

TRUNCATE TABLE items RESTART IDENTITY;

INSERT INTO items (name, unit_price, stock_count) VALUES ('B1 Pencils', '£0.70', '506');
INSERT INTO items (name, unit_price, stock_count) VALUES ('A5 Notebooks', '£4.75', '156');
INSERT INTO items (name, unit_price, stock_count) VALUES ('Blue Biros', '£1.00', '325');

psql -h 127.0.0.1 shop_manager_database < items_table.sql

```

3. Define the class names
Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by Repository for the Repository class name.

```Ruby

# EXAMPLE
# Table name: items

# Model class
# (in lib/item.rb)
class Item
end

# Repository class
# (in lib/item_repository.rb)
class itemRepository
end


### 4. Implement the Model class
Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

# EXAMPLE
# Table name: items

# Model class
# (in lib/item.rb)

class Student

  # Replace the attributes by your own columns.
  attr_accessor :id, :name, :unit_price, :stock_count
end

```

### 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```Ruby

# EXAMPLE
# Table name: items

# Repository class
# (in lib/item_repository.rb)

class ItemRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, unit_price, stock_count FROM students;

    # Returns an array of Student objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, name, unit_price, stock_count FROM items WHERE id = $1;

    # Returns a single Student object.
  end

  def create(item)
    # Executes the SQL query:
    # INSERT INTO items(name, unit_price, stock_count) VALUES ($1, $2, $3);
    # returns nothing
  end

  def delete(id)
    # Executes the SQL query:
    # DELETE FROM items WHERE id $1;
  end
end

```

### 6. Write Test Examples
Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```Ruby 

# EXAMPLES

# 1
# Get all items

repo = ItemRepository.new

items = repo.all

items.length # =>  3

items[0].id # =>  1
items[0].name # =>  'B1 Pencils'
items[0].unit_price # =>  '£0.70'
items[0].stock_count # => '506'

items[2].id # =>  3
items[2].name # =>  'Blue Biros'
items[2].unit_price # =>  '£1.00'
items[2].stock_count # => '325'

# 2
# Get a single item

repo = ItemRepository.new

item = repo.find(2)

item.id # =>  2
item.name # =>  'A5 Notebooks'
item.unit_price # =>  '£4.75'
item.stock_count # => '156'

# 3
# Create a new item

repo = ItemRepository.new
new_item = Item.new
new_item.name = 'Pritt Stick'
new_item.unit_price = '£3.50'
new_item.stock_count = '76'

repo.create(new_item)

all_items = repo.all
all_items.last.id # => '4'
all_items.last.name# => 'Pritt Stick'
all_items.last.unit_price # => '£3.50'
all_items.last.stock_count # => '76'
all_items.length # => 4

# 4
# Delete an item

repo = ItemRepository.new

repo.delete(1)

all_items = repo.all
all_items.length # => 2
all_items.first.id # => '2'
all_items.first.name # => 'A5 Notebooks'
all_items.first.unit_price # =>  '£4.75'
all_items.first.stock_count # => '156'

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