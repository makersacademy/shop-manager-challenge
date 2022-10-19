# Orders Model and Repository Classes Design Recipe

## 1. The Table

```
Table: items

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
# Table name: order

# Model class
# (in lib/order.rb)

class Item
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
  def create(order)
    # Executes the SQL query:
    # INSERT INTO orders (order_date, customer_name)
    # VALUES ($1, $2);
    
    # Returns nil
  end

end
```

## 6. Test Examples

These examples will later be encoded as RSpec tests.

```ruby
# 1
# Get all items

repo = OrderRepository.new

orders = repo.all

orders.length # =>  3

orders.first.id # =>  1
orders.first.order_date # =>  'item_1'
orders.first.customer_name # =>  2.99
orders.first.quantity # =>  2

orders.last.id # =>  3
orders.last.item # =>  'item_3'
orders.last.unit_price # =>  5.49
orders.last.quantity # =>  3

# 2
# Get a single student

repo = ItemRepository.new

item = repo.find(2)

items.id # =>  2
items.item # =>  'item_2'
items.unit_price # =>  3.99
items.quantity # =>  5

# 3
# Create a new item

item_to_create = Item.new
item_to_create.item = 'item_4'
item_to_create.unit_price = 6.99
item_to_create.quantity = 10

repo = ItemRepository.new
number_of_items = repo.all.length

repo.create(item_to_create)

repo.all.length # =>  number_of_items + 1
repo.all # => It will include the new item
```