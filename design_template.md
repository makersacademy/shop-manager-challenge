SHOP MANAGER Model and Repository Classes Design Recipe

As a shop manager
So I can know which items I have in stock
I want to keep a list of my shop items with their name and unit price.

As a shop manager
So I can know which items I have in stock
I want to know which quantity (a number) I have for each item.

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

As a shop manager
So I can manage orders
I want to be able to create a new order.

Nouns:

item_name, item_price, item_quantity, order, order_date, customer_name

1. Design and create the Tables

Table: customers

Columns:
id | customer_name

Table: items

Columns:
id | item_name | item_price | item_quantity

Table: orders

Columns:
id | order_date | item_id | customer_id

foreign keys => item_id, customer_id

2. Create Test SQL seeds

DB names: shop_manager, shop_manager_test

Original data:
-- (file: spec/seeds_init.sql)

CREATE TABLE customers (
    id SERIAL,
    customer_name TEXT
);

CREATE TABLE items (
    id SERIAL,
    item_name TEXT,
    item_price INT,
    item_quantity INT
);

CREATE TABLE orders (
    id SERIAL,
    order_date TIMESTAMP,
    item_id INT,
    customer_id INT,
    constraint fk_item foreign key(item_id) references items(id) on delete cascade,
    constraint fk_customer foreign key(customer_id) references customers(id) on delete cascade
);

psql -h 127.0.0.1 shop_manager < spec/seeds_init.sql # this is run once
psql -h 127.0.0.1 shop_manager_test < spec/seeds_init.sql # this is run once

-- (file: spec/seeds_shop_manager.sql)

INSERT INTO customers (customer_name) VALUES ('Customer1');
INSERT INTO customers (customer_name) VALUES ('Customer2');
INSERT INTO customers (customer_name) VALUES ('Customer3');

INSERT INTO items (item_name, item_price, item_quantity) VALUES ('Item1', 1, 5);
INSERT INTO items (item_name, item_price, item_quantity) VALUES ('Item2', 5, 50);
INSERT INTO items (item_name, item_price, item_quantity) VALUES ('Item3', 10, 25);
INSERT INTO items (item_name, item_price, item_quantity) VALUES ('Item4', 2, 100);
INSERT INTO items (item_name, item_price, item_quantity) VALUES ('Item5', 8, 70);

INSERT INTO orders (order_date, item_id, customer_id) VALUES ('05/03/2023', 2, 1);
INSERT INTO orders (order_date, item_id, customer_id) VALUES ('06/03/2023', 1, 1);
INSERT INTO orders (order_date, item_id, customer_id) VALUES ('07/03/2023', 1, 2);
INSERT INTO orders (order_date, item_id, customer_id) VALUES ('05/03/2023', 5, 2);
INSERT INTO orders (order_date, item_id, customer_id) VALUES ('08/03/2023', 4, 1);
INSERT INTO orders (order_date, item_id, customer_id) VALUES ('15/03/2023', 4, 2);

psql -h 127.0.0.1 shop_manager < spec/seeds_shop_manager.sql

Test data:
-- (file: spec/seeds_shop_manager_test.sql)

TRUNCATE TABLE customers RESTART IDENTITY;
INSERT INTO customers (customer_name) VALUES ('Customer1');
INSERT INTO customers (customer_name) VALUES ('Customer2');
INSERT INTO customers (customer_name) VALUES ('Customer3');

TRUNCATE TABLE items RESTART IDENTITY;
INSERT INTO items (item_name, item_price, item_quantity) VALUES ('Item1', 1, 5);
INSERT INTO items (item_name, item_price, item_quantity) VALUES ('Item2', 5, 50);
INSERT INTO items (item_name, item_price, item_quantity) VALUES ('Item3', 10, 25);
INSERT INTO items (item_name, item_price, item_quantity) VALUES ('Item4', 2, 100);
INSERT INTO items (item_name, item_price, item_quantity) VALUES ('Item5', 8, 70);

