# Books Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).


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

TRUNCATE TABLE orders, items, items_orders RESTART IDENTITY;

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.
INSERT INTO items (name, unit_price, quantity) VALUES ('blueberries', '4', '30');
INSERT INTO items (name, unit_price, quantity) VALUES ('raspberries', '5', '20');
INSERT INTO items (name, unit_price, quantity) VALUES ('eggs', '2', '50');
INSERT INTO items (name, unit_price, quantity) VALUES ('milk', '1', '50');
INSERT INTO items (name, unit_price, quantity) VALUES ('cheese', '4', '20');
INSERT INTO items (name, unit_price, quantity) VALUES ('bread', '2', '100');
INSERT INTO items (name, unit_price, quantity) VALUES ('bananas', '3', '20');

INSERT INTO orders (customer_name, order_date) VALUES ('Harry Styles', '2022-03-10');
INSERT INTO orders (customer_name, order_date) VALUES ('Taylor Swift', '2022-04-14');
INSERT INTO orders (customer_name, order_date) VALUES ('Billie Ellish', '2022-05-21');
INSERT INTO orders (customer_name, order_date) VALUES ('Madison Beer', '2022-05-23');

INSERT INTO items_orders (item_id, order_id) VALUES (1, 1);
INSERT INTO items_orders (item_id, order_id) VALUES (2, 1);
INSERT INTO items_orders (item_id, order_id) VALUES (7, 1);
INSERT INTO items_orders (item_id, order_id) VALUES (5, 1);
INSERT INTO items_orders (item_id, order_id) VALUES (3, 2);
INSERT INTO items_orders (item_id, order_id) VALUES (4, 2);
INSERT INTO items_orders (item_id, order_id) VALUES (5, 2);
INSERT INTO items_orders (item_id, order_id) VALUES (5, 3);
INSERT INTO items_orders (item_id, order_id) VALUES (3, 4);
INSERT INTO items_orders (item_id, order_id) VALUES (6, 4);
INSERT INTO items_orders (item_id, order_id) VALUES (7, 4);

```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 shop_manager_test < seeds.sql
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
# Table name: item

# Model class
# (in lib/item.rb)

class Item
  attr_accessor :name, :unit_price, :quantity, :id, :orders

  def initialize
    @orders = []
  end
end

# Table name: order

# Model class
# (in lib/order.rb)

class Order
  attr_accessor :customer_name, :order_date, :id, :items

  def initialize
    @items = []
  end
end


# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# book = book.new
# book.name = 'Jo'
# book.name
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
  def all
  end

  def find(id)
  end

  def create(item)
  end

  def update_quantity(item)
  end

  def delete(id)
  end

  def find_by_order(order_customer_name)
  end
end

class OrderRepository
  def all
  end

  def create(order)
  end

  def find_by_item(item_name)
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# ITEMS EXAMPLES

# 1
# Get all items

repo = ItemRepository.new

items = repo.all

items.length # =>  7

items[0].id # =>  1
items[0].name # =>  'blueberries'
items[0].unit_price # =>  '4'
items[0].quantity # =>  '30'

# 2
# Find a singular item

repo = ItemRepository.new

item = repo.find(1)

item.name # => 'blueberries'
item.unit_price # => '4'
item.quantity # => '30'

# 3
# Add an item

repo = ItemRepository.new

item = Item.new
item.name = 'strawberries'
item.unit_price = '4'
item.quantity = '40'

repo.create(item)

items = repo.all
items.length # => 8
items.last.id # => '8'
items.last.name # => 'strawberries'

# 4
# Delete an item

repo = ItemRepository.new

id = 1

repo.delete(id)

items = repo.all
items.length # => 6
items.first.id # => '2'

# 5
# Update an item's quantity

repo = ItemRepository.new

item = repo.find(1)

item.quantity = "20"

repo.update_quantity(item)

updated_item = repo.find(1)

updated_item.quantity # => "20"

# 6
# Find item by order (find all the items in an order)

repo = ItemRepository.new

order = repo.find_by_order(1)
items = order.items

items.length # => 4

# ORDERS EXAMPLES

# 1
# Get all orders

repo = OrderRepository.new

orders = repo.all

orders.length # => 4

orders[0].id # =>  1
orders[0].customer_name # =>  'Harry Styles'
orders[0].order_date # =>  '2022-03-10'


# 2
# Find a singular order

repo = OrderRepository.new

order = repo.find(1)

order.customer_name # => 'Harry Styles'
order.order_date # => '2022-03-10'

# 3
# Add an order

repo = OrderRepository.new

order = Order.new
order.customer_name = 'Lizzy McAlpine'
order.order_date = '2022-08-08'

repo.create(order)

orders = repo.all
orders.length # => 5
orders.last.id # => '5'
orders.last.customer_name # => 'Lizzy McAlpine'

# 4
# find orders that include the item

repo = OrderRepository.new

item = repo.find_by_item(5)
orders = item.orders

orders.length # => 3



```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_items_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do
    reset_items_table
  end

  # (your tests will go here).
end

def reset_orders_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe OrderRepository do
  before(:each) do
    reset_orders_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._
