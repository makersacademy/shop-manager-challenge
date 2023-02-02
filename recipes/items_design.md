# Items Model and Repository Classes Design Recipe

## 1. Design and create the Table

```
Table: items

Columns:
id | name | unit_price | quantity
```

## 2. Create Test SQL seeds

```sql
-- (file: spec/seeds.sql)

TRUNCATE TABLE items RESTART IDENTITY;

INSERT INTO items (name, unit_price, quantity)
VALUES ('Super Shark Vacuum Cleaner', 99, 30),
       ('Makerspresso Coffee Machine', 69, 15);
```

## 3. Define the class names

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

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class,
including primary and foreign keys.

```ruby
# Table name: items

# Model class
# (in lib/item.rb)

Item = Struct.new(:id, :name, :unit_price, :quantity)
```

## 5. Define the Repository Class interface

```ruby
# Table name: items

# Repository class
# (in lib/item_repository.rb)

class ItemRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT * FROM items;

    # Returns an array of Item objects.
  end

  # Creates a single record
  # One argument: a new item object
  def create(item)
    # Executes the SQL query:
    # INSERT INTO items (name, unit_price, quantity) VALUES ($1, $2, $3)

    # Returns nil.
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table
written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# 1
# Get all records

repo = ItemsRepository.new

items = repo.all

items # => [
{ id: 1, name: 'Super Shark Vacuum Cleaner', unit_price: 99, quantity: 30 },
  { id: 2, name: 'Makerspresso Coffee Machine', unit_price: 69, quantity: 15 }
]

# 2
# Create a single record

repo = ItemsRepository.new

new_item = Item.new(name: 'Shiny New Item', unit_price: 49, quantity: 100)

repo.create(new_item)

item = repo.all

item.includes(new_item)
```

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# file: spec/reset_tables.rb

def reset_tables
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: 'localhost', dbname: 'shop_test' })
  connection.exec(seed_sql)
end

# file: spec/item_repository_spec.rb

describe ItemRepository do
  before(:each) do
    reset_tables
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._