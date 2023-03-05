# {{TABLE NAME}} Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

```
| Tables                | Columns             |
| --------------------- | ------------------  |
| items                 | item_name, unit_price, quantity
| orders                | customer_name, order_date, item_id

```

## 2. Create Test SQL seeds

```sql
-- (file: schema/items_orders_seeds.sql)
-- needs to truncate orders first as sql can't truncate a table (items) referenced in a foreign key constraint
TRUNCATE TABLE items, orders RESTART IDENTITY;

INSERT INTO items (item_name, unit_price, quantity) 
VALUES ('Jollof rice', 5.50, 200),
       ('Playstation 5', 479.99, 30),
       ('Standing desk', 200, 400),
       ('Cereal', 3.20, 500);

INSERT INTO orders (customer_name, order_date, item_id) 
VALUES ('Sasuke Uchiha', '2023-03-04', 4),
       ('Ross Geller', '1999-10-10', 1),
       ('Monica Geller', '1997-10-10', 1),
       ('Ted Moseby', '2006-10-10', 3), 
       ('Barney Stintson', '2007-05-27', 2);
```

```bash
psql -h 127.0.0.1 shop < schema/items_orders_seeds.sql
psql -h 127.0.0.1 shop_test < schema/items_orders_seeds.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
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

## 4. Implement the Model classes

```ruby
# Table name: items

# Model class
# (in lib/item.rb)
class Item
  attr_accessor :id, :item_name, :unit_price, :quantity
end

# Table name: orders

# Model class
# (in lib/order.rb)
class Order
  attr_accessor :customer_name, :order_date, :item_id
end
```

## 5. Define the Repository Class interfaces

```ruby

# Table name: items

# Repository class
# (in lib/item_repository.rb)

class ItemRepository
  # Selecting all records
  # No arguments
  def list_all_items
    # Executes the SQL query:
    # SELECT * FROM items;

    # Returns an array of Item objects.
  end

  # Creates a new item and inserts it into items table
  # No arguments
  def create_new_item
    # Use gets to prompt user for necessary item attributes
    # Once item is created executes the SQL query:
    # INSERT INTO items (item_name, unit_price, quantity) VALUES($1, $2, $3);
    # Put string showing successful completion

    # Returns nothing
  end
end

class OrderRepository
  # Selecting all records
  # No arguments
  def list_all_orders
    # Executes the SQL query:
    # SELECT * FROM orders;

    # Returns an array of order objects.
  end

  # Creates a new order and inserts it into orders table
  # No arguments
  def create_new_order
    # Use gets to prompt user for necessary order attributes
    # Once order is created executes the SQL query:
    # INSERT INTO orders (customer_name, order_date, item_id) VALUES($1, $2, $3);
    # Put string showing successful completion

    # Returns nothing
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all students

repo = StudentRepository.new

students = repo.all

students.length # =>  2

students[0].id # =>  1
students[0].name # =>  'David'
students[0].cohort_name # =>  'April 2022'

students[1].id # =>  2
students[1].name # =>  'Anna'
students[1].cohort_name # =>  'May 2022'

# 2
# Get a single student

repo = StudentRepository.new

student = repo.find(1)

student.id # =>  1
student.name # =>  'David'
student.cohort_name # =>  'April 2022'

# Add more examples for each method
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

