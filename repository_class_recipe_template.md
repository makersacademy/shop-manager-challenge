# {{TABLE NAME}} Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `students`*

```
# EXAMPLE

Table: items
id: SERIAL
name: text
price: int
quantity: int

Table: orders
id: SERIAL
customer_name: text
date: date
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_items_orders.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE items, orders RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO items (name, price, quantity) VALUES ('Super Shark Vacuum Cleaner', '99', '30');
INSERT INTO items (name, price, quantity) VALUES ('Makerspresso Coffee Machine', '70', '15');

INSERT INTO orders (customer_name, date) VALUES ('John Smith', '06/01/22');
INSERT INTO orders (customer_name, date) VALUES ('Pauline Jones', '05/01/22');
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
# Table name: items

# Model class
# (in lib/item.rb)

class Item
  attr_accessor :id, :name, :price, :quantity
end

# Model class
# (in lib/order.rb)

class Order
  attr_accessor :id, :customer_name, :date, :item_id
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
    # Executes the SQL query:
    # INSERT INTO items (name, price, quantity) VALUES($1, $2, $3);

    # returns nothing
  end

  def update(item)
    # Executes the SQL query:
    # UPDATE items SET name = $1, price = $2, quantity = $3 WHERE id = $4;

    # returns nothing
  end

  def delete(item)
    # Executes the SQL query:
    # DELETE FROM items WHERE id = $1;

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
    # SELECT id, customer_name, date FROM orders;

    # Returns an array of Order objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, customer_name, date FROM orders WHERE id = $1;

    # Returns a single Order object.
  end

  def create(order)
    # Executes the SQL query:
    # INSERT INTO orders (customer_name, date) VALUES($1, $2);

    # returns nothing
  end

  def update(order)
    # Executes the SQL query:
    # UPDATE orders SET customer_name = $1, date = $2 WHERE id = $3;

    # returns nothing
  end

  def delete(order)
    # Executes the SQL query:
    # DELETE FROM orders WHERE id = $1;

    # Returns nothing
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES
# Item Repository Tests
# 1
# Get all items

repo = ItemRepository.new

items = repo.all

items.length # =>  2

items[0].id # =>  1
items[0].name # =>  'Super Shark Vacuum Cleaner'
items[0].price # =>  '99'
items[0].quantity # =>  '30'

items[1].id # =>  2
items[1].name # =>  'Makerspresso Coffee Machine'
items[1].price # =>  '69'
items[1].quantity # =>  '15'

# 2
# Get a single item

repo = ItemRepository.new

item = repo.find(1)

item.id # =>  1
item.name # =>  'Super Shark Vacuum Cleaner'
item.price # =>  '99'
item.quantity # =>  '30'

# 3
# Create an item entry

repo = ItemRepository.new

item = Item.new
item.name = 'Bosch Washing Machine'
item.price = '300'
item.quantity = '20'

repo.create(item)

items = repo.all
last_item = items.last
last_item.name # => 'Bosch Washing Machine'
last_item.price # => '300'
last_item.quantity # => '20'

# 4 
# Update an item

repo = ItemRepository.new

item = repo.find(2)
item.name = 'Makerspresso Coffee Machine'
item.price = '85'
item.quantity = '30'

repo.update(item)

updated_item = repo.find(2)

updated_item.id # =>  2
updated_item.name # =>  'Makerspresso Coffee Machine'
updated_item.price # =>  '85'
updated_item.quantity # => '30'

# 5
# Delete an item

repo = ItemRepository.new

delete_item = repo.delete('1')
items = repo.all

items.length # =>  1

items[0].id # =>  1
items[0].name # =>  'Makerspresso Coffee Machine'
items[0].price # =>  '70'
items[0].quantity # => 15

# Order Repository Tests
# 1
# Get all orders

repo = OrderRepository.new

orders = repo.all

orders.length # =>  2

orders[0].id # =>  1
orders[0].customer_name # =>  'John Smith'
orders[0].date # =>  '2022-06-01'
orders[0].item_id # =>  '1'

orders[1].id # =>  2
orders[1].customer_name # =>  'Pauline Jones'
orders[1].date # =>  '2022-05-01'
orders[1].item_id # =>  '2'

# 2
# Get a single order

repo = OrderRepository.new

order = repo.find(1)

order.id # =>  1
order.customer_name # =>  'John Smith
order.date # =>  '2022-06-01'
order.item_id # =>  '2'

# 3
# Create an order entry

repo = OrderRepository.new

order = Order.new
order.customer_name = 'Alex Appleby'
order.date = '06/01/22'
order.item_id = '2'

repo.create(order)

orders = repo.all
last_order = items.last
last_order.customer_name # => 'Alex Appleby'
last_order.date # => '2022-06-01'
last_order.item_id # => '2'

# 4 
# Update an order

repo = OrderRepository.new

order = repo.find(2)
order.customer_name = 'John Smith'
order.date = '01/06/22'
order.item_id = '1'

repo.update(order)

updated_order = repo.find(2)

updated_order.id # =>  1
updated_order.customer_name # =>  'John Smith'
updated_order.date # =>  '2022-06-01'
updated_order.item_id # => '1'

# 5
# Delete an order

repo = OrderRepository.new

delete_order = repo.delete('1')
orders = repo.all

orders.length # =>  1

orders[0].id # =>  1
orders[0].customer_name # =>  'Pauline Jones'
orders[0].date # =>  '2022-05-01'
orders[0].item_id # => '2'
# Add more examples for each method
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/item_repository_spec.rb

def reset_items_table
  seed_sql = File.read('spec/seeds_items_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'items' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_items_table
  end

  # (your tests will go here).
end

def reset_orders_table
  seed_sql = File.read('spec/seeds_items_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'orders' })
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

<!-- BEGIN GENERATED SECTION DO NOT EDIT -->

---

**How was this resource?**  
[😫](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😫) [😕](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😕) [😐](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😐) [🙂](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=🙂) [😀](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😀)  
Click an emoji to tell us.

<!-- END GENERATED SECTION DO NOT EDIT -->
