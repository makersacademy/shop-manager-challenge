# Item Model and Repository Classes Design Recipe

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
TRUNCATE TABLE items RESTART IDENTITY CASCADE;
TRUNCATE TABLE orders RESTART IDENTITY CASCADE;
TRUNCATE TABLE items_orders RESTART IDENTITY CASCADE;

INSERT INTO items (name, price, quantity) VALUES 
('TV', 99.99, 5),
('Fridge', 80.00, 10);

INSERT INTO orders (customer, date) VALUES
('Rob', 'Jan-01-2022'),
('Tom', 'Jan-02-2022');

INSERT INTO items_orders (item_id, order_id) VALUES
(1, 1),
(1, 2),
(2, 1);
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

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, name, price, quantity FROM items WHERE id = $1;
    # Returns a single Item object.
  end

  def create(item)
    # Item is an instance of Item object
    # INSERT INTO items (name, price, quantity) VALUES ($1, $2, $3);
    # Returns nothing
  end

  def delete(id)
    # id is an integer
    # DELETE FROM items WHERE id = $1;
    # Returns nothing
  end

  def update(item)
    # Item is an instance of Item object
    # UPDATE items SET name = $1, price = $2, quantity = $3 WHERE id = $4;
    # Returns nothing
  end

  def find_with_order(item_id)
    # Executes the SQL query:
    # SELECT orders.id AS order_id,
    #        orders.customer,
    #        orders.date,
    #        items.id AS item_id,
    #        items.name,
    #        items.price,
    #        items.quantity
    # FROM items
    #   JOIN orders
    #   ON orders.item_id = items.id;
    # Returns an array of Item objects
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

items.length # => 3

items[0].id # => 1
items[0].name # => 'TV'
items[0].price # => 99.99
items[0].quantity # => 5

items[1].id # => 2
items[1].name # => 'Fridge'
items[1].price # => 80.00
items[1].quantity # => 10

# 2
# Get a single item

repo = ItemRepository.new

item = repo.find(1)

item.id # => 1
item.name # => 'TV'
item.price # => 99.99
item.quantity # => 5

# 3
# Create a single item

repo = ItemRepository.new
item = Item.new
item.name #=> 'Kettle'
item.price #=> 10.00
item.quantity #=> 13
repo.create(item)

all_items = repo.all
all_items.last.id #=> 4
all_items.last.name #=> 'Kettle'
all_items.last.price #=> 10.00
all_items.last.quantity #=> 13

# 4
# Delete a single item
repo = ItemRepository.new
repo.delete(2)
items = repo.all
items.length #=> 2
items[0].id #=> 1
items[1].id #=> 3

# 5
# Update a single item
repo = ItemRepository.new
item = repo.find(2)
item.price = 82.00
item.quantity = 9
repo.update(item)
item = repo.find(2)
item.name #=> "Fridge"
item.price # => 82.00
item.quantity # => 9
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/items_repository_spec.rb

def reset_items_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_inventory_test' })
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
