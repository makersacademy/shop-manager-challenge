# Items Model and Repository Classes Design Recipe: Shop Manager

## Designing and Creating the Table

```

Table: items

Columns:
id | name | unit_price | quantity
```

## 2. Create Test SQL seeds

```sql

-- file: seeds.sql

-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE items RESTART IDENTITY;

INSERT INTO items (name, unit_price, quantity) VALUES ('cereal', 3, 50);
INSERT INTO items (name, unit_price, quantity) VALUES ('tea', 2, 100);

```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data.

```bash
psql -h 127.0.0.1 shop_manager_test < seeds.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by Repository for the Repository class name.

```ruby

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
  attr_accessor :id, :name, :unit_price, :quantity
end

```
## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

  ```ruby
# Table name: items

# Repository class
# (in lib/item_repository.rb)

class ItemRepository

  # selecting all items
  # no arguments
  def all
    # executes the SQL query:
    # SELECT id, name, unit_price, quantity FROM items;

    # returns an array of Item objects.
  end
  
  # select a single item
  # given the id in argument (an integer)
  def find(id)
    # executes the SQL query:
    # SELECT id, name, unit_price, quantity FROM items WHERE id = $1;

    # returns a single Item object
  end

  # insert a new item record
  # takes an Item object in argument
  def create(item)
  # executes the SQL query
  # INSERT INTO items (name, unit_price, quantity) VALUES ($1, $2, $3);

  # doesn't return anything
  end
end

```

## 6. Write Test Examples

Ruby code that defining the expected behaviour of the Repository class, following the design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby

# 1
# Get all items

repo = ItemRepository.new
items = repo.all
items.length # => 2
items.first.id # => 1
items.first.name # => 'cereal'

# 2
# Get a single item

repo = ItemRepository.new

item = repo.find(1)
item.name # => 'cereal'
item.unit_price # => 3
item.quantity # => 50

# 3
# Get another single item

repo = ItemRepository.new

item = repo.find(2)
item.name # => 'tea'
item.unit_price # => 2
item.quantity # => 100

# 4
# Create a new item
repo = ItemRepository.new

new_item = Item.new
new_item.name = 'bread'
new_item.unit_price = 2
new_item.quantity = 120

repo.create(new_item) # => nil

items = repo.all

items.last.id # => 3
items.last.name # => 'bread'
items.last.unit_price # => 2
items.last.quantity # => 120


```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is to get a fresh table contents every time you run the test suite.

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

 # (tests will go here).

## 8. Test-drive and implement the Repository class behaviour

After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.