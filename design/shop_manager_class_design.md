shop_manager 

1. 
Records            |     Properties
- - - - - - - - - - - - - - - - - - - - - - - - - - - - 
items              |     id, name, unit_price, quantity
orders             |     id, customer_name, order_date
orders_by_items    |     id, item_id, order_id

2. 

# file: seeds_items.sql

TRUNCATE TABLE items RESTART IDENTITY;

INSERT INTO items (name, unit_price, quantity) VALUES ('corn', '1.5', '250');
INSERT INTO items (name, unit_price, quantity) VALUES ('peas', '1.75', '200');
INSERT INTO items (name, unit_price, quantity) VALUES ('lettuce', '2', '150');
INSERT INTO items (name, unit_price, quantity) VALUES ('carrot', '1.25', '500');
INSERT INTO items (name, unit_price, quantity) VALUES ('parsnip', '2.5', '50');

# file: seeds_orders.sql

TRUNCATE TABLE orders RESTART IDENTITY;

INSERT INTO orders (customer_name, order_date) VALUES ('Harry', '2023-03-04');
INSERT INTO orders (customer_name, order_date) VALUES ('Ron', '2023-03-05');
INSERT INTO orders (customer_name, order_date) VALUES ('Hermione', '2023-03-04');
INSERT INTO orders (customer_name, order_date) VALUES ('Albus', '2023-02-24');
INSERT INTO orders (customer_name, order_date) VALUES ('Severus', '2023-03-05');

# file: seeds_orders_by_items.sql

TRUNCATE TABLE orders_by_items RESTART IDENTITY;

INSERT INTO orders_by_items (item_id, order_id) VALUES ('1', '1');
INSERT INTO orders_by_items (item_id, order_id) VALUES ('2', '1');
INSERT INTO orders_by_items (item_id, order_id) VALUES ('4', '1');
INSERT INTO orders_by_items (item_id, order_id) VALUES ('5', '1');
INSERT INTO orders_by_items (item_id, order_id) VALUES ('3', '2');
INSERT INTO orders_by_items (item_id, order_id) VALUES ('3', '2');
INSERT INTO orders_by_items (item_id, order_id) VALUES ('1', '3');
INSERT INTO orders_by_items (item_id, order_id) VALUES ('3', '3');
INSERT INTO orders_by_items (item_id, order_id) VALUES ('2', '3');
INSERT INTO orders_by_items (item_id, order_id) VALUES ('4', '3');
INSERT INTO orders_by_items (item_id, order_id) VALUES ('2', '4');
INSERT INTO orders_by_items (item_id, order_id) VALUES ('5', '5');
INSERT INTO orders_by_items (item_id, order_id) VALUES ('2', '5');
INSERT INTO orders_by_items (item_id, order_id) VALUES ('3', '5');

3. 
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

# Table name: orders_by_items

# Model class
# (in lib/order_by_item.rb)
class OrderByItem
end

# Repository class
# (in lib/order_by_item_repository.rb)
class OrderByItemRepository
end

4. 
# Model class
# (in lib/item.rb)
class Item
  attr_accessor :id, :name, :unit_price, :quantity
end

# Model class
# (in lib/order.rb)
class Order
  attr_accessor :id, :customer_name, :order_date
end

# Model class
# (in lib/order_by_item.rb)
class OrderByItem
  attr_accessor :id, :item_id, :order_id
end

5. 

# Repository class
# (in lib/item_repository.rb)
class ItemRepository
  def initialize
  end

  def all
    # Executes the SQL query:
    # SELECT * FROM items;
    # Returns an array of Item objects.
  end

  def create_item(name, unit_price, quantity)
    # Executes the SQL query:
    # INSERT INTO items (name, unit_price, quantity) VALUES ('name', 'unit_price', 'quantity')
    # Returns nothing.
  end
end

# Repository class
# (in lib/order_repository.rb)
class OrderRepository
  def initialize
  end

  def all
    # Returns the customer order.
  end

  def create_order(customer_name, order_date)
    # Executes the SQL query:
    # INSERT INTO orders (customer_name, order_date) VALUES ('customer_name', 'order_date')
    # Returns nothing.
  end
end
end

# Repository class
# (in lib/order_by_item_repository.rb)
class OrderByItemRepository
  def initialize
  end

  def add_to_order
    # I'll come back to it.
    # 
    # Returns nothing
  end

  def customer_order
    # Executes the SQL query: 
    # SELECT * FROM orders_by_item WHERE order_id = $1;
    # Returns an array of Order objects.
  end
end

6.

# EXAMPLES

# 1. ItemRepository class.
# file: item_repository_spec.rb

# Get all items

repo = ItemRepository.new
items = repo.all

items.length # 5

items[0].id # 1
items[0].name # corn
items[0].unit_price # 1.5
items[0].quantity # 250

items[3].id # 4
items[3].name # carrot
items[3].unit_price # 1.25
items[3].quantity # 500

# Create a new item

repo = ItemRepository.new
repo.create_item('celery', '2.25', '125')

items[5].id # 6
items[5].name # celery
items[5].unit_price # 2.25
items[5].quantity # 125

# 2. OrderRepository class.
# file: order_repository_spec.rb

# Get all orders

repo = OrderRepository.new
orders = repo.all

orders.length # 5

orders[0].id # 1
orders[0].customer_name # Harry
orders[0].order_date # 2023-03-04

orders[3].id # 4
orders[3].customer_name # Albus
orders[3].order_date # 2023-02-24

# Create an order

repo = OrderRepository.new
repo.create_order('Voldemort', '2023-03-07')

orders[5].id # 6
orders[5].customer_name # Voldemort
orders[5].order_date # 2023-03-07

# 2. OrderByItemRepository class.
# file: order_by_items_repository_spec.rb

# Pull a list of items out and return it for appropriate order_id







