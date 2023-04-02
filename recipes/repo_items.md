# Items Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `items`*

```
# EXAMPLE

Table: items

Columns:
id | name | price | quantity
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

INSERT INTO items (name, cohort_name) VALUES ('David', 'April 2022');
INSERT INTO items (name, cohort_name) VALUES ('Anna', 'May 2022');
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
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
  attr_accessor :id, :name, :price, :quantity
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# item = item.new
# item.name = 'Jo'
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
    # SELECT id, name, price, quantity FROM items;

    # Returns an array of item objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, name, price, quantity FROM items WHERE id = $1;

    # Returns a single item object.
  end

  # Gets all the items in a specific order
  def find_by_order(order_id) # params for order_id will be $1
    # SELECT items.name, items.price FROM items JOIN items_orders ON items_orders.item_id = items.id
    # JOIN orders ON items_orders.order_id = orders.id WHERE orders.id = $1;
  end

  # Add more methods below for each operation you'd like to implement.

  def create(item)
  # INSERT INTO items (name, price, quantity) VALUES ($1, $2, $3);
  end

  def update(item) # need to update quantity when an item is added to an order
    # UPDATE items SET quantity = $1 WHERE id = $2;
  end

  def delete(id) # when quantity reaches zero, need to delete item from stock
    # DELETE FROM items WHERE id = $1;
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

items.length # =>  6

items[0].id # =>  1
items[0].name # =>  'milk'
items[0].price # =>  '2'
items[0].quantity # => '50'

# 2
# Get a single item
repo = ItemRepository.new

item = repo.find(1)

item.id # =>  '1'
item.name # =>  'milk'
item.price # =>  '2'
item.quantity # => '50'

# 3
# Gets all the items in a specific order
repo = ItemRepository.new

items = repo.find_by_order(3)

items.length # => 3
items[0].id # => '2'
items[0].name # => 'bread'
items[0].price # => '3'
items[0].quantity # => '30'

# 4
# Adds a new item to the database
new_item = Item.new
new_item.name = 'cereal'
new_item.price = 5
new_item.quantity = 70

repo = ItemRepository.new
repo.create(new_item)

items = repo.all
last_item = items.last

last_item.id # => '6'
last_item.name # => 'cereal'
last_item.price # => '5'
last_item.quantity # => '70'

# 5
# Updates the quantity of an item in the database # do logic in app.rb
repo = ItemRepository.new
item = repo.find(1)
item.quantity = 49
repo.update(item)
updated_item = repo.find(1)

updated_item.quantity # => '49'

# 6
# Deletes an item from the database (when it runs out - for integration spec?)
repo = ItemRepository.new
repo.delete(6)
items = repo.all

items.length # => 5
items.last.id # => '5'
items.last.name # => 'broccoli'
items.last.price # => '1'
items.last.quantity # => '45'
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
  connection = PG.connect({ host: '127.0.0.1', dbname: 'items' })
  connection.exec(seed_sql)
end

describe itemRepository do
  before(:each) do
    reset_items_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._

