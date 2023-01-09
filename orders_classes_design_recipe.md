# ORDERS Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `orders`*

```
# EXAMPLE

Table: orders

Columns:
id | customer_name | order_date | item_id
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

INSERT INTO orders (customer_name, order_date, item_id) VALUES ('John Smith', 'Jan-01-2023', 1);
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Harry Styles', 'Jan-02-2023', 2);
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Megan Rapinoe', 'Jan-03-2023', 2);
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Lorenzo Raeti', 'Jan-06-2023', 1);
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Phil Bravo', 'Jan-08-2023', 3);



```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 shop_manager_test < seeds_orders.sql
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
# (in lib/item_repository.rb)
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
  attr_accessor :id, :customer_name, :order_date, :item_id
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# order = Order.new
# order.customer_name = 'John Smith'
# order.customer_name
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
        # SELECT id, customer_name, order_date, item_id FROM orders;

        # Returns an array of Order objects.
    end

    # Gets a single record by its ID
    # One argument: the id (number)
    def find_order(id)
        # Executes the SQL query:
        # SELECT id, customer_name, order_date, item_id FROM orders WHERE id = $1;

        # Returns a single Order object.
    end

    # Inserts new Order record into database
    def create(order)
        # Executes the SQL query
        # SELECT items.id AS item_id,
	    #    items.name,
	    #    orders.id AS order_id,
	    #    items.unit_price,
	    #    items.quantity,
	    #    orders.customer_name,
	    #    orders.order_date
	    #    FROM items
	    #    	JOIN orders ON orders.item_id = items.id;
        # INSERT into orders (customer_name, order_date, item_id) VALUES ($1, $2, $3);
        # UPDATE items SET quantity = quantity - 1 WHERE item_id = $3

        # Returns nothing
    end

    # Deletes an existing Item record from database
    def delete(id)
        # Executes the SQL query
        SELECT items.id AS item_id,
	    #    items.name,
	    #    orders.id AS order_id,
	    #    items.unit_price,
	    #    items.quantity,
	    #    orders.customer_name,
	    #    orders.order_date
	    #    FROM items
	    #    	JOIN orders ON orders.item_id = items.id;
        # DELETE FROM orders WHERE order_id = $1;
        # UPDATE items SET quantity = quantity + 1 WHERE order_id = $1

        # Returns nothing
    end

    # Updates an existing Item record from database
    def update(order)
        # Executes the SQL query
        # SELECT items.id AS item_id,
	    #    items.name,
	    #    orders.id AS order_id,
	    #    items.unit_price,
	    #    items.quantity,
	    #    orders.customer_name,
	    #    orders.order_date
	    #    FROM items
	    #    	JOIN orders ON orders.item_id = items.id;
        # UPDATE i ...
    
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
# Get all items

repo = OrderRepository.new

orders = repo.all

orders.length # =>  3

orders[0].id # =>  1
orders[0].customer_name # =>  'John Smith'
orders[0].order_date # => '2023-01-01'
orders[0].item_id # => 1

orders[1].id # =>  2
orders[1].customer_name # =>  'Harry Styles'
orders[1].order_date # => '2023-01-02'
orders[1].item_id # => 2

orders[2].id # =>  3
orders[2].customer_name # =>  'Megan Rapinoe'
orders[2].order_date # => '2023-01-03'
orders[2].item_id # => 2

# 2
# Get a single item

repo = OrderRepository.new

order = repo.find(1)

order.id # =>  1
order.customer_name # =>  'John Smith'
order.order_date # =>  '2023-01-01'
order.item_id # => 1

# 3
# Creates a new order into the database

repo_order = OrderRepository.new
repo_item = ItemRepository.new

order = Order.new
order.customer_name = 'Dan Taylor'
order.order_date = '2023-01-08'
order.item_id =  3

orders = repo_order.all
orders[5].customer_name # => 'Dan Taylor'
item = item.find(3)
item.quantity # => 59
    


# 4
# Deletes an order record from the database

repo_order = OrderRepository.new

repo_order.delete(2)

repo_item = ItemRepository.new
item = repo_item.find(2)
item.quantity # => 16
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

describe OrderRepository do
  before(:each) do 
    reset_orders_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._
