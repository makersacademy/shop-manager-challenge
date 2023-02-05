# ITEMS Model and Repository Classes Design Recipe

## 1. Design and create the Table

Table is created. Details are in **table_design_schema.md**

```
Table: items

Columns:
name | price | qty
```

## 2. Create Test SQL seeds

```sql
-- (file: spec/seeds_items.sql)

TRUNCATE TABLE items RESTART IDENTITY; 

INSERT INTO items (name, price, qty) VALUES ('Shirt', '15', '50');
INSERT INTO items (name, price, qty) VALUES ('Sweat', '30', '100');
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 shop_manager_test < seeds_items.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# Table name: items

# Model class
# (in lib/items.rb)
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
# (in lib/items.rb)

class Item
  attr_accessor :id, :name, :price, :qty
end
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# Table name: items

# Repository class
# (in lib/item_repository.rb)

class ItemRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, price, qty, FROM items;
    # Returns an array of Item objects.
  end

  def create(item)
  # INSERT INTO items (name, price, qty) VALUES ($1, $2, $3);
  # No return, just creates new Item object
  end

end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# 1
# Get all items

repo = ItemRepository.new

items = repo.all

items.length # =>  2

items[0].id # =>  1
items[0].name # =>  'Shirt'
items[0].price # =>  '15'
items[0].qty # => '50'

items[1].id # =>  1
items[1].name # =>  'Sweat'
items[1].price # =>  '30'
items[1].qty # => '100'

# 2
# Create an item

repo = ItemRepository.new

item = Item.new
item.name = 'Socks'
item.price = '7'
item.qty = '40'

repo.create(item) # => nil

item = repo.all
last_item = item.last
last_item.name # => 'Socks'
last_item.price # => '7'
last_item.qty # => '40'
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
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
