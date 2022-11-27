User stories

As a shop manager
So I can know which items I have in stock
I want to keep a list of my shop items with their name and unit price.

As a shop manager
So I can know which items I have in stock
I want to know which quantity (a number) I have for each item.

Method (in addition to #all):
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

Method (in additon to #all):
      As a shop manager
      So I can manage orders
      I want to be able to create a new order.




1. Design and create the table(s)
Otherwise, follow this item to design and create the SQL schema for your table.

After creating tables, create database and test database.



2. Create Test SQL seeds
Your tests will depend on data stored in ordergreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

-- (file: spec/seeds_items_orders.sql)

-- Write your SQL seed here. 


-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE items, orders, items_orders RESTART IDENTITY;

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO "items" (name, unit_price, quantity) VALUES ('Henry Hoover', 79, 19);
INSERT INTO "items" (name, unit_price, quantity) VALUES ('Dyson Vacuum', 199, 28);
INSERT INTO "items" (name, unit_price, quantity) VALUES ('Dualit Toaster', 49, 39);
INSERT INTO "items" (name, unit_price, quantity) VALUES ('Breville Kettle', 39, 34);
INSERT INTO "items" (name, unit_price, quantity) VALUES ('Panasonic Microwave', 59, 29);

INSERT INTO "orders" (customer_name, item_id, date) VALUES ('Andy Lewis', 2, '2022-11-23');
INSERT INTO "orders" (customer_name, item_id, date) VALUES ('James Scott', 5, '2022-11-24');
INSERT INTO "orders" (customer_name, item_id, date) VALUES ('Christine Smith', 4, '2022-11-24');
INSERT INTO "orders" (customer_name, item_id, date) VALUES ('Louise Stones', 1, '2022-11-25');
INSERT INTO "orders" (customer_name, item_id, date) VALUES ('Michael Kelly', 3, '2022-11-26');
INSERT INTO "orders" (customer_name, item_id, date) VALUES ('Catherine Wells', 2, '2022-11-27');

INSERT INTO "items_orders" (item_id, order_id) VALUES (1, 4);
INSERT INTO "items_orders" (item_id, order_id) VALUES (2, 1);
INSERT INTO "items_orders" (item_id, order_id) VALUES (2, 6);
INSERT INTO "items_orders" (item_id, order_id) VALUES (3, 5);
INSERT INTO "items_orders" (item_id, order_id) VALUES (4, 3);
INSERT INTO "items_orders" (item_id, order_id) VALUES (5, 2);




Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

psql -h 127.0.0.1 items_orders_test < seeds_items_orders.sql







3. Define the class names
Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by Repository for the Repository class name.


# 1 Table name: items

# Model class
# (in lib/item.rb)

class Item
end

# Repository class
# (in lib/item_repository.rb)
class ItemRepository
end




# 2 Table name: orders

# Model class
# (in lib/order.rb)

class Order
end

# Repository class
# (in lib/order_repository.rb)
class OrderRepository
end






4. Implement the Model class
Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.


# 1 Table name: items

# Model class
# (in lib/item.rb)

class Item
  # Replace the attributes by your own columns.
  attr_accessor :id, :name, :unit_price, :quantity, :orders

  def initialize
    @orders = []
  end
end


# 2 Table name: orders

# Model class
# (in lib/orders.rb)

class Order
  # Replace the attributes by your own columns.
  attr_accessor :id, :customer_name, :item_id, :date, :items

  def intialize
    @items = []
  end
end


# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# order = order.new
# order.name = 'Jo'
# order.name
You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.




5. Define the Repository Class interface
Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.


# 1 Table name: items

# Repository class
# (in lib/item_repository.rb)
class ItemRepository
  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query below:
    sql = "SELECT id, name, unit_price, quantity FROM items;"
    result_set = DatabaseConnection.exec_params(sql, [])

    items = []

    # loop through results and create an array of item objects
    # Return array of item objects.
  end


  # Creating a new item record (takes an instance of item)
  def create(item)
    sql = "INSERT INTO items (name, unit_price, quantity) VALUES($1, $2, $3);"
    params = [item.name, item.unit_price, item.quantity]
    DatabaseConnection.exec_params(sql, params)
  end


  <!-- # Finding one record
  # Taking the record id as an argument
  def find(id)
    sql = "SELECT id, name, unit_price, quantity FROM items WHERE id = $1;"

    params = [id]

    result_set = DatabaseConnection.exec_params(sql, params)
    record = result_set[0]

    # (The code now needs to convert the result to an Item object and return it)
  end -->

  <!-- # Find one item and list orders in this item
  # (in lib/item_repository.rb)
  def find_with_orders(id)
    sql = "SELECT items.id AS item_id,
          items.name AS item_name,
          items.unit_price,
          orders.id AS order_id,
          orders.customer_name AS customer_name
          FROM items
          JOIN orders ON items.id = orders.item_id
          WHERE id = $1;"

    params = [id]

    result_set = DatabaseConnection.exec_params(sql, params)
    record = result_set[0]
    # create item object and add all data (from record)
    # add order info to item.@orders array (loop through result_set)
    # return item object    
  end -->

  <!-- # Find items by order
  # (in lib/item_repository.rb)
  def find_by_tag(order_id)
    sql = "SELECT items.id AS item_id,
          items.title AS item_title
          FROM items
          JOIN items_orders ON items.id = items_orders.item_id
          JOIN orders ON items_orders.order_id = orders.id
          WHERE orders.id = $1;"

    params = [order_id]

    result_set = DatabaseConnection.exec_params(sql, params)
    record = result_set[0]
    
    # create items (/ @items) array??
    # loop through records, creating item objects and adding to items array?
    # return items
  end -->


  <!-- def delete(id)
    sql = "DELETE FROM items WHERE id = $1"
    params = [id]
    DatabaseConnection.exec_params(sql, params)
  end -->


  <!-- # def update(item)
  # end -->
end



# 2 Table name: orders

# Repository class
# (in lib/tag_repository.rb)
class OrderRepository
  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query below:
    sql = "SELECT id, customer_name, item_id, date FROM orders;"
    result_set = DatabaseConnection.exec_params(sql, [])

    orders = []

    # loop through results and create an array of Order objects
    # Return array of Order objects.
  end

  # Creating a new order record (takes an instance of Order)
  def create(order)
    sql = "INSERT INTO orders (customer_name, item_id, date) VALUES($1, $2, $3);"
    params = [order.customer_name, order.item_id, order.date]
    DatabaseConnection.exec_params(sql, params)
  end

  <!-- # Finding one record
  # Taking the record id as an argument
  def find(id)
    sql = "id, title, content, views, item_id FROM orders WHERE id = $1;"

    params = [id]

    result_set = DatabaseConnection.exec_params(sql, params)
    record = result_set[0]

    # (The code now needs to convert the result to an Album object and return it)
  end -->

  <!-- # Find orders by item
  # (in lib/tag_repository.rb)
  def find_by_item(item_id)
    sql = "SELECT orders.id AS order_id,
          orders.name AS tag_name
          FROM orders
          JOIN items_orders ON orders.id = items_orders.order_id
          JOIN items ON items_orders.item_id = items.id
          WHERE items.id = $1;"

    params = [item_id]

    result_set = DatabaseConnection.exec_params(sql, params)
    record = result_set[0]
    
    # create orders (/ @orders) array??
    # loop through records, creating Tag objects and adding to orders array?
    # return orders
  end -->


  <!-- def delete(id)
    sql = "DELETE FROM orders WHERE id = $1"
    params = [id]
    DatabaseConnection.exec_params(sql, params)
  end -->


  <!-- # def update(item)
  # end -->
end




6. Write Test Examples
Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.


# items


# Get all items - #all

# 1
repo = ItemRepository.new
items = repo.all

expect(items.length).to eq 5
expect(items.first.id).to eq '1'
expect(items.last.id).to eq '5'
expect(items.first.name).to eq 'Henry Hoover'
expect(items.last.name).to eq 'Panasonic Microwave'
expect(items[2].unit_price).to eq '49'
expect(items[3].quantity).to eq '34'



# Create an item

# 1 (passing an Item object to #create)
repo = ItemRepository.new

new_item = Item.new
new_item.name = 'Nespresso Coffee Machine'
new_item.unit_price = 59
new_item.quantity = 20

repo.create(new_item)

items = repo.all

expect(items.last.id).to eq 6
expect(items.last.name).to eq 'Nespresso Coffee Machine'
expect(items.last.unit_price).to eq '59'
expect(items.last.quantity).to eq '20'

# 2 (passing a non Item object to #create)
raise_error (with string, int, nil, etc.)




<!-- # Find items by order - #find_by_tag

repo = itemRepository.new
items = repo.find_by_tag(1)

expect(items.length).to eq 4
expect(items[0].id).to eq '1'
expect(items[1].id).to eq '2'
expect(items[2].id).to eq '3'
expect(items[3].id).to eq '7'
expect(items[0].title).to eq 'How to use Git'
expect(items[1].title).to eq 'Ruby classes'
expect(items[2].title).to eq 'Using IRB'
expect(items[3].title).to eq 'SQL basics' -->

<!-- # Find items with orders - #find_with_orders

repo = itemRepository.new
item = repo.find_with_orders(1)

expect(item.name).to eq 'One'
expect(item.starting_date).to eq '2022-09-01'
expect(item.orders.length).to eq 2
expect(item.orders.first.name).to eq 'Andy'
expect(item.orders.last.name).to eq 'James'
expect(item.orders.first.item_id).to eq '1'
expect(item.orders.last.item_id).to eq '1' -->


<!--
# 2
# Find a item - #find(id)

# 1
repo = itemRepository.new
item = repo.find(1)

expect(item.id).to eq '1'
expect(item.name).to eq 'Andy'
expect(item.unit_price).to eq 'andy@gmail.com'
expect(item.quantity).to eq 'andy123'

# 2
repo = itemRepository.new
item = repo.find(2)

expect(item.id).to eq '2'
expect(item.name).to eq 'James'
expect(item.unit_price).to eq 'james@outlook.com'
expect(item.quantity).to eq 'james456'


# 3
# Delete a item
repo = itemRepository.new

repo.delete(3)
expect(items.length).to eq 2
expect(items.last.id).to eq '2'
expect(items.last.name).to eq 'James'






# orders

# 1
# Get all orders - #all

repo = orderRepository.new
orders = repo.all

expect(orders.length).to eq 5
expect(orders.first.id).to eq '1'
expect(orders.last.id).to eq '5'
expect(orders.last.title).to eq 'Deactivate account'
expect(orders[2].item_id).to eq '3'


# 2
# Find a order - #find(id)

# 1
repo = orderRepository.new
order = repo.find(1)

expect(order.id).to eq '1'
expect(order.title).to eq 'Hello'
expect(order.content).to eq 'Hello, this is Andy'
expect(order.views).to eq '54'
expect(item_id).to eq '1'

# 2
repo = orderRepository.new
order = repo.find(2)

expect(order.id).to eq '2'
expect(order.title).to eq 'Test'
expect(order.content).to eq 'Testing, 123'
expect(order.views).to eq '100'
expect(item_id).to eq '2'


# 3
# Delete a order
repo = orderRepository.new

repo.delete(3)
expect(orders.length).to eq 4
expect(orders.last.id).to eq '5' # or 4??? will IDs after deleted one decrement?
expect(orders[2].title).to eq 'Sport'


# 4
# Create a order
repo = orderRepository.new

new_order = order.new
new_order.title = 'New order'
new_order.content = 'I am adding a new order'
new_order.views = '2'
new.item_id.to eq '2'

repo.create(new_order)

orders = repo.all

expect(orders.last.id).to eq '6'
expect(orders.last.title).to eq 'New order'
expect(orders.last.content).to eq 'I am adding a new order'
expect(orders.last.views).to eq '2'
expect(item_id).to eq '2' -->



# orders

# Get all items - #all

# 1
repo = OrderRepository.new
orders = repo.all

expect(orders.length).to eq 6
expect(orders.first.id).to eq 1
expect(orders.last.id).to eq 6
expect(orders.first.name).to eq 'Andy Lewis'
expect(orders.last.name).to eq 'Catherine Wells'
expect(orders[1].item_id).to eq '5'
expect(orders[2].date).to eq '2022-11-24'



# Create an item

# 1 (passing an Item object to #create)
repo = OrderRepository.new

new_order = Order.new
new_order.customer_name = 'James Jameson'
new_order.item_id = 5
new_order.date = '2022-11-27' # Or could require 'date' library and use Date.today if all new orders are to be marked as today's date

repo.create(new_order)

orders = repo.all

expect(orders.last.id).to eq 7
expect(orders.last.customer_name).to eq 'James Jameson'
expect(orders.last.item_id).to eq '5'
expect(orders.last.date).to eq '2022-11-27'

# 2 (passing a non Item object to #create)
raise_error (with string, int, nil, etc.)



<!-- # Find orders by item - #find_by_item

repo = TagRepository.new
orders = repo.find_by_item(6)

expect(orders.length).to eq 2
expect(orders[0].id).to eq '2'
expect(orders[1].id).to eq '3'
expect(orders[0].name).to eq 'travel'
expect(orders[1].name).to eq 'cooking' -->




# app mock tests

Design mock tests using a double for Kernel, e.g., passing it as argument 'io'






7. Reload the SQL seeds before each test run
Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.


# file: spec/item_repository_spec.rb

# Repository tests
def reset_tables
  seed_sql = File.read('spec/seeds_items_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'items_orders_test' })
  connection.exec(seed_sql)
end

describe AbcRepository do
  before(:each) do 
    reset_tables
  end

  # (your tests will go here).
end




8. Test-drive and implement the Repository class behaviour
After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.
