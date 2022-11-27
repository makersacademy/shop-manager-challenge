# Shop Manager Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).


```

Table: items

Columns:
id | name | unit_price| quantity

Table: orders

Columns:
id |  customer_name | order_date | item_id


```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql


TRUNCATE TABLE items RESTART IDENTITY CASCADE; 

INSERT INTO items (name, unit_price, quantity) VALUES ('item 1', 1.11, 1);
INSERT INTO items (name, unit_price, quantity) VALUES ('item 2', 22.22, 22);
INSERT INTO items (name, unit_price, quantity) VALUES ('item 3', 333.33, 333);
INSERT INTO items (name, unit_price, quantity) VALUES ('item 4', 4444.44, 444);

INSERT INTO orders (customer_name, order_date, item_id) VALUES ('customer 1', '2022-01-25', 1);
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('customer 2', '2022-12-01', 2);
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('customer 3', '2021-01-03', 2);
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('customer 4', '2022-03-19', 3);
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('customer 5', '2022-02-01', 1);
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('customer 6', '2021-04-03', 3);
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('customer 7', '2022-05-30', 1);
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('customer 8', '2022-11-25', 4);



```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 shop_manager_test < spec/seeds_shop_manager.sql
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
# Table name: students

# Model class
# (in lib/item.rb)

class Item
  # Replace the attributes by your own columns.
  attr_accessor :id, :name, :unit_price, :quantity
end

# Model class
# (in lib/order.rb)

class Order
  # Replace the attributes by your own columns.
  attr_accessor :id, :customer_name, :order_date, :item_id
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# student = Student.new
# student.name = 'Jo'
# student.name
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
    # SELECT id, name, unit_price, quantity FROM items;

    # Returns an array of Item objects.
  end

  # Insert new item 
  # item is a new Item object
  def create(item)
    # Executes the SQL query:

    # INSERT INTO albums (name, unit_price, quantity) VALUES($1, $2, $3);
    # Doesn't need to return anything (only creates a record)
  end

end

# Table name: orders


# Repository class
# (in lib/order_repository.rb)

class OrderRepository

  # Selecting all records with item name
  # No arguments
  def all
    # Executes the SQL query:
    #     SELECT 	orders.id AS order_id,
    # 	orders.customer_name,
    # 	orders.order_date,
    # 	items.id AS item_id,
    # 	items.name AS item_name,
    # FROM orders
    # JOIN items 
    # ON items.id = orders.item_id; 


    # Returns an array of Order objects.
  end

  # Insert new order 
  # item is a new Order object
  def create(order)
    # Executes the SQL query:

    # INSERT INTO albums (customer_name, order_date, item_id) VALUES($1, $2, $3);
    # Doesn't need to return anything (only creates a record)
  end

end

```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# Repository class
# (in lib/item_repository.rb)

# 1
# Get all items

repo = ItemRepository.new

items = repo.all

items.length # =>  4

items[0].id # =>  1
items[0].name # =>  'item 1'
items[0].unit_price # =>  1.11
items[0].quantity # =>  1

items[0].id # =>  2
items[0].name # =>  'item 2'
items[0].unit_price # =>  22.22
items[0].quantity # =>  22

# 2 Creates a new item

repository = ItemRepository.new

item = Item.new
item.name = 'item 5'
item.unit_price = 55555.55
item.quantity = 5

repository.create(item) # => nil

all_items = repository.all
last_item = all_items.last

last_item.name # => 'item 5'
last_item.unit_price # => 55555.55
last_item.quantity # => 5

# 3 Raises error when unit price is not money

repository = ItemRepository.new

item = Item.new
item.name = 'item 5'
item.unit_price = 'item 5'
item.quantity = 5

repository.create(item) # => raises error

# 4 Raises error when quanity is not int

repository = ItemRepository.new

item = Item.new
item.name = 'item 5'
item.unit_price = 55555.55
item.quantity = 'item 5'



# Repository class
# (in lib/order_repository.rb)

# 1
# Get all items with item name

repo = OrderRepository.new

orders = repo.all

orders.length # =>  8

orders[0].id # =>  1
orders[0].customer_name # =>  'customer 1'
orders[0].order_date # =>  '2022-01-25'
orders[0].item_id # =>  1
orders[0].item_name # =>  'item 1'

# 2 Creates a new item

repository = OrderRepository.new

order = Order.new
order.customer_name = 'customer 9'
order.order_date = '2022-01-25'
order.item_id = 1

repository.create(order) # => nil

all_items = repository.all
last_order= all_items.last
last_order.customer_name # => 'customer 9'
last_order.order_date # => '2022-01-25'
last_order.item_id # => 1

# 3 Raises error when item_id is not int

repository = OrderRepository.new

order = Order.new
order.customer_name = 'customer 9'
order.order_date = '2022-01-25'
order.item_id = 'customer 9'

repository.create(order) # => raises error

# 4 # 3 Raises error when item_id does not exist

repository = OrderRepository.new

order = Order.new
order.customer_name = 'customer 9'
order.order_date = '2022-01-25'
order.item_id = 5

repository.create(order) # => raises error


# 6 Raises error when order_date is not a date

repository = OrderRepository.new

order = Order.new
order.customer_name = 'customer 9'
order.order_date = 'customer 9'
order.item_id = 1

repository.create(order) # => raises error



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