TRUNCATE TABLE orders RESTART IDENTITY;
INSERT INTO orders (order_date, item_id, customer_id) VALUES ('3/5/2023', 2, 1);
INSERT INTO orders (order_date, item_id, customer_id) VALUES ('3/6/2023', 1, 1);
INSERT INTO orders (order_date, item_id, customer_id) VALUES ('3/7/2023', 1, 2);
INSERT INTO orders (order_date, item_id, customer_id) VALUES ('3/5/2023', 5, 2);
INSERT INTO orders (order_date, item_id, customer_id) VALUES ('3/8/2023', 4, 1);
INSERT INTO orders (order_date, item_id, customer_id) VALUES ('3/15/2023', 4, 2);

psql -h 127.0.0.1 shop_manager_test < spec/seeds_shop_manager_test.sql

3. Define the class names

# Table name: customers

# Model class
# (in lib/customer_model.rb)
class Customer
end

# Repository class
# (in lib/customers_repository.rb)
class CustomersRepository
end

# Table name: items

# Model class
# (in lib/item_model.rb)
class Item
end

# Repository class
# (in lib/items_repository.rb)
class ItemsRepository
end

# Table name: orders

# Model class
# (in lib/orders_model.rb)
class Order
end

# Repository class
# (in lib/orders_repository.rb)
class OrdersRepository
end

4. Implement the Model class

Define the attributes of your Model classes. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

# Table name: customers

# Model class
# (in lib/customer_model.rb)

class Customer
  attr_accessor :id, :customer_name
end

# Table name: items

# Model class
# (in lib/item_model.rb)

class Item
  attr_accessor :id, :item_name, :item_price, :item_quantity
end

# Table name: orders

# Model class
# (in lib/order_model.rb)

class Order
  attr_accessor :id, :order_date, :item_id, :customer_id
end

5. Define the Repository Class interface

Your Repository classes will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

# Table name: customers
# Repository class
# (in lib/customers_repository.rb)

class CustomersRepository

  # Selecting all records
  # No arguments
  def all
    # SELECT id, customer_name FROM customers;
    # Returns an array of Customer objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # SELECT id, customer_name FROM customers WHERE id = $1;
    # Returns a single Customer object.
  end

   def create(customer)
    # INSERT INTO customers (customer_name) VALUES ($1);
    # Returns nil
   end

   def update(customer)
    # UPDATE customers SET customer_name = $1;
      # Returns nil
   end

   def delete(id)
    # DELETE FROM customers WHERE id = $1;
    # Returns nil
   end
end

# Table name: items
# Repository class
# (in lib/items_repository.rb)
class ItemsRepository

  # Selecting all records
  # No arguments
  def all
    # SELECT id, item_name, item_price, item_quantity FROM items;
    # Returns an array of Item objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # SELECT id, item_name, item_price, item_quantity FROM items WHERE id = $1;
    # Returns a single Item object.
  end

   def create(item)
    # INSERT INTO items (item_name, item_price, item_quantity) VALUES ($1, $2, $3);
    # Returns nil
   end

   def update(item)
    # UPDATE items SET item_name = $1, item_price = $2, item_quantity = $3;
      # Returns nil
   end

   def delete(id)
    # DELETE FROM items WHERE id = $1;
      # Returns nil
   end
end

# Table name: orders
# Repository class
# (in lib/orders_repository.rb)
class OrdersRepository

  # Selecting all records
  # No arguments
  def all
    # SELECT id, order_date, item_id, customer_id FROM orders;
    # Returns an array of Order objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # SELECT id, order_date, item_id, customer_id FROM orders WHERE id = $1;
    # Returns a single Order object.
  end

   def create(item)
    # INSERT INTO orders (order_date, item_id, customer_id) VALUES ($1, $2, $3);
    # Returns nil
   end

   def update(item)
    # UPDATE orders SET order_date = $1, item_id = $2, customer_id = $3;
      # Returns nil
   end

   def delete(id)
    # DELETE FROM orders WHERE id = $1;
      # Returns nil
   end
end

6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository classes, following your designs from the table written in step 5.

These examples will later be encoded as RSpec tests.

Customers Repository class
# 1
# Get all customers

repo = CustomersRepository.new
customers = repo.all
customers.length # =>  3
customers[0].customer_name # =>  'Customer1'

customers[1].customer_name # =>  'Customer2'

# 2
# Get a single customer

