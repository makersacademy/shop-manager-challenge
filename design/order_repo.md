# orders Model and Repository Classes Design Recipe

## 1. Design and create the Table

```
Table: orders

Columns:
id | customer_name | date_placed
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
TRUNCATE TABLE orders, shop_items, shop_items_orders RESTART IDENTITY; 

INSERT INTO orders (customer_name, date_placed) VALUES ('David', '08-Nov-2022');
INSERT INTO orders (customer_name, date_placed) VALUES ('Anna', '10-Nov-2022');
INSERT INTO orders (customer_name, date_placed) VALUES ('Jill', '11-Nov-2022');
INSERT INTO shop_items (name, unit_price, quantity) VALUES ('sandwich', 2.99, 10);
INSERT INTO shop_items (name, unit_price, quantity) VALUES ('bananas', 1.99, 15);
INSERT INTO shop_items (name, unit_price, quantity) VALUES ('toilet roll', 3.00, 20);
INSERT INTO shop_items (name, unit_price, quantity) VALUES ('crisps', 0.99, 15);
INSERT INTO shop_items (name, unit_price, quantity) VALUES ('sausage roll', 1.50, 10);
INSERT INTO shop_items_orders (shop_item_id, order_id) VALUES (1,1);
INSERT INTO shop_items_orders (shop_item_id, order_id) VALUES (4,1);
INSERT INTO shop_items_orders (shop_item_id, order_id) VALUES (5,1);
INSERT INTO shop_items_orders (shop_item_id, order_id) VALUES (2,2);
INSERT INTO shop_items_orders (shop_item_id, order_id) VALUES (3,3);
INSERT INTO shop_items_orders (shop_item_id, order_id) VALUES (1,3);
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
class Order
end

class OrderRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
class Order
  attr_accessor :id, :customer_name, :date_placed
end
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
class OrderRepository

  # Selects all order items
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, customer_name, date_placed FROM orders;

    # Returns an array of order objects.
  end

  # inserts a new order record
  # takes a order object as an argument
  def create(order)
    # Executes the SQL query:
    # INSERT INTO orders (customer_name, date_placed) VALUES($1, $2);

    # doesnt need to return anything
  end

end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all order items

repo = OrderRepository.new

orders = repo.all

orders.length # =>  3

orders[0].id # =>  1
orders[0].customer_name # =>  'David'
orders[0].date_placed # => '2022-11-08'

orders[1].id # =>  2
orders[1].customer_name # =>  'Anna'
orders[1].date_placed # =>  '2022-11-10'

# 2
# Creates a new order

repo = OrderRepository.new 

order = Order.new
order.customer_name = 'Bob'
order.date_placed = '2022-11-15'

repo.create(order)

orders = repo.all

orders.last.customer_name # => 'Bob'
orders.last.date_placed # => '2022-11-15'
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_tables
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_challenge_test' })
  connection.exec(seed_sql)
end

describe OrderRepository do
  before(:each) do 
    reset_tables
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._

