# items Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table
[See [table_design.md](shop-manager-challenge/items_repository_class_design.md)]

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- (file: spec/seeds_items.sql)
TRUNCATE TABLE items RESTART IDENTITY; 

INSERT INTO items (item_name, price) VALUES ('Apple', 90);
INSERT INTO items (item_name, price) VALUES ('Banana', 75);
INSERT INTO items (item_name, price) VALUES ('Cherries', 120);
INSERT INTO items (item_name, price) VALUES ('Apple', 90);
INSERT INTO items (item_name, price) VALUES ('Banana', 75);
INSERT INTO items (item_name, price) VALUES ('Banana', 75);
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 shop_manager < seeds_items.sql
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
# Table name: items

# Model class
# (in lib/item.rb)
class Item
  attr_accessor :id, :item_name, :price, :order_id
  #TODO does order_id need to be initialized as nil?
  # Select an item from id and add the given order_id
  # Two arguments: item_id - number, order_id - number
  def update_order_id(item_id, order_id)
    # Executes the SQL query:
    # UPDATE items SET order_id = $1 WHERE id = $2;

    # Returns nil
  end
end
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

```ruby
# Table name: items

# Repository class
# (in lib/item_repository.rb)
class ItemRepository
  # Selecting all records
  # No arguments
  def list
    # Executes the SQL query:
    # SELECT id, item_name, price, order_id FROM items;

    # Returns an array of Item objects.
  end

  # Create a new item
  # One argument: Item object
  def create(item)
    # Executes the SQL query:
    # INSERT INTO items (item_name, price) VALUES($1,$2);

    # Returns nothing
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# 1
# list all items
repo = ItemRepository.new
items = repo.list
items.length # =>  6

items[0].id # =>  '1'
items[0].item_name # =>  'Apple'
items[0].price # =>  90

items[1].id # =>  2
items[1].item_name # =>  'Banana'
items[1].price # =>  75

# 2
# repo = 
repo = ItemRepository.new
item = Item.new
item.item_name = 'Orange'
item.price = '80'

repo.create(item)

items = repo.all
new_entry = items.last
new_entry.item_name # => 'Orange'
new_entry.price # => '80'
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# file: spec/item_repository_spec.rb
def reset_items_table
  seed_sql = File.read('spec/seeds_items.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager' })
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
