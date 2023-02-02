# Orders Model and Repository Classes Design Recipe

## 1. Design and create the Table

```
Table: orders

Columns:
id | customer_name | date | item_id
```

## 2. Create Test SQL seeds

```sql
-- (file: spec/seeds.sql)

TRUNCATE TABLE orders RESTART IDENTITY;

INSERT INTO orders (customer_name, date, item_id)
VALUES ('Alice', '2023-01-29', 1),
       ('Bob', '2023-01-30', 2),
       ('Carry', '2023-01-31', 2),
       ('Dan', '2023-02-01', 1);
```

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

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class,
including primary and foreign keys.

```ruby
# Table name: orders

# Model class
# (in lib/order.rb)

Order = Struct.new(:id, :customer_name, :date, :item_id)
```

## 5. Define the Repository Class interface

```ruby
# Table name: orders

# Repository class
# (in lib/order_repository.rb)

class OrderRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT * FROM orders;

    # Returns an array of Order objects.
  end

  # Creates a single record
  # One argument: a new order object
  def create(order, item_name)
    # Executes the SQL query:
    # INSERT INTO orders (customer_name, date, item_id) VALUES ($1, $2, (SELECT id FROM item WHERE name=$3))

    # Returns nil.
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table
written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# 1
# Get all records

repo = OrdersRepository.new

orders = repo.all

orders # => [
{ id: 1, customer_name: 'Alice', date: '2023-01-29', item_id: 1 },
  { id: 2, customer_name: 'Bob', date: '2023-01-30', item_id: 2 },
  { id: 3, customer_name: 'Carry', date: '2023-01-31', item_id: 2 },
  { id: 4, customer_name: 'Dan', date: '2023-02-01', item_id: 1 }
]

# 2
# Create a single record

repo = OrdersRepository.new

new_order = Order.new(customer_name: 'Eve', date: '2023-02-02', item_id: 2)

repo.create(new_order)

order = repo.all

order.includes(new_order)
```

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# file: spec/reset_tables.rb

def reset_tables
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: 'localhost', dbname: 'shop_test' })
  connection.exec(seed_sql)
end

# file: spec/order_repository_spec.rb

describe OrderRepository do
  before(:each) do
    reset_tables
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._