# Order Model and Repository Classes Design Recipe

## 1. Design and create the Table

Full table design can be found in recipes/tables_design.md

```
Table: orders
id: 
customer_name: 
order_date: 
item_id:
```

## 2. Create Test SQL seeds

```sql
-- (file: spec/seeds_shop.sql)

TRUNCATE TABLE orders,items RESTART IDENTITY; 

-- Below this line there should only be `INSERT` statements.
-- Date format is YYYY/MM/DD
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Amber', '2023/02/13', '1');
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Jamie', '2023/02/12', '2');


```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
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
# Table name: orders

# Model class
# (in lib/order.rb)

class Order

  # Replace the attributes by your own columns.
  attr_accessor :id, :customer_name, :order_date, :item_id
end

```

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: orders

# Repository class
# (in lib/order_repository.rb)

class OrderRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, customer_name, order_date, item_id FROM orders;

    # Returns an array of Orders objects.
  end

  # Gets a single order by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, customer_name, order_date, item_id FROM orders WHERE id = $1;

    # Returns a single Order object.
  end

  def create(order)
    # Executes the SQL query:
    # INSERT INTO orders (customer_name, order_date, item_id) VALUES ($1, $2, $3);

    # creates an order object and doesn't return anything
  end

  def delete(id)
    # Executes the SQL query:
    # DELETE FROM orders WHERE id = $1;

    # deletes an order
  end

  def update(order)
    # Executes the SQL query:
    # UPDATE order SET customer_name = $1, order_date = $2, item_id = $3 WHERE id = $4;
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all orders
repo = OrderRepository.new
orders = repo.all

orders.length # =>  2
orders[0].id # =>  1
orders[0].customer_name # =>  'Amber'
orders[0].order_date # =>  '2023-02-13'
orders[0].item_id # =>  '1'

orders[1].id # =>  1
orders[1].customer_name # =>  'Jamie'
orders[1].order_date # =>  '2023-02-12'
orders[1].item_id # =>  '2'


# 2
# Get a single order
repo = OrderRepository.new
order = repo.find(1)

order.id # =>  1
order.customer_name # =>  'Amber'
order.order_date # =>  '2023-02-13'
order.item_id # =>  '1'


# 3 
# Create a new order
repo = OrderRepository.new
order = Order.new
order.id # => 3
order.customer_name # => 'Mark'
order.order_date # => '2023-02-11'
order.item_id # => '3'

repo.create(order)

order.length # => 3
repo.all.last.customer_name # => 'Mark'


# 4
# Delete an order
repo = OrderRepository.new
order = repo.find(1)
repo.delete(order.id)

repo.all # => 1
repo.all.first.id # => 2


# 5
# Update an order 
repo = OrderRepository.new
order = repo.find(1)

order.customer_name # => 'Amber Ale'
order.order_date # => '2023-02-13'
order.item_id # => '2'

repo.update(order)

updated_order = repo.find(1)
updated_order.customer_name # => 'Amber Ale'
updated_order.order_date # => '2023-02-13'
updated_order.item_id # => '2'

```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/order_repository_spec.rb

def reset_orders_table
  seed_sql = File.read('spec/seeds_shop.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop' })
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