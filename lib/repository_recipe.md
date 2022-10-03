# {{SHOP MANAGER}} Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `students`*

```
# EXAMPLE

Table: students

Columns:
id | name | cohort_name
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

TRUNCATE TABLE students RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO students (name, cohort_name) VALUES ('David', 'April 2022');
INSERT INTO students (name, cohort_name) VALUES ('Anna', 'May 2022');
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: students

# Model class
# (in lib/student.rb)
class Stocks
  attr_accessor :id, :name, :price, :quantity
end

# Repository class
# (in lib/student_repository.rb)
class StocksRepository

end
```
class Orders
  attr_accessor :id, :name, :order_number, :date
end

# Repository class
# (in lib/student_repository.rb)
class OrdersRepository


end

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: students

# Model class
# (in lib/student.rb)

class Stocks
  attr_accessor :id, :name, :price, :quantity
end

class Orders
  attr_accessor :id, :name, :order_number, :date
end
# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# student = Student.new
# student.name = 'Jo'
# student.name
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: students

# Repository class
# (in lib/student_repository.rb)

class StocksRepository
  def all
   stocks = []
        
    sql = 'SELECT id, name, price, quantity FROM stocks;'
    result_set = DatabaseConnection.exec_params(sql, [])

    result_set.each do |record|
      stock = Albums.new

      stock.id = record['id']
      stock.name = record['name']
      stock.price = record['price']
      stock.quantity = record['quantity']

      stocks << stock
    end

    return stocks
  end
  
  def create(stock)
    sql = 'INSERT INTO stocks (name, price, quantity) VALUES($1, $2, $3)'
    sql_params = [stock.name, stock.price, stock.quantity]

    DatabaseConnection.exec_params(sql, sql_params)

    return nil 
  end 
end

class OrdersRepository
  def all
   orders = []
        
    sql = 'SELECT id, name, order_number, date FROM orders;'
    result_set = DatabaseConnection.exec_params(sql, [])

    result_set.each do |record|
      order = Album.new

      order.id = record['id']
      order.name = record['name']
      order.order_number = record['order_number']
      order.date = record['date']

      orders << order
    end

    return orders
  end
  
  def create(order)
    sql = 'INSERT INTO artists (name, order_number, date) VALUES($1, $2, $3)'
    sql_params = [order.name, order.order_number, order.date]

    DatabaseConnection.exec_params(sql, sql_params)

    return nil 
  end 
end

class Greeter
  def initialize(io)
    @io = io
  end

  def greet
    @io.puts "Welcome to the shop management program!

      What do you want to do?
      1 = list all shop items
      2 = create a new item
      3 = list all orders
      4 = create a new order"
    name = @io.gets.chomp

    if name = 1
      @io.puts StocksRepository.all
    elsif name = 2
      @io.puts StocksRepository.create
    elsif name = 3
      @io.puts OrdersRepository.all
    elsif name = 4
      @io.puts OrdersRepository.create
    else 
      return "I am sorry, you have not read the instructions properly!"
    end
  end
end



## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all stocks

repo = StocksRepository.new

stocks = repo.all

stocks.length # =>  2

stocks[0].id # =>  1
stocks[0].name # =>  'Super Shark Vacuum Cleaner'
stocks[0].price # =>  '99'
stocks[0].quantity # =>  '30'

repo = OrdersRepository.new

orders = repo.all

orders.length # =>  2

orders.id # =>  1
orders.name # =>  'Blake ODonnell'
orders.order_number # =>  '1'
orders.date # => '2022-10-02'


repo = StocksRepository.new
new_stock = Stocks.new

new_stock.name = "Hello World! Badge"
new_stock.price = "5"
new_stock.quantity = "1"
repo.create(new_post)

all_stocks = repo.all

expect(all_stocks). to include(
have_attributes(
name: new_stock.name,
price: new_stock.price,
quantity: new_stock.quantity,
)   
)
end 

repo = OrdersRepository.new
new_order = Orders.new

new_order.name = "Joe Bloggs"
new_order.order_number = "3"
new_order.date = "2022-10-03"
repo.create(new_post)

all_orders = repo.all

expect(all_orders). to include(
have_attributes(
name: new_order.name,
order_number: new_order.order_number,
date: new_order.date,
)   
)
end 

RSpec.describe Greeter do
  it "greets the user" do
    io = double :io
    expect(io).to receive(:puts).with(
      "Welcome to the shop management program!

      What do you want to do?
      1 = list all shop items
      2 = create a new item
      3 = list all orders
      4 = create a new order"
      )
    expect(io).to receive(:gets).and_return("1")
    expect(io).to receive(:puts).with(StocksRepository.all)

    greeter = Greeter.new(io)
    greeter.greet
  end
end

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

<!-- BEGIN GENERATED SECTION DO NOT EDIT -->

---

**How was this resource?**  
[😫](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😫) [😕](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😕) [😐](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😐) [🙂](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=🙂) [😀](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😀)  
Click an emoji to tell us.

<!-- END GENERATED SECTION DO NOT EDIT -->