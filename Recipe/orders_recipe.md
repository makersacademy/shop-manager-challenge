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
id | customer_name | order_date
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- (file: spec/seeds_items_order.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE items, orders RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO items (item_name, unit_price, quantity) VALUES ('Chips', 2.99, 1);
INSERT INTO items (item_name, unit_price, quantity) VALUES ('Pizza', 3.49, 2);
INSERT INTO items (item_name, unit_price, quantity) VALUES ('Sandwich', 1.99, 3);

INSERT INTO orders (customer_name, order_date) VALUES ('Sara', '2022-09-01');
INSERT INTO orders (customer_name, order_date) VALUES ('Anne', '2022-12-12');


INSERT INTO items_orders (item_id, order_id) VALUES (1, 1);
INSERT INTO items_orders (item_id, order_id) VALUES (2, 1);
INSERT INTO items_orders (item_id, order_id) VALUES (3, 2);
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 shop_manager_test < seeds_items_order.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: students

# Model class
# (in lib/order.rb)
class Order
end

# Repository class
# (in lib/student_repository.rb)
class OrderRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: students

# Model class
# (in lib/student.rb)

class Order
  attr_accessor :id, :customer_name, :order_date
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
  def all
    sql = 'SELECT id, customer_name, order_date FROM orders;'
    result_set = DatabaseConnection.exec_params(sql, [])
    
    orders = []
    
    result_set.each do |record|
      order = Order.new 
      order.id = record['id']
      order.customer_name = record['customer_name']
      orders << order 
    end
    orders
  end
  
  def find(id)
    sql = 'SELECT id, customer_name, order_date FROM orders WHERE id = $1;'
    sql_params = [id]
    result = DatabaseConnection.exec_params(sql, sql_params)
    
    record = result[0]
    
    order = Order.new
    order.id = record['id']
    order.customer_name = record['customer_name']
    order 
  end
  
  def create(order)
    sql = 'INSERT INTO orders (customer_name, order_date) VALUES ($1, $2);'
    sql_params = [order.customer_name, order.order_date]
    DatabaseConnection.exec_params(sql, sql_params)
  end
  
  def delete(id)
    sql = 'DELETE FROM orders WHERE id = $1;'
    sql_params = [id]
    DatabaseConnection.exec_params(sql, sql_params)
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# It gets all orders
repo = OrderRepository.new
order = repo.all 
expect(order.length).to eq(2)
expect(order[0].customer_name).to eq('Sara')
expect(order[0].order_date).to eq('2022-09-01')
expect(order[1].customer_name).to eq('Anne')
expect(order[1].order_date).to eq('2022-12-12')


# 2
# It gets a single order
repo = OrderRepository.new
order = repo.all
expect(order.length).to eq(2)
expect(order[0].customer_name).to eq('Sara')
expect(order[0].order_date).to eq('2022-09-01')


# 3 
# It creates a new order
repo = OrderRepository.new
new_order = Order.new 
new_order.customer_name = 'Teun'
new_order.order_date = '2022-11-11'

repo.create(new_order)
orders = repo.all 
last_order = orders.last

expect(last_order.customer_name).to eq('Teun')
expect(last_order.order_date).to eq('2022-11-11')


#4 
# It deletes an order
repo = OrderRepository.new
id_to_delete = 1
repo.delete(id_to_delete)

all_orders = repo.all 
expect(all_orders.length).to eq(1)
expect(all_orders.first.id).to eq('2')

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