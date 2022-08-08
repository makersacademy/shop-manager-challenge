1. Design and creat the Table

Completed.

2. Create Test SQL seeds

TRUNCATE TABLE items, orders, items_orders RESTART IDENTITY;

INSERT INTO items (name, unit_price, quantity) VALUES ('Bananas', 1.00, 5);
INSERT INTO items (name, unit_price, quantity) VALUES ('Pasta', 2.00, 10);
INSERT INTO items (name, unit_price, quantity) VALUES ('Fish', 4.00, 8);
INSERT INTO orders (customer_name, date) VALUES ('Sophie', '2022-08-05 12:00:00');
INSERT INTO orders (customer_name, date) VALUES ('Mabon', '2022-08-04 11:00:00');
INSERT INTO orders (customer_name, date) VALUES ('Sophie', '2022-08-03 15:00:00');
INSERT INTO items_orders(item_id, order_id) VALUES (1, 2);
INSERT INTO items_orders(item_id, order_id) VALUES (1, 1);
INSERT INTO items_orders(item_id, order_id) VALUES (1, 3);
INSERT INTO items_orders(item_id, order_id) VALUES (2, 1);
INSERT INTO items_orders(item_id, order_id) VALUES (2, 2);
INSERT INTO items_orders(item_id, order_id) VALUES (3, 2);
INSERT INTO items_orders(item_id, order_id) VALUES (3, 3);

3. Define the class names

class Item
end

class ItemRepository
end

class Order
end

class OrderRepository
end

4. Implement the model class

class Item
attr_accessor :id, :name, :unit_price, :quantity, :orders
end

class Order
attr_accessor :id, :customer_name, :date, :items
end

5. Define the Repository class interface

class ItemRepository

  def all
  #Executes the SQL query
  SELECT * FROM items;
  #Returns an array of shop items
  end

  def create()
    #Executes the SQL query
    'INSERT INTO items
    (name, unit_price, quantity)
    VALUES('milk', $1.50, 20);'
    #Returns nil, creates a new item object
  end

end

class OrderRepository
  def all
  #Executes the SQL query
  SELECT * FROM orders;
  #Returns an array of shop orders
  end
  
  def create()
  #Executes the SQL query
  'INSERT INTO orders
    (customer_name, date)
    VALUES('Tigi', '2022-08-05 12:00:00');'
    #Returns nil, creates a new order object
  end

  def show_your_order(order_id)
    #Executes the SQL query
    SELECT orders.id AS order_id, orders.customer_name, items.id AS item_id, items.name, items.unit_price
    FROM orders
    JOIN items_orders ON items_orders.order_id = orders.id
    JOIN items ON items_orders.item_id = items.id
    WHERE orders.customer_name = $1;'
    #Returns the customer's order and item details
  end
end

6. Write Test examples

#Examples

#Items
#Get all shop items

repository = ItemRepository.new
items = repository.all
items.length # => 3
items[0].id # => 1
items[0].name # => 'Bananas'
items[0].unit_price # -> $1.00
items[0].quantity # => 5

items[-1].id # => 3
items[-1].name # => Fish
items[-1].unit_price # -> $4.00
items[-1].quantity # => 8

#Create new shop item

repository = ItemRepository.new
item = Item.new
item.name # => 'Milk'
item.unit_price # => $1.50
item.quantity # => 20

repository.create(item) # => return nil

all_items = repository.all
last_item = all_items.last
last_item.name # =>'Cereal'
last_item.unit_price # => $2.50
last_item.quantity # => 15



#Orders

#Get all shop orders

repository = OrderRepository.new
orders = repository.all
orders.length # => 3
orders[0].id # => 1
orders[0].customer_name # => 'Sophie'
orders[0].date # -> '2022-08-07 16:00:00'

#Create new shop order

repository = OrderRepository.new
order = Order.new
order.customer_name # => 'Tigi'
order.date # => '2022-08-07 16:00:00'

repository.create(order) # => return nil

all_orders = repository.all
last_order = all_orders.last
last_order.customer_name # =>'Tigi'
last_order.date # => '2022-08-07 16:00:00'


#Get all shop orders


7. Reload SQL seeds before each test run

def reset_students_table
  seed_sql = File.read('spec/seeds_students.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'students' })
  connection.exec(seed_sql)
end

describe StudentRepository do
  before(:each) do 
    reset_students_table
  end

  # (your tests will go here).
end

8. Test-drive and implement the Repository class behaviour
TDD process