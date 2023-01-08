# Shop Manager Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `students`*

```
# EXAMPLE

Table: stocks

Columns:
id | item_name | unit_price | quantity

Table: orders

Columns:
id | customer_name | date 
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

TRUNCATE TABLE stocks RESTART IDENTITY; -- replace with your own table name.
TRUNCATE TABLE orders RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO stocks (item_name, unit_price, quantity) VALUES ('item_1', '10', '100');
INSERT INTO stocks (item_name, unit_price, quantity) VALUES ('item_2', '22', '150');
INSERT INTO orders (customer_name, date ) VALUES ('David', '01/04/22');
INSERT INTO orders (customer_name, date ) VALUES ('Anna', '01/05/22');
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: stocks

# Model class
# (in lib/stock.rb)
class Stock
end

# Repository class
# (in lib/stock_repository.rb)
class StockRepository
end

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
# Table name: stocks

# Model class
# (in lib/stock.rb)

class Stock

  # Replace the attributes by your own columns.
  attr_accessor :id, :item_name, :unit_price, :quantity
end

# Table name: orders

# Model class
# (in lib/order.rb)

class Order

  # Replace the attributes by your own columns.
  attr_accessor :id, :customer_name, :date, :stock_id
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
# Table name: stocks

# Repository class
# (in lib/stock_repository.rb)

class StockRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, item_name, unit_price, quantity FROM stocks;

    # Returns an array of Order objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, item_name, unit_price, quantity FROM stocks WHERE id = $1;

    # Returns a single Stock object.
  end

  # Add more methods below for each operation you'd like to implement.

  def create(stock)
    # Executes the SQL query:
    # INSERT INTO stocks (item_name, unit_price, quantity) VALUES ($1, $2, $3);

    # returns nothing
  end

  def update(stock)
    # Executes the SQL query:
    # UPDATE stocks SET item_name = $1, unit_price = $2, quantity = $3 WHERE id = $4;

    # returns nothing
  end

  def delete(id)
    # Executes the SQL query:
    # DELETE FROM stocks WHERE id = $1;

    # returns nothing

  end
end

class OrderRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, customer_name, date FROM orders;

    # Returns an array of Order objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, customer_name, date FROM orders; WHERE id = $1;

    # Returns a single Order object.
  end

  # Add more methods below for each operation you'd like to implement.

  def create(order)
    # Executes the SQL query:
    # INSERT INTO orders (customer_name, date) VALUES ($1, $2);

    # returns nothing
  end

  def update(order)
    # Executes the SQL query:
    # UPDATE orders SET customer_name = $1, date = $2 WHERE id = $3;

    # returns nothing
  end

  def delete(id)
    # Executes the SQL query:
    # DELETE FROM orders WHERE id = $1;

    # returns nothing

  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all stocks

repo = StockRepository.new

stock = repo.all

stock.length # =>  2

stock[0].id # =>  1
stock[0].item_name # =>  'item_1'
stock[0].unit_price # =>  '10'
stock[0].quantity # =>  '100'

stock[1].id # =>  2
stock[1].item_name # =>  'item_2'
stock[1].unit_price # =>  '22'
stock[1].quantity # =>  '150'

# 2
# Get a single student

repo = StockRepository.new

stock = repo.find(1)

stock.id # =>  1
stock.item_name # =>  'item_1'
stock.unit_price # =>  '10'
stock.quantity # =>  '100'

# 3
# Create a stock entry
repo = StockRepository.new

stock = Stock.new
stock.item_name = 'item_3'
stock.unit_price = '27'
stock.quantity = '200'

repo.create(stock)

stocks = repo.all
last_stock = stocks.last
last_stock.item_name #=> 'item_3'
last_stock.unit_price #=> '27'
last_stock.quantity #=> '200'

#4
# Update the stock
repo = StockRepository.new

stock = repo.find(1)
stock.item_name = 'item_updated'
stock.unit_price = '99'
stock.quantity = '100000'

repo.update(stock)
updated_stock = repo.find(1)
updated_stock.id #=> 1
updated_stock.item_name #=> 'item_updated'
updated_stock.unit_price #=> '99'
updated_stock.quantity #=> '100000'

#5
# Delete a stock
repo = StockRepository.new

delete_stock = repo.delete('1')
stocks = repo.all

stocks.length #=> 1

stocks.first.id #=> 2
stocks.first.item_name #=> 'item_2'
stocks.first.unit_price #=> '22'
stocks.first.quantity #=> '150'

# Order Repository Tests 
# 1
# Get all orders

repo = OrderRepository.new

order = repo.all

order.length # =>  2

order[0].id # =>  1
order[0].customer_name # =>  'David'
order[0].date # =>  '2022-01-04'

order[1].id # =>  2
order[1].customer_name # =>  'Anna'
order[1].date # =>  '2022-01-05'


# 2
# Get a single order

repo = OrderRepository.new

order = repo.find(1)

order.id # =>  1
order.customer_name # =>  'David'
order.date # =>  '2022-01-04'


# 3
# Create a order entry
repo = OrderRepository.new

order = Order.new
order.customer_name = 'Mike'
order.date = '2023-01-01'


repo.create(order)

orders = repo.all
last_order = orders.last
last_order.customer_name #=> 'Mike'
last_order.date #=> '2023-01-01'


#4
# Update the order
repo = OrderRepository.new

order = repo.find(1)
order.customer_name = 'name_updated'
order.date = '2021-08-08'


repo.update(order)
updated_order = repo.find(1)
updated_order.id #=> 1
updated_order.customer_name #=> 'name_updated'
updated_order.date #=> '2021-08-08'


#5
# Delete a order
repo = OrderRepository.new

delete_order = repo.delete('1')
orders = repo.all

orders.length #=> 1

orders.first.id #=> 2
orders.first.customer_name #=> 'Anna'
orders.first.date #=> '2022-01-05'

```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_stocks_table
  seed_sql = File.read('spec/stocks_orders_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager' })
  connection.exec(seed_sql)
end

describe StockRepository do
  before(:each) do 
    reset_stocks_table
  end
  
def reset_orders_table
  seed_sql = File.read('spec/stocks_orders_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager' })
  connection.exec(seed_sql)
end

describe OrderRepository do
  before(:each) do 
    reset_orders_table
  end
  # (your tests will go here).
end


```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._

