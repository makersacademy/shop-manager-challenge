# {{TABLE NAME}} Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `students`*

```
# Refer to tables_design.md

Table: orders

Columns:
id | customer | date

Table: items

Columns:
id | name | unit_price | quantity | order_id
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- (file: spec/seeds.sql)

TRUNCATE TABLE orders, items RESTART IDENTITY;

INSERT INTO orders (customer, date) VALUES ('Hana Holmens', '2022-07-10');
INSERT INTO orders (customer, date) VALUES ('Alfred Jones', '2022-08-15');

INSERT INTO items (name, unit_price, quantity, order_id) VALUES ('Ray chair', '499', '20', '1');
INSERT INTO items (name, unit_price, quantity, order_id) VALUES ('Mags sofa', '5800', '45', '2');
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# Table name: orders

# Model class
# (in lib/order.rb)
class Order
end

# Repository class
# (in lib/order_repository.rb)
class OrderRepository
end

# Table name: item

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
# Table name: orders

# Model class
# (in lib/order.rb)

class Order
  attr_accessor :id, :customer, :date
end

# Table name: items

# Model class
# (in lib/item.rb)

class Item
  attr_accessor :id, :name, :unit_price, :quantity, :order_id
end
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# Table name: orders

# Repository class
# (in lib/order_repository.rb)

class OrderRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT * FROM orders;
*
    # Returns an array of Order objects.
  end

  # Ceates a new order
  # One argument: an Order object
  def create(order)
    # Executes the SQL query:
    # INSERT INTO orders (customer, date) VALUES ($1, $2);

    # Returns nothing
  end
end

# Table name: items

# Repository class
# (in lib/item_repository.rb)

class ItemRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT * FROM items;
*
    # Returns an array of Item objects.
  end

  # Ceates a new item
  # One argument: an Item object
  def create(item)
    # Executes the SQL query:
    # INSERT INTO items (name, unit_price, quantity, order_id) VALUES ($1, $2, $3, $4);

    # Returns nothing
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# OrderRepository
# 1
# Get all orders

repo = OrderRepository.new

orders = repo.all

orders.length # => 2
orders[0].id # => '1'
orders[0].customer # => 'Hana Holmens'
orders[0].date # => '2022-07-10'

# 2
# Create a new order

repo = OrderRepository.new

order = Order.new
order.customer = 'Mike Anderson'
order.date = '2022-06-23'

repo.create(order)

all_orders = repo.all
all_orders.last.id # => '3'
all_orders.last.customer # => 'Mike Anderson'
all_orders.last.date # => '2022-06-23'

# ItemRepository
# 1
# Get all items

repo = ItemRepository.new

items = repo.all

items.length # => 2
items[0].id # => '1'
items[0].name # => 'Ray chair'
items[0].unit_price # => '499'
items[0].quantity # => '20'
items[0].order_id # => '1'

# 2
# Create a new item

repo = ItemRepository.new

item = Item.new
item.name = 'Kofi coffee table'
item.unit_price = '455'
item.quantity = '80'
item.order_id = '2'

repo.create(item)

all_items = repo.all
all_items.last.id # => '3'
all_items.last.name # => 'Kofi coffee table'
all_items.last.unit_price # => '455'
all_items.last.quantity # => '80'
all_items.last.order_id # => '2'
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# file: spec/order_repository_spec.rb

def reset_orders_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

RSpec.describe OrderRepository do
  before(:each) do 
    reset_orders_table
  end

  # (your tests will go here).
end

# file: spec/item_repository_spec.rb

def reset_items_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_shop_manager_test' })
  connection.exec(seed_sql)
end

RSpec.describe ItemRepository do
  before(:each) do 
    reset_items_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._