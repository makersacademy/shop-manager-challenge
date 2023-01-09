# ITEMS Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `items`*

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
-- (file: spec/seeds_items.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE items RESTART IDENTITY CASCADE; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO items (name, unit_price, quantity) VALUES ('coffee machine', 80, 30);
INSERT INTO items (name, unit_price, quantity) VALUES ('vacuum cleaner', 100, 15);
INSERT INTO items (name, unit_price, quantity) VALUES ('toaster', 30, 60);


```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 shop_manager_test < seeds_items.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: item

# Model class
# (in lib/item.rb)
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
# item = Item.new
# item.name = 'coffee machine'
# item.name
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
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
        # SELECT id, name, unit_price, quantiy FROM items WHERE id = $1;

        # Returns a single Item object.
    end

    # Inserts new Item record into database
    def create(item)
        # Executes the SQL query
        # INSERT into items (name, unit_price, quantity) VALUES ($1, $2, $3);

        # Returns nothing
    end

    # Deletes an existing Item record from database
    def delete(id)
        # Executes the SQL query
        # DELETE FROM items WHERE id = $1;

        # Returns nothing
    end

    # Updates an existing Item record from database
    def increase_stock(id)
        # Executes the SQL query
        # UPDATE items SET quantity = quanity + 10 WHERE id = $1;
    
        # Returns nothing
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

items.length # =>  3

items[0].id # =>  1
items[0].name # =>  'coffee machine'
items[0].unit_price # =>  80
items[0].quantity # => 30

items[1].id # =>  2
items[1].name # =>  'vacuum cleaner'
items[1].unit_price # =>  100
items[1].quantity # => 15

items[2].id # =>  3
items[2].name # =>  'toaster'
items[2].unit_price # =>  30
items[2].quantity # => 60

# 2
# Get a single item

repo = StudentRepository.new

item = repo.find(1)

item.id # =>  1
item.name # =>  'coffee machine'
item.unit_price # =>  80
item.quantity # => 30

# 3
# Creates a new item

repo = ItemRepository.new


item = Item.new
item.name = 'fridge'
item.unit_price = 200
item.quantity =  20

items = repo.all
items[3].name # => 'name'


# 4
# Increases stock of item

repo = ItemRepository.new

repo.increase_stock(1)

item = repo.find(1)
item.quantity # => 40
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/item_repository_spec.rb

def reset_items_table
  seed_sql = File.read('spec/seeds_items.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_items_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._
