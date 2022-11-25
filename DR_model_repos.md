social Network Model and Repository Classes Design Recipe

Copy this recipe template to design and implement Model and Repository classes for a database table.

1. Define the tables

Table 1: items
Columns:
id | item_name | unit_price | quantity

Table 2: orders
Columns: 
id | date | customer_name | item_id | quantity


2. Create Test SQL seeds

TRUNCATE TABLE items RESTART IDENTITY; 

INSERT INTO items (item_name, unit_price, quantity) VALUES ('Lego', 9.99, 20);
INSERT INTO items (item_name, unit_price, quantity) VALUES ('My little Pony', 13.99, 50);

psql -h 127.0.0.1 your_database_name < seeds_items.sql


TRUNCATE TABLE orders RESTART IDENTITY;

INSERT INTO orders (date, customer_name, item_id, quantity) VALUES ('01/10/2022', 'Hillary', 1, 1);
INSERT INTO orders (date, customer_name, item_id, quantity) VALUES ('02/10/2022', 'Simone', 2, 1);
INSERT INTO orders (date, customer_name, item_id, quantity) VALUES ('03/11/2022', 'Simone', 1, 2);
INSERT INTO orders (date, customer_name, item_id, quantity) VALUES ('04/10/2022', 'Sharon', 1, 1);
INSERT INTO orders (date, customer_name, item_id, quantity) VALUES ('05/11/2022', 'Helen', 2, 2);

psql -h 127.0.0.1 your_database_name < seeds_orders.sql



3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by Repository for the Repository class name.

Table name: items

Model classes
(in lib/item.rb)
class Item
end

(in lib/order.rb)
class Order
end

Repository classes
(in lib/item_repository.rb)
class ItemRepository
end

(in lib/order_repository.rb)
class OrderRepository
end


4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

Table name: items

Model class
(in lib/item.rb)

class Item
  attr_accessor :id, :item_name, :quantity, :orders
end

(in lib/order.rb)
class Order
  attr_accessor :id, :date, :customer_name, :item_id, :quantity
end

5. Define the Repository Class interface


Table name: items

Repository class
(in lib/item_repository.rb)

class ItemRepository

  # Selecting all records
  # No arguments

  def all
    # Executes the SQL query:
    sql = 'SELECT id, item_name, quantity FROM items;'
    result_set = DatabaseConnection.exec_params(sql, [])
    
    items = []

    result_set.each do |record|
      item = Item.new
      item.id = record['id']
      item.item_name = record['item_name']
      item.quantity = record['quantity']
      item.orders = record['orders']
      
      items << item
    end
    return items
  end

  def find_with_orders
    sql = 'SELECT items.id, items.item_name, orders.date, orders.customer_name FROM orders JOIN items ON orders.item_id = items.id WHERE items.id = $1;'
    result_set = DatabaseConnection.exec_params(sql, [])
    
    item = Item.new
    item.id = result_set[0]['id']
    item.item_name = result_set[0]['item_name']
    item.quantity = result_set[0]['quantity']
    item.orders = result_set[0]['orders']

    return item
  end

  def create(item)
    sql = 'INSERT INTO items (item_name, quantity) VALUES ($1, $2);    
    params = [item.item_name, item.quantity]

    result_set = DatabaseConnection.exec_params(sql, params)
  end
end

class OrderRepository

  # Selecting all records
  # No arguments

  def all
    # Executes the SQL query:

    sql = 'SELECT id, date, customer_name, item_id, quantity FROM orders;'
    result_set = DatabaseConnection.exec_params(sql, [])
    
    orders = []

    result_set.each do |record|
      order = Order.new
      order.id = record['id']
      order.date = record['date']
      order.customer_name = record['customer_name']
      order.item_id = record['item_id']
      order.quantity = record['quantity']

      orders << order
    end

    return orders
  end

  def create(order)
    sql = 'INSERT INTO orders (date, customer_name, item_id, quantity) VALUES ($1, $2, $3, $4);'
    params = [order.date, order.customer_name, order.item_id, order.quantity]

    result_set = DatabaseConnection.exec_params(sql, params)
  end
end
6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

# EXAMPLES

# 1
# Get all items

repo = ItemRepository.new

items = repo.all

items.length # =>  2

items[0].id # =>  1
items[0].item_name # =>  'Lego'
items[0].quantity # =>  '20'
items[0].orders # => orders as an array

items[1].id # =>  2
items[1].item_name # =>  'My Little Pony'
items[1].quantity # =>  '50'

# 1a find with orders
repo = ItemRepository.new

item = repo.find(1)

items[0].id # =>  1
items[0].item_name # =>  'Lego'
items[0].quantity # =>  '20'
items[0].orders # => orders as an array

# 2 create a new item

repo = ItemRepository.new

new_item = Item.new
new_item.item_name = 'Magformers'
new_item.item_quantity = 40


query = repo.create(new_item)

items = repo.all

items.length => 3

# 3 Get all orders

repo = OrderRepository.new

orders = repo.all

orders.length # =>  6

orders[0].id # =>  1
orders[0].date => '01/10/2022'
orders[0].customer_name # =>  'Hillary'
order[0].item_id => 2
orders[0].quantity # =>  '1'

orders[1].id # =>  1
orders[1].date => '02/10/2022'
orders[1].customer_name # =>  'Simone'
orders[1].item_id => 2
orders[1].quantity # =>  '1'

# 4 create a new order

repo = OrderRepository.new

order = Order.new
orders[.date => '06/11/2022'
orders.customer_name # =>  'Harry'
orders.item_id => 2
orders.quantity # =>  '4'

query = repo.create(order)

items = repo.all

items.length => 3

# 5 find all orders for a specific item

repo = ItemRepository.new

item = repo.find_with_orders(2)

item.name = 'My Little Pony'
item.quantity = '50'
item.orders.length = 2
item.orders.first.customer_name => 'Simone'


7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

# EXAMPLE

# file: spec/item_repository_spec.rb

def reset_items_table
  seed_sql = File.read('spec/seeds_items.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_test' })
  connection.exec(seed_sql)
end

describe ItemsRepository do
  before(:each) do 
    reset_items_table
  end

# file: spec/order_repository_spec.rb

def reset_orders_table
  seed_sql = File.read('spec/seeds_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_test' })
  connection.exec(seed_sql)
end

describe ItemsRepository do
  before(:each) do 
    reset_orders_table
  end


  # (your tests will go here).
end
8. Test-drive and implement the Repository class behaviour

After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.