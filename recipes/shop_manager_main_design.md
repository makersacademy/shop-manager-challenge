# Shop Manager Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

Please refer to the shop_manager_table_design.sql in the recipes directory.

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- Combined SQL seeds for orders, items, and order_items tables

TRUNCATE TABLE items, orders, order_items RESTART IDENTITY;

-- Insert sample data into the items table
INSERT INTO items (name, unit_price, quantity) VALUES
  ('CPU', 199.99, 10),
  ('GPU', 499.99, 5);

-- Insert sample data into the orders table
INSERT INTO orders (customer_name, order_date) VALUES
  ('Joe Hannis', '2023-05-25'),
  ('Sean Peters', '2023-05-26');

-- Insert sample data into the order_items table
INSERT INTO order_items (order_id, item_id) VALUES
  (1, 1),
  (1, 2),
  (2, 1);
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_shop_manager.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby

#--------------------------------------------
# Table name: items

# Model class
# (in lib/item.rb)
class Item
end

# Repository class
# (in lib/item_repository.rb)
class ItemRepository
end

#-----------------------------------------
# Table name: orders

# Model class
# (in lib/order.rb)
class Order
end

# Repository class
# (in lib/order_repository.rb)
class OrderRepository
end

#--------------------------------------------
# Table name: order_items

# Model class
# (in lib/order_item.rb)
class OrderItem
end

# Repository class
# (in lib/order_item_repository.rb)
class OrderItemRepository
end

```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# Table name: items

# Model class
# (in lib/item.rb)
class Item
  attr_accessor :id, :name, :unit_price, quantity
end

# Table name: orders

# Model class
# (in lib/order.rb)
class Order
  attr_accessor :id, :customer_name, :order_date
end

# Table name: order_items

# Model class
# (in lib/order_item.rb)
class OrderItem
  attr_accessor :id, :order_id, :item_id
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

  # Selecting all items
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, unit_price, quantity FROM items;
    # Returns an array of Item objects.
  end

  def find(id)
    # id is an integer representing the item ID to search for
    # SELECT name, unit_price, quantity FROM items WHERE id = $1;
    # Returns an instance of Item object
  end

end

# Repository class
# (in lib/order_repository.rb)

class OrderRepository

  # Selecting all orders
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, customer_name, order_date FROM orders;
    # Returns an array of Order objects.
  end

  def find(id)
    # id is an integer representing the order ID to search for
    # SELECT customer_name, order_date FROM orders WHERE id = $1;
    # Returns an instance of Order object
  end

  def create(order)
    # Executes the SQL query;
    # INSERT INTO orders (customer_name, order_date) VALUES ($1, $2);
    # Doesn't need to return anything
  end

end

class OrderItemRepository

  def find(order_id, item_id)
    # order_id and item_id are integers representing the order and item IDs to search for
    # SELECT order_id, item_id FROM order_items WHERE order_id = $1 AND item_id = $2;
    # Returns an instance of OrderItem object
  end

  def update(item_id, item)
    # Executes the SQL query;
    # UPDATE items SET name = $1, unit_price = $2, quantity = $3 WHERE id = $4;

    # The values $1, $2, $3, and $4 are placeholders for the actual values to be updated in the query.
    # The values are typically obtained from the `item` object, such as `item.name`, `item.unit_price`, `item.quantity`.

    # Returns nothing (only updates the record)
  end

  def delete(order_id, item_id)
    # Executes the SQL;
    # DELETE FROM order_items WHERE order_id = $1 AND item_id = $2;
    # Returns nothing (only deletes the record)
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

item_repo = ItemRepository.new

items = item_repo.all
items.length # => 2
items.first.name # => 'CPU'
items.first.unit_price # => 199.99
items.first.quantity # => 10

# 2
# Find item with id 2

item_repo = ItemRepository.new

item = item_repo.find(2)
item.name # => 'GPU'
item.unit_price # => 499.99
item.quantity # => 5

# 3
# Create a new item

item_repo = ItemRepository.new

new_item = Item.new
new_item.name = 'Keyboard'
new_item.unit_price = 59.99
new_item.quantity = 8

item_repo.create(new_item)

all_items = item_repo.all
last_item = all_items.last
last_item.name # => 'Keyboard'
last_item.unit_price # => 59.99
last_item.quantity # => 8

# OrderRepository and OrderItemRepository examples can be similarly updated based on the planned methods and classes.

```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/account_repository_spec.rb

def reset_shop_manager_table
  seed_sql = File.read('spec/seeds_shop_manager.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end


  before(:each) do 
    reset_shop_manager_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._
