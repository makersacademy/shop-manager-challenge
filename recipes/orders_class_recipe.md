{{Artists}} Model and Repository Classes Design Recipe


1. Design and create the Table √


2. Create Test SQL seeds
Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

-- EXAMPLE
-- (file: spec/seeds_shop_manager.sql)

-- Write your SQL seed here. 

```sql

TRUNCATE TABLE orders, items RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.

-- Replace these statements with your own seed data.


INSERT INTO items (name, price, quantity) VALUES ('Notebook', 1, 10);
INSERT INTO items (name, price, quantity) VALUES ('Shirt', 5, 6);
INSERT INTO items (name, price, quantity) VALUES ('Trousers', 10, 15);
INSERT INTO items (name, price, quantity) VALUES ('Boots', 20, 5);


INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Janet', '2023-01-2', 1);
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Aaron', '2022-12-12', 3);
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Emily', '2022-10-23', 2);
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Camille', '2023-01-24', 4);

```


Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

psql -h 127.0.0.1 shop_manager_test < seeds_shop_manager.sql


3. Define the class names
Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by Repository for the Repository class name.

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

4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: orders

# Model class
# (in lib/order.rb)

class Order
  attr_accessor :id, :customer_name, :order_date, :item_id
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object, here's an example:
#
# order = Order.new
# order.customer_name = 'John'
# order.item_id = '1'
```

You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.


5. Define the Repository Class interface
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

    # Returns an array of order objects.
  end

   # select a single method 
   # given the id in an argument(a number)
  def find(id)
    # executes the SQL query: 
    # SELECT id, customer_name, order_date, item_id FROM orders WHERE id = $1

    # returns a single order 
  end 

  # insert a new order record 
  # takes an order object as an arguemtn
  def create(order)
    # executes the SQL query: 
    # INSERT INTO orders (customer_name, order_date, item_id) VALUES($1, $2, $3);

    # returns nothing 
  end
end
```


6. Write Test Examples
Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all orders

repo = OrderRepository.new

orders = repo.all 
orders.length # => 4
orders.first.id # => 1 
orders.first.customer_name # => 'Janet'
orders.first.order_date # => '2023-01-02'
orders.first.item_id # => 1


# 2
# get a single order

repo = OrderRepository.new

order = repo.find(1)
order.customer_name # => 'Janet'
order.order_date # => '2023-01-02' 
order.item_id # => '1'

# 3
# get a single order

repo = OrderRepository.new

order = repo.find(3)
order.customer_name # => 'Emily'
order.order_date # => '2022-10-23' 
order.item_id # => '2'


# 4
# Create a new order 

repo = OrderRepository.new

order = Order.new
order.customer_name = 'Alfie'
order.order_date = '2022-10-31'
order.item_id = '1'


repo.create(order) => nil

orders =  repo.all 

last_order = orders.last 
last_order.customer_name # => 'Alfie'
last_order.order_date # => '2022-10-31'
order.item_id # => '1'


```


7. Reload the SQL seeds before each test run
Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

# EXAMPLE

# file: spec/order_repository_spec.rb

def reset_orders_table
  seed_sql = File.read('spec/seeds_shop_manager.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe OrderRepository do
  before(:each) do 
    reset_orders_table
  end

  # (your tests will go here).
end
8. Test-drive and implement the Repository class behaviour
After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.