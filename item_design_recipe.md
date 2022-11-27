# {{TABLE NAME}} Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `students`*

```
# EXAMPLE

Table: students

Columns:
id | name | cohort_name
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_shop.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE items RESTART IDENTITY CASCADE; -- replace with your own table name.
TRUNCATE TABLE orders RESTART IDENTITY CASCADE;

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO items (name, unit_price, quantity) VALUES ('Computer', 500, 20);
INSERT INTO items (name, unit_price, quantity) VALUES ('Phone', 599, 79);
INSERT INTO items (name, unit_price, quantity) VALUES ('TV', 150, 200);
INSERT INTO items (name, unit_price, quantity) VALUES ('Shoes', 30, 250);
INSERT INTO items (name, unit_price, quantity) VALUES ('Basket', 5, 150);

INSERT INTO orders (customer_name, order_date) VALUES ('David', '2022-01-10');
INSERT INTO orders (customer_name, order_date) VALUES ('Anna', '2022-01-11');
INSERT INTO orders (customer_name, order_date) VALUES ('Max', '2022-01-15');

INSERT INTO items_orders (item_id, order_id) VALUES (1, 1);
INSERT INTO items_orders (item_id, order_id) VALUES (1, 2);
INSERT INTO items_orders (item_id, order_id) VALUES (2, 3);
INSERT INTO items_orders (item_id, order_id) VALUES (3, 2);
INSERT INTO items_orders (item_id, order_id) VALUES (3, 1);
INSERT INTO items_orders (item_id, order_id) VALUES (4, 1);
INSERT INTO items_orders (item_id, order_id) VALUES (4, 2);
INSERT INTO items_orders (item_id, order_id) VALUES (5, 3);
INSERT INTO items_orders (item_id, order_id) VALUES (5, 2);
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 shop < seeds_items.sql
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
  attr_accessor :id, :name, :unit_price, :quantity
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
    # SELECT * FROM items;

    # Returns an array of Item objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT * FROM items WHERE id = $1;

    # Returns a single Item object.
  end

  def find_by_order(id)
  # Executes the SQL query:
  # SELECT * FROM items JOIN items_orders ON items.id = items_orders.item_id JOIN orders ON items_orders.order_id = orders.id WHERE orders.id = $1;

  # Returns an array of Item objects from a single order
  end

  # Add more methods below for each operation you'd like to implement.

  def create(item)
  # user inputs item name, price, quantity
  # Executes the SQL query:
  # INSERT INTO items (name, unit_price, quantity) VALUES ($1, $2, $3);

  # Returns nothing

  end

  def update(item)
  # user item name, price, quantity

  # Executes the SQL query:
  # UPDATE items SET name = $1, price = $2, quantity = $3 WHERE id = $4;

  # Returns nothing
  end

  def delete(id)
  # Executes the SQL query:
  # DELETE FROM items WHERE id = $1;

  # Returns nothing
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

items.length # =>  5

items[0].id # =>  1
items[0].name # =>  'Computer'
items[0].unit_price # =>  500

items[4].id # =>  5
items[4].name # =>  'Basket'
items[4].quantity # =>  150

# 2
# Get a single item

repo = ItemRepository.new

item = repo.find(3)

item.id # =>  3
item.name # =>  'TV'
item.unit_price # =>  150
item.quantity # => 200

# 3
# Get all items from a single order

repo = ItemRepository.new

items = repo.find_by_order(2)

items.length # => 4
items[0].id # => 1
items[1].name # => 'TV'
items[2].unit_price # => 30
items.last.quantity # => 150

# 4
# Add an item

repo = ItemRepository.new

item = Item.new
item.name = 'Coat'
item.unit_price = 50
item.quantity = 10

repo.create(item)

item = repo.find(6)

item.name # => 'Coat'
item.unit_price # => 50

# 5
# Update an item

repo = ItemRepository.new

item = repo.find(1)

item.price = 400
item.quantity = 15

repo.update(item)

repo.find(1)

repo.name # => 'Computer'
repo.price # => 400
repo.quantity # => 15

# 6
# Delete an item

repo = ItemRepository.new

repo.delete(5)

items = repo.all

items.length # => 4
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