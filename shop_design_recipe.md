1. Design and create the Table

Record	             Properties
items	             name, price, quantity
orders	             customer, order_date
items_orders         item_id, order_id

2. Create Test SQL seeds

-- (file: spec/seeds_shop.sql)

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


class Item
end


class ItemRepository
end

class Order
end

class OrderRepository
end

4. Implement the Model class

class Item
    attr_accessor :id, :name, :price, :quantity, :orders

    def initialize
    @orders = []
end

class Order
    attr_accessor :id, :customer, :order_date, :items

    def initialize
    @items = []
end

5. Define the Repository Class interface

class ItemRepository

  def all
    # Executes the SQL query:
    # 'SELECT id, name, price, quantity FROM items;'
    # Returns an array of Item objects.
  end

  def create(item)
    # 'INSERT INTO items (name, price, quantity) VALUES ($1, $2, $3);'
    # Returns nothing/nil, creates a new Item object
  end
    
  def find_by_order(id)
    # 'SELECT items.id, items.name, items.price, items.quantity,
       FROM items
       JOIN items_orders ON items_orders.item_id = items.id
       JOIN orders ON items_orders.order_id = orders.id
       WHERE orders.id = $1;'
    # Lists all items on a specific order
    end

class OrderRepository

def all
    # Executes the SQL query:
    # 'SELECT id, customer, order_date FROM orders;'
    # Returns an array of Order objects.
  end

  def create(order)
    # 'INSERT INTO orders (customer, order_date) VALUES ($1, $2);'
    # Returns nothing/nil, creates a new Item object
  end

  def find_by_order(id)
    # 'SELECT orders.id, orders.customer, orders.order_date,
       FROM orders
       JOIN items_orders ON items_orders.order_id = orders.id
       JOIN items ON items_orders.item_id = items.id
       WHERE items.id = $1;'
    # Lists all orders for a specific item
    end

6. Write Test Examples

#1 - get all items

repo = ItemRepository.new
items = repo.all
items.length # => 4
items.first.id # => 1
items.first.name # => 'Pen'
items.first.price # => '£1'
items.first.quantity # => '10'

#2 - creates new item

repo = ItemRepository.new
item = Item.new
item.name = 'Tippex'
item.price = '£3'
item.quantity = '7'

repo.create(item)

items = repo.all
last_item = items.last
last_item.name # => 'Tippex'
last_item.price # => '£3'
last_item.quantity # => '7'

#3 gets all items for a specific order(?)


#4 - get all orders

repo = OrderRepository.new
orders = repo.all
orders.length # => 5
orders.first.id # => 1
orders.first.customer # => 'Sam'
orders.first.order_date # => 'August'

#5 - creates new order

repo = OrderRepository.new
order = Order.new
order.customer = 'Roy'
order.order_date = 'July'

repo.create(order)

orders = repo.all
last_order = orders.last
last_order.customer # => 'Roy'
last_order.order_date # => 'July'

#6 gets all orders for a specific item(?)

7. Reload the SQL seeds before each test run

# file: spec/item_repository_spec.rb
# file: spec/order_repository_spec.rb

def reset_shop_table
  seed_sql = File.read('spec/seeds_shop.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_test' })
  connection.exec(seed_sql)
end

  before(:each) do 
    reset_shop_table
  end

end

8. Test-drive and implement the Repository class behaviour

After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.