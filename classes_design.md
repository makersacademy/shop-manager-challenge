Recipe_database Model and Repository Classes Design Recipe

Copy this recipe template to design and implement Model and Repository classes for a database table.

1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, follow this recipe to design and create the SQL schema for your table.

Table: orders

Columns:
id | order | customer_name | order_date

Table: items

Columns:
id | item_name | item_price | item_quantity | order_id


2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

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
Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by Repository for the Repository class name.


# Table name: items

# Table name: orders


# Model class
# (in lib/items.rb)
class Items
  attr_reader: _____
end


# Model Orders
# (in lib/posts.rb)
class Posts
  attr_reader: _____
end


# Repository class
# (in lib/items_repository.rb)
class ItemsRepository

end

# (in lib/orders_repository.rb)
class OrdersRepository

end


5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

# EXAMPLE
# Table name: items

# Repository class
# (in lib/items_repository.rb)

class ItemsRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, item_name, user_price, item_quantity FROM items;

    # Returns an array of User objects.
  end

  # Select a single record
  # Given the id in arguemnt (a number)
  
  def find(id)
   # Executes the SQL query
   # SELECT id, tem_name, user_price, item_quantity, FROM items WHERE id = $1; 
  end

  # inserts a new users record
  # Takes an Users object as an argument
  def create(items)
   # Executes SQL query
   # INSERT INTO items (item_name, user_price, item_quantity) VALUES($1, $2, $3);

   # Doesn't need to return anything (only creates a record)
   # return nil
  end

  # Deletes an users record
  # Given its id
  def delete(id)
   # Executes the SQL
   # DELETE FROM items WHERE id = $1;

   # Returns nothing (only deletes the record)
   # return nil
  end

  # Updates the users record
  # Take an Users object (with the updated fields)
  def update(items)
   # Executes the sql query
   # UPDATE items SET item_name = $1, user_price = $2, item_quantity = $3; WHERE id = $4;

   # Returns nothing (only updates the record)
   # returns nil
  end

  # end
end


# EXAMPLE
# Table name: orders

# Repository class
# (in lib/orders_repository.rb)

class OrdersRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, order_name, customer_name, order_date FROM orders;

    # Returns an array of User objects.
  end

  # Select a single record
  # Given the id in arguemnt (a number)
  def find(id)
   # Executes the SQL query
   # SELECT id, order_name, customer_name, order_date FROM orders WHERE id = $1; 
  end

  # inserts a new users record
  # Takes an Users object as an argument
  def create(orders)
   # Executes SQL query
   # INSERT INTO orders (order_name, customer_name, order_date ) VALUES($1, $2, $3);

   # Doesn't need to return anything (only creates a record)
   # return nil
  end

  # Deletes an users record
  # Given its id
  def delete(id)
   # Executes the SQL
   # DELETE FROM orders WHERE id = $1;

   # Returns nothing (only deletes the record)
   # return nil
  end

  # Updates the users record
  # Take an Users object (with the updated fields)
  def update(posts)
   # Executes the sql query
   # UPDATE orders SET order_name = $1, customer_name = $2, order_date = $3  WHERE id = $4;
   
   # Returns nothing (only updates the record)
   # returns nil
  end

  # end
end
6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

# EXAMPLES

# 1
# Get all items

repo = ItemsRepository.new

item = repo.all
item.length => 2
item.first.id => 1
item.first.item_name => Nice Mints
item.first.item_price => 50
item.first.item_quantity => 12

# 2 
# Find a certian item

    repo = ItemsRepository.new
    item = repo.find(1)
    expect(item.item_name).to eq 'Nice mints'
    expect(item.item_price).to eq '50'
    expect(item.quantity).to eq '12'

    repo = ItemsRepository.new
    item = repo.find(2)
    expect(item.item_name).to eq 'Best Beans'
    expect(item.item_price).to eq '1000'
    expect(item.quantity).to eq '5'

# 3 Create new user

    repo = ItemsRepository.new

    new_item = Item.new
    new_item.item_name = 'Choclits'
    new_item.item_price = '999'
    new_item.item_quantity = '1'


    repo.create(new_item)

    items = repo.all
    last_item = items.last

    expect(last_item.item_name).to eq 'Choclits'
    expect(last_item.item_price).to eq '999'
    expect(last_item.quantity).to eq '1'

# 4 Delete an item

repo = ItemsRepository.new

id_to_delete = 1

repo.delete(id_to_delete)

all_items = repo.all
all_items.length => 1
all_items.first.id => 2


# 1
# Get all Orders

repo = OrdersRepository.new

order = repo.all
order.length => 4
order.first.id => 1
order.first.order_name => 'Supreme Mints'
order.first.customer_name => 'Karl'
order.frist.order_date => '2023

# 2 
# Find a certian order

    repo = OrdersRepository.new
    order = repo.find(1)
    expect(order.order_name).to eq 'Supreme Mints'
    expect(order.cutsomer_name).to eq 'Karl'
    expect(order.order_date).to eq '2023'

    repo = PostsRepository.new
    order = repo.find(2)
    expect(order.order_name).to eq 'Best Beans'
    expect(order.cutsomer_name).to eq 'Sue'
    expect(order.order_date).to eq '2023'

# 3 Create new Order

    repo = OrdersRepository.new

    new_order = Order.new
    new_order.order_name = 'Gems'
    new_order.customer_name = 'Jerome'
    new_order.order_date = '2022'
    

    repo.create(new_order)

    orders = repo.all
    last_order = orders.last

    expect(last_order.order_name).to eq('Gems')
    expect(last_order.customer_name).to eq('Jerome')
    expect(last_order.order_date).to eq('2022')

# 4 Delete an Order

repo = OrdersRepository.new

id_to_delete = 1

repo.delete(id_to_delete)

all_orders = repo.all
all_orders.length => 1
all_orders.first.id => 2




7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

# EXAMPLE

# file: spec/items_repository_spec.rb

def reset_items_table
  seed_sql = File.read('spec/items_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_db_test' })
  connection.exec(seed_sql)
end

describe ItemsRepository do
  before(:each) do 
    reset_items_table
  end

  # file: spec/orders_repository_spec.rb

def reset_orders_table
  seed_sql = File.read('spec/orders_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_db_test' })
  connection.exec(seed_sql)
end

describe OrdersRepository do
  before(:each) do 
    reset_orders_table
  end

  # (your tests will go here).
end
8. Test-drive and implement the Repository class behaviour

After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.