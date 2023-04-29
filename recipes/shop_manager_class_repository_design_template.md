# {{shop_manager}} Model and Repository Classes Design Recipe

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
-- (file: spec/seeds_shop_manager.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE items RESTART IDENTITY CASCADE; -- replace with your own table name.


-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO items (name, unit_price, stock_quantity) VALUES ('Coffee Machine', '99', '7');
INSERT INTO items (name, unit_price, stock_quantity) VALUES ('Vacuum Cleaner', '125', '42');
INSERT INTO items (name, unit_price, stock_quantity) VALUES ('Curtain', '34', '205');

INSERT INTO orders (customer_name, date, item_id) VALUES ('Andrea', '2023-01-18', '1');
INSERT INTO orders (customer_name, date, item_id) VALUES ('Céline', '2023-03-14', '2');
INSERT INTO orders (customer_name, date, item_id) VALUES ('Chiara', '2023-04-19', '3');


```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_shop_manager.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: students

# Model class
# (in lib/item.rb)
class Item
end

# Repository class
# (in lib/item_repository.rb)
class ItemRepository
end

---------------------

# Model class
# (in lib/order.rb)
class Order
end

# Repository class
# (in lib/order_repository.rb)
class OrderRepository
end


```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: items

# Model class
# (in lib/items.rb)

class Item

  # Replace the attributes by your own columns.
  attr_accessor :name, :unit_price, :stock_quantity
end

--------------

# EXAMPLE
# Table name: order

# Model class
# (in lib/order.rb)

class Order

  # Replace the attributes by your own columns.
  attr_accessor :customer_name, :date, :item_id
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
    # SELECT id, name, unit_price, stock_quantity FROM items;

    # Returns an array of Items objects.
  end

  # Creates a new item
  # Three arguments: name, unit_price, stock_quantity
  def create(name, unit_price, stock_quantity)
    # Executes the SQL query:
    # INSERT INTO items (name, unit_price, stock_quantity) VALUES ($1, $2, $3);

    # puts "Item added." to the terminal
  end
end

# Table name: orders

# Repository class
# (in lib/order_repository.rb)

class OrderRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, customer_name, date, item_id, FROM orders;

    # Returns an array of Orders objects.
  end

  # Creates a new order
  # Three arguments: customer_name, date, item_id
  def create(customer_name, date, item_id)
    # Executes the SQL query:
    # INSERT INTO orders (customer_name, date, item_id) VALUES ($1, $2, $3);

    # puts "Order added." to the terminal
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# TESTS FOR ITEMS

# 1
# Get all items

repo = ItemRepository.new

items = repo.all

items.length # =>  3

items[0].id # =>  1
items[0].name # =>  'Coffee Machine'
items[0].unit_price # =>  '99'
items[0].stock_quantity # =>  '7'
#item 3
items[2].id # =>  3
items[2].name # =>  'Curtain'
items[2].unit_price # =>  '34'
items[2].stock_quantity # =>  '205'

# 2
# Add a new item

repo = ItemRepository.new
repo.create('Table', '147', '21')
items = repo.all
items.length # =>  4

-------------------------
# TESTS FOR ORDERS

# 1
# Get all orders

repo = OrderRepository.new

orders = repo.all

orders.length # =>  3

orders[0].id # =>  1
orders[0].customer_name # =>  'Andrea'
orders[0].date # =>  '2023-01-18'
orders[0].item_id # =>  '1'
#item 3
orders[1].id # =>  2
orders[1].customer_name # =>  'Céline'
orders[1].date # =>  '2023-03-14'
orders[1].item_id # =>  '2'

# 2
# Add a new order of a Coffee Machine

repo = OrderRepository.new
repo.create('Ilaria', '2023-04-29', '1')
orders = repo.all
orders.length # =>  4


# Add more examples for each method
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/item_repository_spec.rb

def reset_items_and_orders_tables
  seed_sql = File.read('spec/seeds_shop_manager.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe StudentRepository do
  before(:each) do 
    reset_items_and_orders_tables
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._

<!-- BEGIN GENERATED SECTION DO NOT EDIT -->

---

**How was this resource?**  
[😫](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😫) [😕](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😕) [😐](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😐) [🙂](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=🙂) [😀](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😀)  
Click an emoji to tell us.

<!-- END GENERATED SECTION DO NOT EDIT -->