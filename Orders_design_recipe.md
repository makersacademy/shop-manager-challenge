# {{Orders}} Model and Repository Classes Design post

_Copy this post template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

Extract nouns from the user stories or specification

```
As a shop manager
So I can know which items I have in stock
I want to keep a list of my shop items with their name and unit price.

As a shop manager
So I can know which items I have in stock
I want to know which quantity (a number) I have for each item.

As a shop manager
So I can manage items
I want to be able to create a new item.

As a shop manager
So I can know which orders were made
I want to keep a list of orders with their customer name.

As a shop manager
So I can know which orders were made
I want to assign each order to their corresponding item.

As a shop manager
So I can know which orders were made
I want to know on which date an order was placed. 

As a shop manager
So I can manage orders
I want to be able to create a new order.

```
Nouns:
Item, name, price, quantity
Order, customer_name, item_id, date
```

## 2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.

| Record                | Properties          |
| --------------------- | ------------------  |
| Item               | name, price, quantity
order                   customer_name, item_id, date


Name of the table (always plural): `items`

Column names: `name`, `price`, 'quantity'

Name of the table (always plural): `orders`

Column names: `customer_name`, `item_id`, 'date'


## 3. Decide the column types.

[Here's a full documentation of PostgreSQL data types](https://www.postgresql.org/docs/current/datatype.html).

Most of the time, you'll need either `text`, `int`, `bigint`, `numeric`, or `boolean`. If you're in doubt, do some research or ask your peers.

Remember to **always** have the primary key `id` as a first column. Its type will always be `SERIAL`.

```
# EXAMPLE:
Column names
id: SERIAL
name: text
price: int
quantity: int
```

1. Can one item have many orders? No
2. Can one order have many items? Yes

-> Therefore,
-> An item HAS MANY orders
-> An order BELONG TO an item

-> Therefore, the foreign key is on the orders table.
```

## 4. Write the SQL.

-- EXAMPLE
-- file: items_table.sql

-- Replace the table name, columm names and types.

-- Create the table without the foreign key first.
CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name text,
  price: int,
  quantity: int
);

-- Then the table with the foreign key.
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name text,
  date date,
  item_id int
-- The foreign key name is always {other_table_singular}_id
  item_id int,
  constraint fk_artist foreign key(item_id)
    references posts(id)
    on delete cascade
);

## 5. Create the table.

```bash
psql -h 127.0.0.1 database_name < orders_table.sql
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

INSERT INTO orders (id, customer_name, date, item_id) VALUES (1, 'Harry', '1987-12-03', '1');
INSERT INTO orders (id, customer_name, date, item_id) VALUES (2, 'Hermoine', '1989-12-13', '2');
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_orders.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# Table name: orders

# Model class
# (in lib/order.rb)
class Order
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
  attr_accessor :id, :customer_name, :date, :item_id
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
'
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

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, customer_name, date, item_id FROM orders;

    # Returns an array of post objects.
  end

  def find(id)
  #SELECT id, customer_name, date, item_id FROM orders WHERE id = $1;

  end

  def create(new_tem)
  #INSERT INTO orders(id, customer_name, date, item_id) VALUES($1, $2, $3, $4)
  end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all posts

repo = OrderRepository.new

order = repo.all

order.length # =>  2
order.first.id # =>  1
order.first.customer_name # =>  'Harry'
item.first.date # =>  '1987-12-03'

#2 Find id=2 order
repo = OrderRepository.new
order = repo.find(2)
order.customer_name #=> 'Hermoine'
item.date #=> '1989-12-13'

#3 Create new order
new_order = Order.new
repo = OrderRepository.new
repo.create(new_order)
new_order.customer_name #=> 'Ron'
new_order.id #=> '3'
new_order.date #=> '1991-07-11'
new_order.item_id #=> '2'



## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table prices every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/orders_repository_spec.rb

def reset_orders_table
  seed_sql = File.read('spec/seeds_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
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