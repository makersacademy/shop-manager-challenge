# Orders Model and Repository Classes Design Recipe

## 1. The Table

```
Table: orders

Columns:
id | order_date | customer_name
```

## 2. SQL seeds

```sql
TRUNCATE TABLE orders RESTART IDENTITY CASCADE; -- 

INSERT INTO orders (order_date, customer_name) VALUES ('2022-10-15', 'customer_1');
INSERT INTO orders (order_date, customer_name) VALUES ('2022-10-16', 'customer_2');
INSERT INTO orders (order_date, customer_name) VALUES ('2022-10-18', 'customer_3');
```

## 3. Class names

```ruby
# Table name: orders

# Model class
# (in lib/order.rb)
class Order
end

# Repository class
# (in lib/order_repository.rb)
class OrderRepository
end
```

## 4. Model class

```ruby
# Table name: orders

# Model class
# (in lib/order.rb)

class Order
  attr_accessor :id, :order_date, :customer_name
end
```

## 5. Repository Class interface


```ruby
# Table name: orders

# Repository class
# (in lib/order_repository.rb)

class OrderRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT * FROM orders;

    # Returns an array of Order objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT * FROM orders WHERE id = $1;

    # Returns a single Order object.
  end

  # Add a new record to the table
  # One argument: Order (object)
  def create(order)
    # Executes the SQL query:
    # INSERT INTO orders (order_date, customer_name)
    # VALUES ($1, $2);
    
    # Returns id of the new object
  end
  
  # Join table query
  # One argument: item id (number)
  def find_by_item(item_id)
    # Execute the SQL query:
    # SELECT orders.id, orders.order_date, orders.customer_name FROM orders
    # JOIN items_orders ON items_orders.order_id = orders.id
    # JOIN items ON items_orders.item_id = items.id
    # WHERE items.id = $1;
    
    # Returns an array of Order objects
  end
  
  # Link records in Join table
  # Two arguments: item id (number), order id (number)
  def assign_order_to_item(order_id item_id)
    # Execute the SQL query:
    # INSERT INTO items_orders (item_id, order_id) VALUES ($1, $2)
    
    # Returns nil
  end
end
```

## 6. Test Examples

These examples will later be encoded as RSpec tests.

```ruby
# 1
# Get all orders

repo = OrderRepository.new

orders = repo.all

orders.length # =>  6

orders.first.id # =>  1
orders.first.order_date # =>  '2022-10-10'
orders.first.customer_name # =>  'customer_1'
orders.last.id # =>  6
orders.last.order_date # =>  '2022-10-09'
orders.last.customer_name # =>  'customer_6'

# 2
# Get a single order

repo = OrderRepository.new

repo = OrderRepository.new

found_order = repo.find(5)

found_order.id = #=>  5
found_order.order_date = #=>  '2022-10-17'
found_order.customer_name = #=>  'customer_5'

# 3
# Create a new order

new_order = Order.new
new_order.order_date = '2022-10-19'
new_order.customer_name = 'new_customer'

repo = OrderRepository.new
number_of_orders = repo.all.length

repo.create(new_order)

repo.all.length # =>  number_of_orders + 1
repo.all # => It will include the new order

# 4
# Find by item

repo = OrderRepository.new
orders = repo.find_by_item(2)

orders.length # =>  3
orders.first.id # =>  4
orders.first.order_date # =>  '2022-10-11'
orders.first.customer_name # =>  'customer_4'

# 5
# Assign order to an item

repo = OrderRepository.new
new_order = Order.new

item_id_to_link = 1
order_to_link = repo.find(3)

repo.assign_order_to_item(order_to_link.id, item_id_to_link)

orders = repo.find_by_item(item_id_to_link)
      
orders # => it will include linked item
```