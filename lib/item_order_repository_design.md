# Shop manager Model and Repository Classes Design Recipe

## 1. Design and create the Table

Table: items

Columns:
id | name | unit_price | quantity 

Table: orders

Columns:
id | customer_name | date_ordered

Table: items_orders

Columns: 
item_id | order_id

## 2. Create Test SQL seeds

```sql
--(file: spec/seeds_itmes.sql)
-- The table is emptied between each test run and resets the primary key
TRUNCATE items, orders, items_orders RESTART IDENTITY;

INSERT INTO  items (name, unit_price, quantity) VALUES('Tower Air Fryer', 55, 10);
INSERT INTO  items (name, unit_price, quantity) VALUES('Howork Stand Mixer', 54, 23);

INSERT INTO  orders (customer_name, date_ordered) VALUES('Tinky-winky', '2022-09-28');
INSERT INTO  orders (customer_name, date_ordered) VALUES('Dipsy', '2022-09-27');

INSERT INTO items_orders (item_id, order_id) VALUES(1, 1);
INSERT INTO items_orders (item_id, order_id) VALUES(2, 1);
INSERT INTO items_orders (item_id, order_id) VALUES(2, 2);
```
Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 items_orders_test < seeds_items.sql
```

## 3. Implement the Model class

```ruby
# Table name: items
# Model class in lib/item.rb
class Item
  attr_accessor :id, :name, :unit_price, :quantity
end

# Table name: orders
# Model class in lib/order.rb
class Order
  attr_accessor :id, :name, :customer_name, :date_ordered
end

```
## 4. Define the Repository class

```ruby
# Table name: items
# Model class in lib/item_repository.rb
class ItemRepository
  # select all shop items
  def all_item
    # Executes the SQL query: SELECT id, name, unit_price, quantity FROM items

    # returns an array of Item objects
  end
  
  # Insert a new item record
  # Take an Item object in argument
  def create(item)
    # Executes the SQL query: INSERT INTO items (name, unit_price, quantity) VALUES ($1, $2, $3);

    # return nothing
  end
end 

# Table name: orders
# Model class in lib/order_repository.rb
class OrderRepository
  # Select all shop orders
  def all_order
    # Executes the SQL query: SELECT orders.id, orders.customer_name, 
    #                       orders.date_ordered, items.name FROM orders
    #                       JOIN items_orders ON items_orders.order_id = orders.id
    #                       JOIN items ON items_orders.item_id = items.id
    #                       ORDER BY orders.id ASC;

    # returns an array of Order object with item name
  end
  
  # Insert a new order record
  # Take an Order object in argument
  def create(order)
    # Executes the SQL query: INSERT INTO orders (customer_name, date_ordered) VALUES ($1, $2);
                  
    # return nothing
  end
end

```
## 5. Write Test Examples

```ruby
  # 1
  # returns all item records 

  repository = ItemRepository.new
  all_items = repository.all_item
  
  all_items.length # => 2
  all_items.first.name # => 'Tower Air Fryer'
  all_items.first.unit_price # => 55
  all_items.first.quantity # => 10

  # 2
  # creates a new item record

  repository = ItemRepository.new
  item = Item.new
  item.name = 'Nescafe capsule coffe machine'
  item.unit_price = 78
  item.quantity = 3

  repository.create(item) # => nil

  all_items = repository.all
  
  # => It should returns all item records including the item record created

  # 3
  # Get all orders

  repository = OrderRepository.new
  all_orders = repository.all

  all_orders.first.customer_name # => 'Tinky-Winky'
  all_orders.first.date_ordered # => '2022-09-28'
  all_orders.first.items.name # => 'Tower Air Fryer'

  # 4
  # Cretes a new order record
  
  repository = OrderRepository.new

  order = Order.new
  order.customer_name = 'Olaf'
  order.date_ordered = '2022-09-30'
  order.items_orders.item_id = 1
  order.items_orders.order_id = 3
  repository.create(order) # => nil

  all_items = repository.all 
  # => it returns all order records including the record created
```

Encode this example as a test.

## 6. Reload the SQL seeds before each test run
```ruby
# EXAMPLE

# file: spec/item_repository_spec.rb

describe ItemRepository do
  def reset_items_table
    seed_sql = File.read('spec/seeds_items.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'items_orders_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_items_table
  end

  # (your tests will go here).
end
```

## 7. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._
