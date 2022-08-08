Model and Repository Classes Design Recipe
1. Design and create the Table
Table already created

2. Create Test SQL seeds
-- (file: spec/seeds_items_orders.sql)

TRUNCATE TABLE items, orders, items_orders RESTART IDENTITY;

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO items (name, price, quantity) VALUES ('iPhone', '700', '65');
INSERT INTO items (name, price, quantity) VALUES ('MacBookAir', '990', '22');
INSERT INTO items (name, price, quantity) VALUES ('MacBookAir Pro', '1200', '17');

INSERT INTO orders (customer_name, date_of_order) VALUES ('Evelina', '2022-07-25');
INSERT INTO orders (customer_name, date_of_order) VALUES ('Evelina', '2022-07-25');
INSERT INTO orders (customer_name, date_of_order) VALUES ('John', '2022-07-28');

psql -h 127.0.0.1 shop_manager_test < spec/seeds_items_orders.sql

3. Define the class names
# Table name: orders

# Model class
# (in lib/order.rb)
class Order
end

class Item
end

# Repository class
# (in lib/order_repo.rb)
class OrderRepository
end

class ItemRepository
end

4. Implement the Model class
# Table name: orders

# Model class
# (in lib/order.rb)

class Order
  attr_accessor :id, :customer_name, :date_of_order
end
class Item
  attr_accessor :id, :name, :price, :quantity
end
5. Define the Repository Class interface
# Table name: orders

# Repository class
# (in lib/order_repo.rb)

class OrderRepository/ItemsRepository
  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT * FROM orders; FROM items;

    # Returns an array of Order objects.
  end

  # Create an order
  # Takes an Order object and a list of items as arguments
  def create(order, items)
    # Executes the SQL query:
    # INSERT INTO orders (customer_name, date_of_order)
    # VALUES ($1, $2);
    # params = [order.customer_name, order.date_of_order]
    
      ## INSERT INTO items_orders (item_id, order_id)
      ## VALUES ($1, $2)
    # Returns nothing
  end

# Create an item
  # Takes an Order object and a list of items as arguments
  def create(order, items)
    # Executes the SQL query:
    # INSERT INTO item (name, price, quantity)
    # VALUES ($1, $2, $3);
    # params = [item.name, item_price, item_quantity]
    
      ## INSERT INTO items_orders (item_id, order_id)
      ## VALUES ($1, $2, $3)

    # Returns nothing
  end
  # Find an order
  # Takes order id as an argument
  def find_order(id)
    # sql = 'SELECT * FROM orders
    #     WHERE id = $1'
    # returns order object
  end

  # Find an item
  # Takes item id as an argument
  def find_item(id)
    # sql = 'SELECT * FROM items
    #     WHERE id = $1'
    # returns order object
  end

  # Join - order with items info
  # Takes order id as an argument
  def order_with_items(id)
    # sql = 'SELECT item.id,
    #   FROM items
    #     JOIN items_orders ON items_orders.item_id = items.id
    #     JOIN orders ON items_orders.order_id = orders.id
    #     WHERE orders.id = $1;'

    # returns an order with items
  end
end


6. Test Examples
#1 Get all orders

repository = OrderRepository.new
orders = repository.all

orders.length # =>  3

orders[0].id # =>  1
orders[0].customer_name # =>  'Evelina'
orders[0].date_of_order # =>  '2022-07-25'

orders[1].id # =>  2
orders[1].customer_name # =>  'John'
orders[1].date_of_order # =>  '2022-07-28'

Get all items

repository = OrderRepository.new
orders = repository.all

items.length # =>  3

items[0].id # =>  '1'
items[0].name # =>  'iPhone'
items[0].price # =>  '700'

items[0].id # =>  '2'
items[0].name # =>  'MacBookAir'
items[0].price # =>  '990'

#1.1 Find an order

repo = OrderRepository.new
order = repo.find_order(1)

order.id # => '1'
order.customer_name # =>  '
order.date_of_order # =>  '

#1.2 Find an order with items

repo = OrderRepository.new
order = repo.order_with_items(1)

order.id # => '1'
order.customer_name # =>  
order.date_of_order # =>  

order.items[0].name # => 
order.items[0].price # => '
order.items[0].quantity # => 

order.items[1].name # => 
order.items[1].price # => 
order.items[1].quantity
 # => 

#2 Create an order

order_repo = OrderRepository.new
item_repo = ItemRepository.new

order = Order.new
order.customer_name = 'Julia'
order.date_of_order = '2022-08-01'
item = item_repo.find_item(4)
item.quantity = 12
order.items << item
order_repo.create(order)

orders = order_repo.all
orders.length # => 4

orders[0].id # =>  1
orders[0].customer_name # =>  
orders[0].date_of_order # =>  

orders[2].id # =>  4
orders[2].customer_name # =>  "Julia"
orders[2].date_of_order # =>  "

item_repo.find_item(4).quantity # => 

#2 Create an item

#1 Get all items

repo = ItemRepository.new
items = repo.all

items.length # =>  3

items[0].id # =>  1
items[0].name # =>  ''
items[0].price # =>  ''
items[0].quantity


items[1].id # =>  2
items[1].name # =>  ''
items[1].price # =>  ''
items[1].quantity


#1.1 Find an item

repo = ItemRepository.new
item = repo.find_item(4)

item.id # => '4'
item.name # =>  ''
item.price # =>  ''
item.quantity


#2 Create an item

repo = ItemRepository.new

item = Item.new
item.name = ''
item.price = ''
item.quantity = ''

repo.create(item)
items = repo.all

items.length # => 4

items[0].id # =>  1
items[0].name # =>  ''
items[0].price # =>  ''
items[0].quantity
 # => ''

items[3].id # =>  6
items[3].name # =>  ''
items[3].price # =>  ''
items[3].quantity

7. Reload the SQL seeds before each test run
# file: spec/order_repo_spec.rb

def reset_tables
  seed_sql = File.read('spec/seeds_items_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager' })
  connection.exec(seed_sql)
end

describe OrderRepository do
  before(:each) do 
    reset_tables
  end

  # (tests will go here).
end