repo = CustomersRepository.new
customer = repo.find(2)
customer.id # =>  2
customer.customer_name # =>  'Customer2'

# 3
# Create a customer

repo = CustomersRepository.new
customer = Customer.new
customer.customer_name = 'Customer4'
repo.create(customer)
customers = repo.all
newest_customer = customers.last
newest_customer.id # =>  4

# 4
# Update a customer

repo = CustomersRepository.new
customer = repo.find(2)
customer.customer_name = 'Customer 2'
repo.update(customer)
repo.find(2) # => ('Customer 2')

# 5
# Delete a customer

repo = CustomersRepository.new
customers = repo.all
customers.create # => ('Customer4')
customers.create # => ('Customer5')
customers.delete # => removes Customer4
customers.length # =>  4

Item Repository class
# 1
# Get all items

repo = ItemsRepository.new
items = repo.all
items.length # =>  5
items[0].item_name # =>  'Item1'
items[0].item_price # =>  1
items[0].item_quantity # =>  5

items.last.id # =>  5
items.last.item_name # =>  'Item5'
items.last.item_price # =>  8
items.last.item_quantity # => 70

# 2
# Get a single item

repo = ItemsRepository.new
item = repo.find(1)
item.id # =>  1
item.item_name # =>  'Item1'
item.item_quantity # =>  5

# 3
# Create an item

repo = ItemsRepository.new
items = repo.all
items.create # => ('Item6', 3, 50)
items.create # => ('Item7', 16, 50)
items.length # =>  7

# 4
# Update an item

repo = ItemsRepository.new
item.update # => updates price for item2 to 6
item = repo.find(3) # => ('Item2',5, 50)
item.item_price # => 6

# 5
# Delete an item

repo = ItemsRepository.new
items = repo.all
items.create # => ('Item6', 3, 50)
items.create # => ('Item7', 16, 50)
items.delete # => removes Item6
items.length # =>  6

Orders Repository class
# 1
# Get all orders

repo = OrdersRepository.new
orders = repo.all
orders.length # =>  6
orders[0].id # =>  1
orders[0].order_date # =>  '03/05/2023'
orders[0].item_id # =>  2
orders[0].customer_id # =>  1

orders[1].id # =>  2
orders[1].order_date # =>  '03/06/2023'
orders[1].item_id # =>  1
orders[1].customer_id # =>  1

# 2
# Get a single order

repo = OrdersRepository.new
order = repo.find(3)
order.id # =>  3
order.order_date # =>  '03/07/2023'
order.customer_id # => 2

# 3
# Create an order

repo = OrdersRepository.new
order = Order.new
order.order_date = '03/11/2023'
order.item_id # => 3
order.customer_id # => 1
repo.create(order)
orders = repo.all
newest_order = orders.last
newest_order.id # =>  4

# 4
# Update an order

repo = OrdersRepository.new
order = repo.find(2)
order.order_date = '03/06/2023'
repo.update(order)
repo.find(2) # => ('03/06/2023', 1, 1)

# 5
# Delete an order

repo = OrdersRepository.new
orders = repo.all
order1 = Order.new
order1.order_date # => '03/08/2023'
order1.item_id # => 4
order1.customer_id # => 1

order2 = Order.new
order2.order_date # => '03/09/2023'
order2.item_id # => 5
order2.customer_id # => 2

orders.delete # => removes Order7
orders.length # =>  7

Encode each example as a test.

7. Reload the SQL seeds before each test run

# file: spec/customers_repository_spec.rb

def reset_customers_table
  seed_sql = File.read('spec/seeds_shop_manager_test.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager' })
  connection.exec(seed_sql)
end

  before(:each) do 
    reset_customers_table
  end

  # (your tests will go here).
end

# file: spec/items_repository_spec.rb

def reset_items_table
  seed_sql = File.read('spec/seeds_shop_manager_test.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

  before(:each) do 
    reset_items_table
  end

  # (your tests will go here).
end

# file: spec/orders_repository_spec.rb

def reset_orders_table
  seed_sql = File.read('spec/seeds_shop_manager_test.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

  before(:each) do 
    reset_orders_table
  end

  # (your tests will go here).
end

8. Test-drive and implement the Repository classes behaviour

After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.
