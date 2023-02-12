# Item Model and Repository Classes Design Recipe

## 1. Design and create the Table

Full table design can be found in recipes/tables_design.md

```
Table: items
id: 
name: 
unit_price: 
quantity: 
```

## 2. Create Test SQL seeds

```sql
-- (file: spec/seeds_shop.sql)

TRUNCATE TABLE items RESTART IDENTITY; 

-- Below this line there should only be `INSERT` statements.

INSERT INTO items (name, unit_price, quantity) VALUES ('Bread', '1.00', '20');
INSERT INTO items (name, unit_price, quantity) VALUES ('Ham', '3.00', '30');


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
# Table name: items

# Model class
# (in lib/item.rb)

class Item

  # Replace the attributes by your own columns.
  attr_accessor :id, :name, :unit_price, :quantity
end

```

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: items

# Repository class
# (in lib/items_repository.rb)

class ItemRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, unit_price, quantity FROM items;

    # Returns an array of Items objects.
  end

  # Gets a single item by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, name, unit_price, quantity FROM items WHERE id = $1;

    # Returns a single Item object.
  end

  def create(item)
    # Executes the SQL query:
    # INSERT INTO items (name, unit_price, quantity) VALUES ($1, $2, $3);

    # creates an item object and doesn't return anything
  end

  def delete(id)
    # Executes the SQL query:
    # DELETE FROM items WHERE id = $1;

    # deletes an item
  end

  def update(item)
    # Executes the SQL query:
    # UPDATE items SET name = $1, unit_price = $2, quantity = $3 WHERE id = $4;
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

items.length # =>  2
items[0].id # =>  1
items[0].name # =>  'Bread'
items[0].unit_price # =>  '1.00'
items[0].quantity # =>  '20'

items[1].id # =>  2
items[1].name # =>  'Ham'
items[1].unit_price # =>  '3.00'
items[1].quantity # =>  '30'


# 2
# Get a single item
repo = ItemRepository.new
items = repo.find(1)

items.id # =>  1
items.name # =>  'Bread'
items.unit_price # =>  '1.00'
items.quantity # =>  '20'


# 3 
# Create a new item
repo = ItemRepository.new
item = Item.new
item.id # =>  3
item.name # =>  'Jam'
item.unit_price # =>  '1.50'
item.quantity # =>  '25'

repo.create(item)

item.length # =>  3
repo.all.last.name # => 'Jam'


# 4
# Delete an item
repo = ItemRepository.new
item = repo.find(1)
repo.delete(item.id)

repo.all # => 1
repo.all.first.id # => 2


# 5
# Update an item 
repo = ItemRepository.new
item = repo.find(1)

item.name = # => 'Bagle'
items.unit_price # =>  '1.50'
items.quantity # =>  '25'

repo.update(item)

updated_item = repo.find(1)
updated_item.name # => 'Bagle'
updated_item.unit_price # => '1.50'
updated_item.quantity # => '25'

```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/item_repository_spec.rb

def reset_items_table
  seed_sql = File.read('spec/seeds_shop.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop' })
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