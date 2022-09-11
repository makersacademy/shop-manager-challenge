# Book store shop manager Model and Repository Classes Design Recipe

## 1. Design and create the Table

```

| Record                | Properties          |
| --------------------- | ------------------  |
| item                  | name, price, quantity
| order                 | customer, date
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- (file: spec/seeds_items_orders.sql)

TRUNCATE TABLE items, orders, items_orders RESTART IDENTITY; 

INSERT INTO items (name, price, quantity) VALUES ('1984', '9.99', '54');
INSERT INTO items (name, price, quantity) VALUES ('War and peace', '7.99', '14');

INSERT INTO orders (customer, date) VALUES ('Anna', '2022, 08, 15');
INSERT INTO orders (customer, date) VALUES ('David', '2022, 08, 23');

INSERT INTO items_orders (item_id, order_id) VALUES (1, 1);
INSERT INTO items_orders (item_id, order_id) VALUES (1, 2);
INSERT INTO items_orders (item_id, order_id) VALUES (2, 1);
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 book_store_solo_test < seeds_items_orders.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

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

# Table name: orders

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
# Table name: item

# Model class
# (in lib/item.rb)
class Item
  attr_accessor :id, :name, :price, :quantity, :orders
end

# Table name: order

# Model class
# (in lib/order.rb)
class Order
  attr_accessor :id, :customer, :date, :items
end
```

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
    # SELECT id, name, price, quantity FROM items;

    # Returns an array of Item objects.
  end

  def create(item)
    # Executes the SQL query:
    # INSERT INTO items (id, name, price, quantity) VALUES ('Pride and prejudice', 8.99, 26);

    # Returns nothing
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
    # SELECT id, customer, date, quantity FROM orders;

    # Returns an array of Order objects.
  end

   def all_with_items
    # Executes the SQL query:
    # SELECT id, customer, date, items FROM orders;

    # Returns an array of Item objects with its items.
  end

  def create(order)
    # Executes the SQL query:
    # INSERT INTO orders (id, customer, date, items) VALUES ('Chris', '2022, 08, 27', ['2']);

    # Returns nothing
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby

# 1
# Get all items

repo = ItemRepository.new

items = repo.all

items.length # =>  2

items[0].id # =>  '1'
items[0].name # =>  '1984'
items[0].price # =>  '9.99'
items[0].quantity # =>  '54'

items[1].id # =>  '1'
items[1].name # =>  'War and peace'
items[1].price # =>  '7.99'
items[1].quantity # =>  '14'

# 2
# Create a single item

repo = ItemRepository.new

item_new = Item.new
item_new.name #=> 'Pride and prejudice'
item_new.price # =>  '8.99'
item_new.quantity # =>  '26'

repo.create(item_new)

repo_updated.all.length # =>  3
repo_updated.all[2].name # => 'Pride and prejudice'
repo_updated.all[2].price # => '8.99'
repo_updated.all[2].quantity # => '26'


# 3
# Get all orders

repo = OrderRepository.new

orders = repo.all

orders.length # =>  2

orders[0].id # =>  '1'
orders[0].customer # =>  'Anna'
orders[0].date # =>  '2022-08-15'

orders[1].id # =>  '1'
orders[1].customer # =>  'David'
orders[1].date # =>  '2022-08-23'

# 4
# Create a single order

repo = OrderRepository.new

order_new = Order.new
order_new.customer = 'Chris'
order_new.date = '2022, 08, 27'

repo.create(order_new)

repo_updated.all.length # =>  3
repo_updated.all[2].customer # => 'Chris'
repo_updated.all[2].date # => '2022, 08, 27'
repo_updated.all[2].items # => ['2']
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/item_repository_spec.rb

def reset_items_orders_table
  seed_sql = File.read('spec/seeds_items_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'book_store_solo_test' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_items_orders_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._