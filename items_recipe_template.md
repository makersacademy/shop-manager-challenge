# Items Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `students`*

```
# EXAMPLE

Table: items

Columns:
id | item_name | unit_price | quantity | order_id
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

INSERT INTO items (item_name, unit_price, quantity, order_id) VALUES ('Super Shark Vacuum Cleaner', '99', '30', '002');
INSERT INTO items (item_name, unit_price, quantity, order_id) VALUES ('Makerspresso Coffee Machine', '69', '15', '002');
INSERT INTO items (item_name, unit_price, quantity, order_id) VALUES ('Amazon Echo Device', '100', '33','001');
INSERT INTO items (item_name, unit_price, quantity, order_id) VALUES ('Apple TV', '150', '20', '003');
INSERT INTO items (item_name, unit_price, quantity, order_id) VALUES ('Samsung TV', '1000', '10', '004');
INSERT INTO items (item_name, unit_price, quantity, order_id) VALUES ('HP Laptop', '400', '17', '005');
INSERT INTO items (item_name, unit_price, quantity, order_id) VALUES ('SKY Broadband', '100', '13', '7');
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 shop_manger_test < seeds_{items}.sql
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
  attr_accessor :item_name, :unit_price, :quantity, :order_id
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# item = Item.new
# item.item_name = 'Apple Iphone'

```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: students

# Repository class
# (in lib/student_repository.rb)

class ItemRepository

  # Selecting all items
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, item_name, unit_price, quantity, order_id FROM items;

    # Returns an array of Item objects.
  end

# Creates a new item
# No arguments
def create(item)

  # Executes the SQL query:
    # INSERT INTO items (id, item_name, unit_price, quantity, order_id) VALUES ($1, $2, $3, $4)

    # Does not returns anything.

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

items[0].item_name # =>  'Super Shark Vacuum Cleaner'
items[0].unit_price # =>  '99'
items[0].quantity # =>  '30'
items[0].order_id # =>  '1'

items[1].name # =>  'Makerspresso Coffee Machin'
items[1].unit_price # =>  '69'
items[1].quantity # =>  '15'
items[1].order_id # =>  2'

# 2
# Create a new item

repo = ItemRepository.new

new_item = Item.new
        
    new_item.item_name = 'LG TV'
    new_item.unit_price = '2000'
    new_item.quantity = '7'
    new_item.order_id = '2'

repo.create(new_item) # => nil

repo.all.length # => 7
repo.all.last.item_name # => 'LG TV'
repo.all.last.unit_price # => '2000'
repo.all.last.quantity # => '7'
repo.all.last.order_id # => '2'

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

<!-- BEGIN GENERATED SECTION DO NOT EDIT -->

---

<!-- END GENERATED SECTION DO NOT EDIT -->