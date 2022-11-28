Orders Model and Repository Classes Design Recipe

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, follow this recipe to design and create the SQL schema for your table.

In this template, we'll use an example table students


-- EXAMPLE
-- (file: spec/seeds_items.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

```Ruby 

TRUNCATE TABLE orders RESTART IDENTITY;

INSERT INTO orders (customer_name, date, item_id) VALUES ('Monika Geller', '01.02.1995', '2');
INSERT INTO orders (customer_name, date, item_id) VALUES ('Chandler Bing', '02.03.1996', '1');
INSERT INTO orders (customer_name, date, item_id)  VALUES ('Pheobe Buffay', '04.18.1997', '3');

psql -h 127.0.0.1 shop_manager_database < orders_table.sql

```

3. Define the class names
Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by Repository for the Repository class name.

```Ruby

# EXAMPLE
# Table name: orders

# Model class
# (in lib/order.rb)
class Item
end

# Repository class
# (in lib/order_repository.rb)
class itemRepository
end


### 4. Implement the Model class
Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

# EXAMPLE
# Table name: orders

# Model class
# (in lib/order.rb)

class Order
  # Replace the attributes by your own columns.
  attr_accessor :id, :customer_name, :date, :item_id
end

```

### 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```Ruby

# EXAMPLE
# Table name: orders

# Repository class
# (in lib/order_repository.rb)

class OrderRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, customer_name, date, item_id FROM orders;

    # Returns an array of Orders objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, customer_name, date, item_id FROM orders WHERE id = $1;

    # Returns a single Order object.
  end

  def create(item)
    # Executes the SQL query:
    # INSERT INTO orders(customer_name, date, item_id) VALUES ($1, $2, $3);
    # returns nothing
  end

  def delete(id)
    # Executes the SQL query:
    # DELETE FROM orders WHERE id $1;
  end
end

```

### 6. Write Test Examples
Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```Ruby 

# EXAMPLES

# 1
# Get all orders

repo = OrderRepository.new

orders = repo.all

orders.length # =>  3

orders[0].id # =>  1
orders[0].customer_name # =>  'Monika Geller'
orders[0].date # =>  '01.02.1995'
orders[0].item_id # => '2'

orders[2].id # =>  3
orders[2].customer_name # =>  'Pheobe Buffay'
orders[2].date # =>  '04.12.1997'
orders[2].item_id # => '3'

# 2
# Get a single order

repo = OrderRepository.new

order = repo.find(2)

order.id # =>  2
order.customer_name # =>  'Chandler Bing'
order.date # =>  '02.03.1996'
order.item_id # => '1'

# 3
# Create a new order

repo = OrderRepository.new
new_order = Order.new
new_order.customer_name = 'Rachel Greene'
new_order.date = '06.09.1998'
new_order.item_id = '1'

repo.create(new_order)

all_orders = repo.all
all_orders.last.id # => '4'
all_orders.last.customer_name # => 'Rachel Green'
all_orders.last.date # => '06.09.1998'
all_orders.last.item_id # => '1'
all_orders.length # => 4

# 4
# Delete an order

repo = OrderRepository.new

repo.delete(1)

all_orders = repo.all
all_orders.length # => 2
all_orders.first.id # => '2'
all_orders.first.customer_name # => 'Chandler Bing'
all_orders.first.date # =>  '02.03.1996'
all_orders.first.item_id # => '1'

Encode this example as a test.

7. Reload the SQL seeds before each test run
Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_orders_table
  seed_sql = File.read('spec/seeds_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_database' })
  connection.exec(seed_sql)
end

describe StudentRepository do
  before(:each) do 
    reset_students_table
  end

  # (your tests will go here).
end
8. Test-drive and implement the Repository class behaviour