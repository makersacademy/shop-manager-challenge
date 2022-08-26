# Items & Orders Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
TRUNCATE TABLE items, orders RESTART IDENTITY;

INSERT INTO items (name, unit_price, quantity) VALUES ('iPhone', 20, 5);
INSERT INTO items (name, unit_price, quantity) VALUES ('Tv', 50, 10);
INSERT INTO items (name, unit_price, quantity) VALUES ('Apple', 10, 8);


INSERT INTO orders (customer_name, date, item_id) VALUES ('Penaldo', '2022-03-01', 1);
INSERT INTO orders (customer_name, date, item_id) VALUES ('Penzema', '2022-12-04', 2);
INSERT INTO orders (customer_name, date, item_id) VALUES ('Messi', '2022-10-06', 3);
  
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE

# Model classes
class Order

end

# Model class
class Item

end

# Repository classes
class OrderRepository

end

class ItemRepository

end

```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE

# Model classes
class Item
 attr_accessor :id, :name, :unit_price, :quantity
  
  def initialize(name, unit_price, quantity)
  end
end

class Order
  attr_accessor :id, :customer_name, :date, :item_id

  def initialize(customer_name, date, item_id)
  end
end

```

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE

# Repository classes
class ItemRepository

  # Selecting all records
  def all
    # SELECT id, name, price, quantity FROM orders;
  end

   def create(item)
   # returns nothing
   end
end

class OrderRepository
  def all
  #  sql = 'SELECT * FROM orders;'
  end

   def create(order)
    #  sql = 'INSERT INTO orders (customer_name, date, item_id)
   end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# Returns all item records
repository = ItemRepository.new
items = repository.all

items.length # 3

items[0].id # 1
items[0].name # 'iPhone'
items[0].unit_price # 20
items[0].quantity # 5

items[1].id # 2
items[1].name # 'Tv'
items[1].unit_price # 50
items[1].quantity # 10

items[2].id # 3
items[2].name # 'Apple'
items[2].unit_price # 10
items[2].quantity # 8

# 1. Get all order
repo = OrderRepository.new
orders = repo.all

orders[0].id => 1
orders[0].customer_name => "Penaldo"
orders[0].order_date => '2022-12-13'
orders[0].item_id => 1

orders[1].id => "2"
orders[1].customer_name => "Penzema"
orders[1].order_date => '2022-08-08'
orders[1].item_id => 2

# 2. Creates a new order
repo = OrderRepository.new
order = Order.new
order.customer_name = "Messi"
order.order_date = "1999-03-15"
order.item_id = 2
repo.create(order)

orders = repo.all

orders[0].id => 1
orders[0].customer_name => "Penaldo"
orders[0].order_date => '2022-12-13'
orders[0].item_id => 1

orders[1].id => "2"
orders[1].customer_name => "Penzema"
orders[1].order_date => '2022-08-08'
orders[1].item_id => 2


orders[2].id => 3
orders[2].customer_name => "Messi"
orders[2].order_date => "1999-03-15"
orders[2].item_id => 2

# Integration Testing

# 1. Creates a new item record
repository = ItemRepository.new
item = Item.new("Chair", '15', '4')
repository.create(item)

all_items = repository.all
last = all_items.last
last.name # 'Chair'
last.unit_price # 15
last.quantity # 4


# 2. Creates a new order record
repository = OrderRepository.new
order = Order.new('Pepsi', '2012-12-12', '3')
repository.create(order)

all_orders = repository.all
last = all_orders.last
last.customer_name # 'Pepsi'
last.date # '2012-12-12'
last.id # 4
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

def reset_tables
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

  before(:each) do 
    reset_tables
  end

```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._

