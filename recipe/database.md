Items-Orders Model and Repository Classes Design Recipe

1. Design and create the Table

see ./schema.md

2. Create Test SQL seeds

-- (file: spec/seeds_items_orders.sql)

TRUNCATE TABLE items, orders, items_orders RESTART IDENTITY;

INSERT INTO items (product, price, quantity) VALUES ('Apple', 1, 100);
INSERT INTO items (product, price, quantity) VALUES ('Banana', 2, 50);
INSERT INTO items (product, price, quantity) VALUES ('Canteloupe', 3, 20);

INSERT INTO orders (customer, date) VALUES ('Andy', 2022-01-01);
INSERT INTO orders (customer, date) VALUES ('Barry', 2022-02-02);
INSERT INTO orders (customer, date) VALUES ('Carl', 2022-03-03);

INSERT INTO items_orders (item_id, order_id) VALUES (1,1);
INSERT INTO items_orders (item_id, order_id) VALUES (2,1);
INSERT INTO items_orders (item_id, order_id) VALUES (3,1);
INSERT INTO items_orders (item_id, order_id) VALUES (2,2);
INSERT INTO items_orders (item_id, order_id) VALUES (3,2);
INSERT INTO items_orders (item_id, order_id) VALUES (3,3);

psql -h 127.0.0.1 your_database_name < seeds_items_orders.sql

3. Define the class names

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

4. Implement the Model class

# Table name: items

# Model class
# (in lib/item.rb)

class Item
  attr_accessor :id, :product, :price, quantity
end

# Table name: irders

# Model class
# (in lib/order.rb)

class Order
  attr_accessor :id, :customer, :date
end

5. Define the Repository Class interface

# Table name: items

# Repository class
# (in lib/item_repository.rb)

class ItemRepository

  # Selecting all items
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT * FROM items;

    # Returns an array of Item objects.
  end

  # Create a new item
  # One argument:item - an instance of the Item class
  def add(item)
    # Executes the SQL query:
    # INSERT INTO items (product, price, quantity) VALUES ($1, $2, $3)

    # Returns nothing
  end
end

# Table name: orders

# Repository class
# (in lib/order_repository.rb)

class OrderRepository

  # Selecting all orders
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT orders.id, orders.customer, orders.date, item_id 
      FROM orders
      JOIN items_orders ON items_orders.order_id = orders.id;

    # Returns an array of Order objects.
  end

  # Create a new order
  # Two argument: info, items - info is an instance of the Order class, Items in an array of items.id
  def add(info, items)
    # Executes the SQL query:
    # INSERT INTO orders (customer, date) VALUES ($1, $2);

    # INSERT INTO items_orders (item_id, order_id) VALUES ($1, $2)

    # Returns nothing
  end
end

6. Write Test Examples

# 1
# Get all items

repo = ItemRepository.new

items = repo.all

items.length # =>  3

items[0].id # =>  1
items[0].product # =>  'Apple'
items[0].price # =>  1
items[0].quantity # => 100

items[1].id # =>  2
items[1].product # =>  'Banana'
items[1].price # =>  2
items[1].quantity # => 50

# 2
# Add a new item

repo = ItemRepository.new

item = Item.new
item.product = 'Damsen'
item.price = 5
item.quantity = 10
repo.add(item)

items = repo.all

items[-1].id # =>  4
items[-1].product # =>  'Damsen'
items[-1].price # =>  5
items[-1].quantity # => 10

# 3
# List all orders

repo = OrderRepository.new

orders = repo.all

orders.length # => 6

orders[0].id # => '1'
orders[0].customer # => 'Andy'
orders[0].date # => '2022-01-01'
orders[0].item_id # => '1'

orders[1].id # => '1'
orders[1].customer # => 'Andy'
orders[1].date # => '2022-01-01'
orders[1].item_id # => '2'


7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_items_table
  seed_sql = File.read('spec/seeds_items.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'items' })
  connection.exec(seed_sql)
end

describe StudentRepository do
  before(:each) do 
    reset_items_table
  end

  # (your tests will go here).
end
8. Test-drive and implement the Repository class behaviour

After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.

