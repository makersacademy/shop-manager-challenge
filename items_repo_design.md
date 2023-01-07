# Items Model and Repository Classes Design Recipe

## 1. Design and create the Table

```
Table: items

Columns:
id | name | price | quantity
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

TRUNCATE TABLE items, orders RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO items (name, price, quantity) VALUES ('Mustang', 47630, 200);
INSERT INTO items (name, price, quantity) VALUES ('Fiesta', 19060, 600);
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_items.sql
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

    # Returns an array of Item objects.
  end
  def create(item)
    # Executes SQL query;
    # INSERT INTO items (name, price, quantity) VALUES ($1, $2, $3)
    # Nothing returned
  end

  def find(id)
    # Executes SQL query;
    # SELECT id, name, price, quantity FROM items WHERE id = $1;
    # Item returned
  end

  def update(id, column, new_input)
    # Executes SQL query 
    # UPDATE items SET $1 = $2 WHERE id = $3
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

expect(items.length).to eq(2)

expect(items[0].id).to eq(1)
expect(items[0].name).to eq 'Mustang'
expect(items[0].price).to eq 47630
expect(items[0].quantity).to eq 200

expect(items[1].id).to eq(2)
expect(items[1].name).to eq 'Fiesta'
expect(items[1].price).to eq 19060
expect(items[1].quantity).to eq 600

# 2
# Create an item 

repo = ItemRepository.new

new_item = Item.new
new_item.name = 'Focus'
new_item.price = 26040
new_item.quantity = 350
repo.create(new_item)
expect(repo.all).to include(
  have_attributes(name: 'Focus', price: 26040, quantity: 350)
)

# 3 
# Find an item

repo = ItemRepository.new

expect(repo.find(1)).to include(
  have_attributes(id: 1, name: 'Mustang', price: 47630, quantity: 200)
)

# 4 
# Update an item

repo = ItemRepository.new
repo.update(1, quantity, 1)
expect(repo.find(1)).to include(
  have_attributes(id: 1, name: 'Mustang', price: 47630, quantity: 199)
)

# Add more examples for each method
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