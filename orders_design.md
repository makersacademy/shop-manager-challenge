# {{orders}} Model and Repository Classes Design Recipe

## 1. Design and create the Table

Table already created

## 2. Create Test SQL seeds

```sql
-- (file: spec/seeds_items_orders.sql)

TRUNCATE TABLE items, orders, items_orders RESTART IDENTITY;

INSERT INTO items (name, unit_price, qty) VALUES ('Hoover', '100', '20');
INSERT INTO items (name, unit_price, qty) VALUES ('Washing Machine', '400', '30');
INSERT INTO items (name, unit_price, qty) VALUES ('Cooker', '389', '12');
INSERT INTO items (name, unit_price, qty) VALUES ('Tumble Dryer', '279', '44');
INSERT INTO items (name, unit_price, qty) VALUES ('Fridge', '199', '15');

INSERT INTO orders (customer_name, date_placed) VALUES ('Frank', '04-Jan-2021');
INSERT INTO orders (customer_name, date_placed) VALUES ('Benny', '05-Aug-2022');

INSERT INTO items_orders (item_id, order_id, item_qty) VALUES ('1', '1', '2');
INSERT INTO items_orders (item_id, order_id, item_qty) VALUES ('2', '1', '1');
INSERT INTO items_orders (item_id, order_id, item_qty) VALUES ('1', '2', '1');
INSERT INTO items_orders (item_id, order_id, item_qty) VALUES ('3', '2', '3');
```

```bash
psql -h 127.0.0.1 shop_manager < spec/seeds_items_orders.sql
```

## 3. Define the class names

```ruby
# Table name: orders

# Model class
# (in lib/order.rb)
class Order
end

# Repository class
# (in lib/order_repo.rb)
class OrderRepository
end
```

## 4. Implement the Model class

```ruby
# Table name: orders

# Model class
# (in lib/order.rb)

class Order
  attr_accessor :id, :customer_name, :date_placed
end
```

## 5. Define the Repository Class interface

```ruby
# Table name: orders

# Repository class
# (in lib/order_repo.rb)

class OrderRepository
  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT * FROM orders;

    # Returns an array of Order objects.
  end

  # Create an order
  # Takes an Order object and a list of items as arguments
  def create(order, items)
    # Executes the SQL query:
    # INSERT INTO orders (customer_name, date_placed)
    # VALUES ($1, $2);
    # params = [order.customer_name, order.date_placed]
    # Then for each item in list of items
      # INSERT INTO items_orders (item_id, order_id, item_qty)
      # VALUES ($1, $2, $3)
    # decrements stock of item
    # Returns nothing
  end

  # Fetch an order
  # Takes order id as an argument
  def find_order(id)
    # sql = 'SELECT * FROM orders
    #     WHERE id = $1'
    # returns order object
  end

  # Fetch an order with items
  # Takes order id as an argument
  def order_with_items(id)
    # sql = 'SELECT items.id, items.name, items.unit_price, items_orders.item_qty
    #   FROM items
    #     JOIN items_orders ON items_orders.item_id = items.id
    #     JOIN orders ON items_orders.order_id = orders.id
    #     WHERE orders.id = $1;'

    # returns an order object with items
  end

  # Update an order
  # Takes id of order to update and Order object as arguments
  def update(id, order)
    # Executes the SQL query:
    # UPDATE orders 
    # SET (customer_name, date_placed) = ($1, $2)
    # WHERE id = $3

    # params = [order.customer_name, order.date_placed, id]
    # Returns nothing
  end
end
```

## 6. Test Examples

```ruby

#1 Get all orders

repo = OrderRepository.new
orders = repo.all

orders.length # =>  2

orders[0].id # =>  1
orders[0].customer_name # =>  'Frank'
orders[0].date_placed # =>  '04-Jan-2021'

orders[1].id # =>  2
orders[1].customer_name # =>  'Benny'
orders[1].date_placed # =>  '05-Aug-2022'

#1.1 Find an order

repo = OrderRepository.new
order = repo.find_order(1)

order.id # => '1'
order.customer_name # =>  'Frank'
order.date_placed # =>  '04-Jan-2021'

#1.2 Find an order with items

repo = OrderRepository.new
order = repo.order_with_items(1)

order.id # => '1'
order.customer_name # =>  'Frank'
order.date_placed # =>  '04-Jan-2021'

order.items[0].name # => 'Hoover'
order.items[0].unit_price # => '100'
order.items[0].qty # => '2'

order.items[1].name # => 'Washing Machine'
order.items[1].unit_price # => '400'
order.items[1].qty # => '1'

#2 Create an order

order_repo = OrderRepository.new
item_repo = ItemRepository.new

order = Order.new
order.customer_name = 'Mary'
order.date_placed = '07-Aug-2022'
item = item_repo.find_item(4)
item.qty = 1
order.items << item
order_repo.create(order)

orders = order_repo.all
orders.length # => 3

orders[0].id # =>  1
orders[0].customer_name # =>  'Frank'
orders[0].date_placed # =>  '04-Jan-2021'

orders[2].id # =>  3
orders[2].customer_name # =>  'Mary'
orders[2].date_placed # =>  '07-Aug-2022'

mary_order = order_repo.order_with_items(3)
mary_order.items[0].name # => 'Washing Machine'
mary_order.items[0].unit_price # => '400'
mary_order.items[0].qty # => '1'

item_repo.find_item(4).qty # => '43'

#3 Update an order

repo = OrderRepository.new

order = Order.new
order.customer_name = 'Frank'
order.date_placed = '06-Aug-2022'

repo.update(1, order)
orders = repo.all.sort_by { |order| order.id.to_i }

orders.length # => 2

orders[0].id # =>  1
orders[0].customer_name # =>  'Frank'
orders[0].date_placed # =>  '06-Aug-2022'

orders[1].id # =>  2
orders[1].customer_name # =>  'Benny'
orders[1].date_placed # =>  '05-Aug-2022'
```

## 7. Reload the SQL seeds before each test run

```ruby

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
```

## 8. Test-drive and implement the Repository class behaviour

_Follow the test-driving process of red, green, refactor to implement the behaviour._
