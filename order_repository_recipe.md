# Order Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `orders`*

```
# EXAMPLE

Table: orders

Columns:
id | customer | date
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
TRUNCATE TABLE items RESTART IDENTITY CASCADE;
TRUNCATE TABLE orders RESTART IDENTITY CASCADE;
TRUNCATE TABLE items_orders RESTART IDENTITY CASCADE;

INSERT INTO items (name, price, quantity) VALUES 
('TV', 99.99, 5),
('Fridge', 80.00, 10);

INSERT INTO orders (customer, date) VALUES
('Rob', 'Jan-01-2022'),
('Tom', 'Jan-02-2022');

INSERT INTO items_orders (item_id, order_id) VALUES
(1, 1),
(1, 2),
(2, 1);
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
# EXAMPLE
# Table name: orders

# Model class
# (in lib/order.rb)

class Order
  # Replace the attributes by your own columns.
  attr_accessor :id, :customer, :date
end

```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

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
    # SELECT id, customer, date FROM orders;
    # Returns an array of Order objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, customer, date FROM orders WHERE id = $1;
    # Returns a single Order object.
  end

  def create(order)
    # Order is an instance of Order object
    # INSERT INTO orders (customer, date) VALUES ($1, $2);
    # Returns nothing
  end

  def delete(id)
    # id is an integer
    # DELETE FROM orders WHERE id = $1;
    # Returns nothing
  end

  def update(order)
    # Order is an instance of Order object
    # UPDATE orders SET customer = $1, date = $2 WHERE id = $3;
    # Returns nothing
  end

  def find_with_item(order_id)
    # Executes the SQL query:
    # SELECT items.id AS item_id,
    #        items.name,
    #        items.price,
    #        items.quantity,
    #        orders.id AS order_id,
    #        orders.customer,
    #        orders.date,
    # FROM orders
    #   JOIN items
    #   ON items.order_id = orders.id;
    # Returns an array of Order objects
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

orders.length # => 3

orders[0].id # => 1
orders[0].customer # => 'Rob'
orders[0].date # => 'Jan-01-2022'

orders[1].id # => 2
orders[1].customer # => 'Tom'
orders[1].date # => 'Jan-02-2022'

# 2
# Get a single order

repo = OrderRepository.new

order = repo.find(1)

order.id # => 1
order.customer # => 'Rob'
order.date # => 'Jan-01-2022'

# 3
# Create a single order

repo = OrderRepository.new
order = order.new
order.customer #=> 'Shah'
order.date #=> 'Jan-13-2022'
repo.create(order)

all_orders = repo.all
all_orders.last.id #=> 4
all_orders.last.customer #=> 'Shah'
all_orders.last.date #=> 'Jan-13-2022'

# 4
# Delete a single order
repo = OrderRepository.new
repo.delete(1)
orders = repo.all
orders.length #=> 2
orders[0].id #=> 2
orders[1].id #=> 3

# 5
# Update a single order
repo = orderRepository.new
order = repo.find(2)
order.customer = 'Graeme'
repo.update(order)
order = repo.find(2)
order.customer # => 'Graeme'
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/orders_repository_spec.rb

def reset_orders_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_inventory_test' })
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
