# Shops Model and Repository Classes Design Recipe

Copy this recipe template to design and implement Model and Repository classes for a database table.


```

# EXAMPLE

Table: items

Columns:
id | name | unit_price | quantity
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_{table_name}.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE items RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO items (name, unit_price, quantity) VALUES ('chocolate', '7', '3');
INSERT INTO items (name, unit_price, quantity) VALUES ('coffee', '5', '1');

```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by Repository for the Repository class name.

```ruby
# EXAMPLE
# Table name: items

# Model class
# (in lib/artist.rb)
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

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# student = Student.new
# student.name = 'Jo'
# student.name
You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.
Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.
  ```ruby
# EXAMPLE
# Table name: items

# Repository class
# (in lib/item_repository.rb)

class ItemRepository

  # Selecting all items
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, unit_price, quantity FROM items;

    # Returns an array of Item objects.
  end
  
  # Select a single item
  # Given the id in argument (a number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, name, unit_price, quantity FROM items WHERE id = $1;

    # Returns a single Item object
end

# Insert a new item record
# Takes an Item object in argument
def create(item)
# Executes the SQL query
# INSERT INTO items (name, unit_price, quantity) VALUES($1, $2);

# Doesn't need to return anything (only creates the record)
end

# Deletes an item record
# given its id
def delete(id)
# Executes the SQL:
# DELETE FROM items WHERE id = $1;

# Returns nothing (only deletes the record)
end

# Updates an item record
# Takes an Item object (with the updated fields)
def update(item)
  # Executes the SQL:
  # UPDATE items SET name = $1, unit_price = $2 WHERE id = $1;

  # Returns nothing (only updates the record)

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
items.length # => 2
items.first.id # => '1'
items.first.name # => 'chocolate'

# 2
# Get a single item

repo = ItemRepository.new

item = repo.find(1)
item.name # => 'chocolate'
item.unit_price # => '7'
item.quantity # => '3'

# 3
# Get another single item

repo = ItemRepository.new

item = repo.find(2)
item.name # => 'coffee'
item.unit_price # => '5'
item.quantity # => '1'

# 4
# Create a new item
repo = ItemRepository.new

item = Item.new
item.name = 'tea'
item.unit_price = '4'
item.quantity = '2'

repo.create(item) # => nil

items = repo.all

last_item = items.last
last_item.name # => 'tea'
last_item.unit_price # => '4'
last_item.quantity # => '2'


```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

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
## 8. Test-drive and implement the Repository class behaviour

After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.
