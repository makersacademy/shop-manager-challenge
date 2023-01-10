# Orders Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `students`*

```
# EXAMPLE

Table: orders

Columns:
id | date | idem_id
```

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

TRUNCATE TABLE orders RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Peter', '01/01/2023', '001');
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('John', '02/01/2023', '002');
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Jane', '03/01/2023', '003');
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Jessica', '04/01/2023', '004');
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Kate', '05/01/2023', '005');
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Luisa', '06/01/2023', '006');
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 shop_manger_test < seeds_{orders}.sql
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
  attr_accessor :customer_name, :order_date, :item_id
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# order = Order.new
# order.customer_name = 'Alex'

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

  # Selecting all orders
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, customer_name, order_date, item_id FROM orders;

    # Returns an array of Order objects.
  end

# Creates a new order
# No arguments
def create(order)

  # Executes the SQL query:
    # INSERT INTO orders (id, customer_name, order_date, item_id) VALUES ($1, $2, $3)

    # Does not returns anything.

 end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all items

repo = OrderRepository.new

orders = repo.all

orders.length # =>  6

orders[0].id # =>  '1'
orders[0].order_date # =>  '01/01/2023'
orders[0].item_id # =>  '1'

orders[1].id # =>  '2'
orders[1].order_date # =>  '02/01/2023'
orders[1].item_id # =>  '2'

# 2
# Create a new order

repo = OrderRepository.new
new_order = Order.new
        
new_order.order_date[0] = "07/01/2023"
new_order.customer_id[0] = "Bianca"
new_order.item_id[0] = "2"

repo.create(new_order) # => nil

repo.all.length # => 7
repo.all.last.order_date # => '"07/01/2023'
repo.all.last.order.customer_name # => 'Bianca'
repo.all.last.order_id # => '7'

```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/order_repository_spec.rb

def reset_orders_table
  seed_sql = File.read('spec/seeds_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_items_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._

<!-- BEGIN GENERATED SECTION DO NOT EDIT -->

---

<!-- END GENERATED SECTION DO NOT EDIT -->