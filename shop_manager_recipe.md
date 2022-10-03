Social Media Model and Repository Classes Design Recipe

1. Design and create the Table

(see 'Many-t-many table Design recipe.md')

2. Create Test SQL seeds

(file: spec/seeds.sql)

TRUNCATE TABLE items, orders RESTART IDENTITY;

INSERT INTO items (id, name, price, quantity) VALUES 
(1, 'Bread', '1.00', '10'),
(2, 'Milk', '2.00', '5'),
(3, 'Tea', '1.50', '12'),
(4, 'Sugar', '0.90', '4');
INSERT INTO orders (id, customer, date) VALUES 
(1, 'customer_1', '01-01-2022'),
(2, 'customer_2', '02-01-2022'),
(3, 'customer_3', '03-01-2022');
INSERT INTO items_orders (item_id, order_id) VALUES 
(1, 1),
(1, 2),
(1, 3),
(2, 1),
(2, 2),
(2, 3),
(3, 2),
(3, 3),
(4, 1),
(4, 3);

ALTER TABLE "items_orders" ADD FOREIGN KEY ("order_id") REFERENCES "orders"("id");
ALTER TABLE "items_orders" ADD FOREIGN KEY ("item_id") REFERENCES "items"("id");

psql -h 127.0.0.1 shop_manager < seeds.sql
psql -h 127.0.0.1 shop_manager_test < seeds.sql

3. Define the class names

Table name: items

Model class # (in lib/item.rb)

class Item
end

Repository class # (in lib/item_repository.rb)

class ItemRepository
end

Table name: orders

Model class # (in lib/order.rb)

class Order
end

Repository class # (in lib/order_repository.rb)

class OrderRepository
end

Table name: items_orders

Model class # (in lib/item_order.rb)

class ItemOrder
end

Repository class # (in lib/item_order_repository.rb)

class ItemOrderRepository
end

4. Implement the Model class
Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

Table name: items

Model class # (in lib/item.rb)

class Item

  attr_accessor :id, :name, :price, :quantity
end

Table name: orders

Model class # (in lib/order.rb)

class Order

  attr_accessor :id, :customer, :date
end

class ItemOrder

  attr_accessor :item_id, :order_id


5. Define the Repository Class interface
Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

Table name: items

# Repository class (in lib/item_repository.rb)

class ItemRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT name, price, quantity FROM items;

    # Returns an array of item objects.
  end

  # Selecting a single record
  # item id as argument
  def find(id)
    # Executes the SQL query:
    # SELECT name, price, quantity FROM items WHERE id = $1;

    # Returns an single item object.
  end

  # inserting a new record with instance of Item class as argument
  def create(item)
    # Executes the SQL query:
    # INSERT INTO items (name, price, quantity) VALUES ($1, $2, $3)
    # Returns nothing.
  end

    # updates a record with instance of Item class as argument
  def update(item)
    # Executes the SQL query:
    # UPDATE items SET quantity = $1
    # Returns nothing.
  end
end

Table name: orders

# Repository class (in lib/order_repository.rb)

class OrderRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT customer, date FROM orders;

    # Returns an array of Order objects.
  end

  # finding one record with id as argument
  def find(id)
    # Executes the SQL query:
    # SELECT customer, date FROM orders WHERE id = $1;

    # Returns a single Order object.
  end

  # inserting a new record with instance of Order class as argument
  def create(order)
    # Executes the SQL query:
    # INSERT INTO orders (customer, date) VALUES ($1, $2)
    # Returns nothing.
  end
end

6. Write Test Examples

  1 = list all shop items
  2 = create a new item
  3 = list all orders
  4 = create a new order

# 1
# lists all shop items

repo = ItemRepository.new

items = repo.all
items.length # => 4
items[0].name # => 'Bread'
items[0].price # => '1.00'
items[0].quantity # => '10'

# 2
# Find an item

repo = ItemRepository.new

item = repo.find(1)
items.name # => 'Bread'
items.price # => '1.00'
items.quantity # => '10'

# 3
# Create a new item

repo = itemRepository.new
new_item = Item.new
new_item.name = 'Biscuits'
new_item.price = '0.50'
new_item.quantity = 5
    
repo.create(new_item) # => nil

items = repo.all
last_item = items.last
last_item.name # => 'biscuits'
last_item.price = '0.50'
last_item.quantity = 5

# 4
# Update an item
repo = ItemRepository.new

item = repo.find(1)
item.quantity -= 1
repo.update(item.quantity)

items = repo.all
items[0].quantity # => '9'

# 5
# lists all customer orders

repo = OrderRepository.new

orders = repo.all
orders.length # => 3
orders[0].customer # => 'customer_1'
orders[0].date # => '01-01-2022'
orders[2].customer # => 'customer_3'
orders[2].date # => '03-01-2022'

# 2
# finds an order

repo = OrderRepository.new

order = repo.find(1)
order.customer # => 'customer_1'
order.date # => '2022-01-01'

# 3
# creates a new order

repo = OrderRepository.new
new_order = Order.new
new_order.customer = 'customer_4'
new_order.date = '2022-04-01'
    
repo.create(new_order) # => nil

orders = repo.all
last_order = orders.last
last_order.customer # => 'customer_4'
last_order.date = '2022-04-01'

# 4
# Update an item
repo = ItemRepository.new

item = repo.find(1)
item.quantity -= 1
repo.update(item.quantity)

items = repo.all
items[0].quantity # => '9'


7. Reload the SQL seeds before each test run
Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

# file: spec/item_repository_spec.rb

def reset_items_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_items_table
  end

# file: spec/order_repository_spec.rb

def reset_orders_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe OrderRepository do
  before(:each) do 
    reset_orders_table
  end

  # (your tests will go here).
end


8. Test-drive and implement the Repository class behaviour
After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.