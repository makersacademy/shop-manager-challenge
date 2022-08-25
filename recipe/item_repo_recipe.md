# {{TABLE NAME}} Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## User stories and Terminal outputs
```
As a shop manager
So I can know which items I have in stock
I want to keep a list of my shop items with their name and unit price. < table

As a shop manager
So I can know which items I have in stock
I want to know which quantity (a number) I have for each item.

As a shop manager
So I can manage items
I want to be able to create a new item.

As a shop manager
So I can know which orders were made
I want to keep a list of orders with their customer name.

As a shop manager
So I can know which orders were made
I want to assign each order to their corresponding item.

As a shop manager
So I can know which orders were made
I want to know on which date an order was placed. 

As a shop manager
So I can manage orders
I want to be able to create a new order.
```

Here's an example of the terminal output your program should generate (yours might be slightly different — that's totally OK):

```
Welcome to the shop management program!

What do you want to do?
  1 = list all shop items
  2 = create a new item
  3 = list all orders
  4 = create a new order

1 [enter]

Here's a list of all shop items:

 #1 Super Shark Vacuum Cleaner - Unit price: 99 - Quantity: 30
 #2 Makerspresso Coffee Machine - Unit price: 69 - Quantity: 15
 (...)
```
## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
TRUNCATE TABLE items, orders, items_orders RESTART IDENTITY;

INSERT INTO items (item_name, item_price, item_quantity) VALUES 
('Smart Watch', '250.0', '60'),
('USB C to USB adapter', '8.99', '430'),
('Wireless Earbuds', '24.64', '34'),
('Shower Head and Hose', '16.99', '4');

INSERT INTO orders (customer_name, order_date) VALUES 
('Jimothy', '2022-05-07'),
('Nick', '2022-04-25');

INSERT INTO items_orders (item_id, order_id) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 2),
(1, 2);
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 shop_manager_test < items_orders_test.sql
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
  attr_accessor :item_name, :item_price, :item_quantity
  item_name, item_price, item_quantity
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
  def all
    # Executes the SQL query:
    # SELECT * FROM items;
    # Returns an array of item objects.
  end

  def create(item)
    # Insert an item object into the database
    # Executes the SQL query:
    # INSERT INTO items (item_name, item_price, item_quantity) VALUES ($1, $2, $3)
    # Returns nil
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

    items.length # =>  4

    items[0].id # =>  1
    items[0].item_name # =>  'Smart Watch'
    items[0].item_price # =>  '250.0'
    items[0].item_quantity # => '60

    items[1].item_name # =>  'USB C to USB adapter'
    items[1].item_price # =>  '8.99'
    items[1].item_quantity # => '430

# 2
# Create new item

    repo = ItemRepository.new

    item = Item.new
    item.item_name = 'Crisps'
    item.item_price = '0.99'
    item.item_quantity = '999'

    repo.create(item)
    all_items = repo.all
    all_items.length # => 5
    all_items.last.item_name # => 'Crisps'
    all_items.last.item_price # => '0.99'
    all_items.last.item_quantity # => '999'
# Add more examples for each method
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_students_table
  seed_sql = File.read('spec/seeds_students.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'students' })
  connection.exec(seed_sql)
end

describe StudentRepository do
  before(:each) do 
    reset_students_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._
