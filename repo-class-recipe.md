# {{TABLE NAME}} Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.


```
# EXAMPLE
Table: items
Columns:
id | name | price | quantity

Table: orders
Columns:
id | customer_name | order_date
```

## 2. Create Test SQL seeds

If seed data is provided (or you already created it), you can skip this step.


## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby

class Item
end

class Order
end

class ItemRepository
end

class OrderRepository
end

Class
```

## 4. Implement the Model class


```ruby

class Item
  attr_accessor :id, :name, :price, :quantity, :orders

  def initialize
    @orders = []
end

class Order
  attr_accessor :id, :customer_name, :order_date, :items

  def initialize
    @items = []
  end
end


```


## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: items
# Repository class
# (in lib/item_repository.rb)
class ItemRepository
  def all
  end

  def create
  end
end

class OrderRepository
  def all
  end

  def create
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
repo = ItemRepository.new
items = repo.all
expect(items.length) to eq 4
expect(items[0].name).to eq 'Steak'
expect(items[0].quantity).to eq 10
expect(items[2].name).to eq 'chicken thigh'
expect(items[2].price).to eq 3
expect(items[3].id).to eq 4



# 2
# Get all orders

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