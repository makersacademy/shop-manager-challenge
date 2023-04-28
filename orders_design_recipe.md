# Orders Model and Repository Classes Design Recipe

## 1. Design and create the Table

```
Table: orders

| Record                | Properties                         |
| --------------------- | ---------------------------------- |
| order                 | customer_name, order_date, item_id |
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_orders.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE orders RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO orders (customer_name, order_date, item_id ) VALUES ('Jack Skates', '2023-04-28', 1 );
INSERT INTO orders (customer_name, order_date, item_id ) VALUES ('Charlie Kelly', '2020-08-12', 2 );
```

```bash
psql -h 127.0.0.1 shop_manager_test < spec/seeds_orders.sql;
```
This was created from the terminal within the directory containing the database file

## 3. Define the class names


```ruby
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


```ruby
# Table name: orders

# Model class
# (in lib/order.rb)

class Order

  attr_accessor :id, :customer_name, :order_date, :item_id
end


```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

```ruby
# Table name: orders

# Repository class
# (in lib/order_repository.rb)

class OrderRepository
  def all
    
  end

  def find(id)
    
  end

  def create(order)
    
  end

  def delete(id)
    
  end

  def update(order)
    
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# 1
# Get all orders
repo = OrderRepository.new

orders = repo.all
expect(orders.size).to eq 2
expect(orders.first.id).to eq '1'
expect(orders.first.customer_name).to eq 'Jack Skates'
expect(orders.first.order_date).to eq '2023-04-08'
expect(orders.first.item_id).to eq '1'

# 2
# Find one order by id

repo = OrderRepository.new
order = repo.find(1)
expect(order.id).to eq '1'
expect(order.customer_name).to eq 'Jack Skates'
expect(order.order_date).to eq '2023-04-28'
expect(order.item_id).to eq '1'

# 3
# Create a new order

repo = OrderRepository.new
add_order = Order.new
add_order.customer_name, add_order.order_date, add_order.item_id = 
  'Frank Reynolds', '2022-12-24', 1
repo.create(add_order)
orders = repo.all
new_order = orders.last
expect(new_order.id).to eq '3'
expect(new_order.customer_name).to eq 'Frank Reynolds'
expect(new_order.order_date).to eq '2022-12-24'
expect(new_order.item_id).to eq '1'

# 4 
# Delete an order

```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby

# file: spec/order_repository_spec.rb

RSpec.describe OrderRepository do

  def reset_orders_table 
    seed_sql = File.read('spec/seeds_orders.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_orders_table
  end
  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._