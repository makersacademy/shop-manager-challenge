# {{Items}} Model and Repository Classes Design Recipe

Table: items
id: SERIAL
name: text
price: int
quantity: int

## 1. Design and create the Table

As a shop manager
So I can know which items I have in stock
I want to **keep a list of my shop items** with their name and unit price.

As a shop manager
So I can know which items I have in stock
I want to know which quantity (a number) I have for each item.

As a shop manager
So I can manage items
I want to be able to **create** a new item.


Table: items
id: SERIAL
name: text
price: int
quantity: int

## 2. Create Test SQL seeds


```sql
TRUNCATE TABLE items, order, items_orders RESTART IDENTITY; 

INSERT INTO items (name, price, quantity) VALUES 
('item_one', 1, 1),
('item_two', 2, 2),
('item_three', 3, 3),
('item_four', 4, 4),
('item_five', 5, 5);

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
# Model class
# (in lib/item.rb)

class Item


  attr_accessor :id, :price, :quantity
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
    # SELECT * FROM items;

    # Returns an array of Item objects.
  end

# Creating a new item
  def create(item) # item is an instance of the Item class
    # Executes the SQL query:
    # INSERT INTO items (name, price, quantity) VALUES ($1, $2, $3);  
    returns nil
  end

end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# 1 

repo = ItemRepository.new

items = repo.all

item.first.id # => 1
item.first.name # => 'item one'
item.first.price # => 1
item.first.quantity # => 1

item.last.id # => 5
item.last.name # => 'item five'
item.last.price # => 5
item.last.quantity # => 5


# 2 

repo = ItemRepository.new
new_item = Item.new

new_item.name = 'new item'
new_item.price = 6
new_item.quantity = 6

repo.create(new_item)

inventory = repo.all

inventory.length # => 6
inventory.last.id # => 6


```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/item_repository-spec.rb

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