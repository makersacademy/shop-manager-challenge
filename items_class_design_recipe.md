# Items Model and Repository Classes Design Recipe


## 1. Design and create the Table


```
# EXAMPLE

Table: items

| Record                | Properties                         |
| --------------------- | ---------------------------------- |
| item                  | name, unit_price, stock_quantity   |
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

INSERT INTO items (name, unit_price, stock_quantity ) VALUES ('Super Shark Vacuum Cleaner', 99, 30 );
INSERT INTO items (name, unit_price, stock_quantity ) VALUES ('Makerspresso Coffee Machine', 69, 15);
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 shop_manager_test < spec/seeds_items.sql;
```
This was created from the terminal within the directory containing the database file

## 3. Define the class names

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


```ruby
# Table name: items

# Model class
# (in lib/item.rb)

class Item

  attr_accessor :id, :name, :unit_price, :stock_quantity
end


```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface


```ruby
# Table name: items

# Repository class
# (in lib/item_repository.rb)

class ItemRepository

  
  def all
    
  end

  def find(id)
    
  end

  def create(item)
    
  end

  def delete(id)
    
  end

  def update(item)
    
  end
end
```

## 6. Write Test Examples


```ruby
# 1
# Get all items
repo = ItemRepository.new

items = repo.all
expect(items.size).to eq 2
expect(items.first.id).to eq '1'
expect(items.first.name).to eq 'Super Shark Vacuum Cleaner'
expect(items.first.unit_price).to eq '99'
expect(items.first.stock_quantity).to eq '30'

# 2
# Find item by id

repo = ItemRepository.new
item = repo.find(1)
expect(item.id).to eq '1'
expect(item.name).to eq 'Super Shark Vacuum Cleaner'
expect(item.unit_price).to eq '99'
expect(item.stock_quantity).to eq '30'

# 3
# Create a new item

repo = ItemRepository.new
add_item = Item.new
add_item.name, add_item.unit_price, add_item.stock_quantity = 'Fight Milk', 19, 2
repo.create(add_item)
items = repo.all
new_item = items.last
expect(new_item.id).to eq '3'
expect(new_item.name).to eq 'Fight Milk'
expect(new_item.unit_price).to eq '19'
expect(new_item.stock_quantity).to eq '200'

# 4 
# Delete an item with the id as input

repo = ItemRepository.new
repo.delete(1)
items = repo.all
first_item = items.first
expect(first_item.id).to eq '2'
expect(first_item.name).to eq 'Makerspresso Coffee Machine'
expect(first_item.unit_price).to eq '69'
expect(first_item.stock_quantity).to eq '15'

# 5 
# Update an item with the id as input

repo = ItemRepository.new
original_item = repo.find(1)
original_item.name, original_item.unit_price, original_item.stock_quantity = 
  'New Hoover', 149, 100
repo.update(original_item)
updated_item = repo.find(1)
expect(updated_item.id).to eq '1'
expect(updated_item.name).to eq 'New Hoover'
expect(updated_item.unit_price).to eq '149'
expect(updated_item.stock_quantity).to eq '100'
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/BLANK_repository_spec.rb

RSpec.describe ItemRepository do
  def reset_items_table 
    seed_sql = File.read('spec/seeds_items.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end  

  before(:each) do
    reset_items_table
  end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._