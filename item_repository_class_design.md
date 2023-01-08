# Items Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `students`*

```
# EXAMPLE

Table: students

Columns:
id | name | cohort_name
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql

```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby


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
  attr_accessor :id, :item_name, :unit_price, :quantity
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# item = Item.new
# item.quantity = 12
# item.quantity
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
  def all
    # Takes no args
    # Executes the SQL query:
    #   SELECT id, item_name, quantity, unit_price FROM items;
    
    # Returns an array of item objects 
  end

  def find(id)
    # Takes id as arg
    # Executes the SQL query:
    #   SELECT id, item_name, quantity, unit_price FROM items WHERE id = $1;'
    #   query paramater:  [id]

    # Returns an array containing one item object with the queried id
  end
    
  def update_item_name(item_name, id)
    # Takes item_name, id as args
    # Executes the SQL query:
    
    #   UPDATE items
    #   SET item_name = $1 WHERE id = $2 
    #   RETURNING * ;
    
    #   Query paramaters:  [item_name, id]

    # Returns the updated record
  end 

  def update_unit_price(unit_price, id)
    # Takes unit_price, id as args
    
    # Executes the SQL query:
    #   UPDATE items
    #   SET unit_price = $1 WHERE id = $2 
    #   RETURNING * ;
    
    #   Query parameters:  [unit_price, id]

    # Returns the updated record
  end 

  def update_item_quantity(quantity, id)
    # Takes quantity, id as args

    # Executes the SQL query:
    #        UPDATE items
    #        SET quantity = $1 WHERE id = $2 
    #        RETURNING * ;'

    #        Query parameters: [quantity, id]

    # Returns the updated record
  
  end 
  def create(item)
    # Takes Item object as arg

    # Executes the SQL query:
    #        INSERT INTO items(item_name, unit_price, quantity) 
    #        VALUES($1, $2, $3)
    #        RETURNING *; 

    #        Query parameters: [item.item_name, item.unit_price, item.quantity]
    #        Returns the record of the created item
end

    

end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1 
# all
# Get all items
repo = ItemRepository.new
items = repo.all
items.length # => 5 
items.first.id # => 1 
items.first.item_name # => 'paint set' 
items.first.quantity # => 8 

# 2 
# find(id)
# Gets a single item
repo = ItemRepository.new
item = repo.find(2)
item.id # => 2
item.item_name # => 'brush set'
item.quantity # => 24


# 3 
# update_item_name(name, id)
# Updates an item name
repo = ItemRepository.new
items = repo.update_item_name('clay', 1)
items.length # => 1
items.first.id # => 1
items.first.item_name # => 'clay'


# 4 
# update_item_price(price, id)
# Updates unit price
repo = ItemRepository.new
items = repo.update_unit_price(20, 1)
items.length # => 1 
items.first.id # => 1   
items.first.unit_price # => 20



# 5 
# update_item_quantity(quantity, id)
# Updates an item quantity
repo = ItemRepository.new
items = repo.update_item_quantity(50, 1)
items.length # => 1
items.first.id # => 1
items.first.quantity # => 50


# 6
# create(item)
# Creates an item
item = Item.new()
repo = ItemRepository.new
item.item_name = 'apron'
item.quantity = 16
item.unit_price = 14
repo.create(item)
repo.all[-1].item_name# => 'apron'
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/item_repository_spec.rb

def reset_tables
  seed_sql = File.read('spec/seeds_shop_manager.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_tables
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._
