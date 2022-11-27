# Item Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

```
Table: orders

Columns:
id | customer_name | date_placed
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- (file: spec/seeds_orders.sql)
TRUNCATE TABLE items RESTART IDENTITY CASCADE;
TRUNCATE TABLE orders RESTART IDENTITY CASCADE;

INSERT INTO items (name, unit_price, quantity) VALUES
('Hammer', 5.99, 20),
('Duct Tape', 2.50, 50),
('Nails (0.5kg)', 4.50, 50),
('Drill', 49.99, 7);

INSERT INTO orders (customer_name, date_placed) VALUES
('Customer One', '2022-01-01'),
('Customer Two', '2022-01-02'),
('Customer Three', '2022-01-02'),
('Customer One', '2022-01-03'),
('Customer Four', '2022-01-07'),
('Customer Four', '2022-01-08');

INSERT INTO items_orders (item_id, order_id) VALUES
(1,1),
(3,1),
(4,1),
(1,2),
(4,3),
(2,4),
(2,5),
(1,6),
(3,6);

ALTER TABLE items_orders ADD FOREIGN KEY (item_id) REFERENCES items(id);
ALTER TABLE items_orders ADD FOREIGN KEY (order_id) REFERENCES orders(id);
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 shop_manager_test < spec/seeds_orders.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

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

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# Table name: orders

# Model class
# (in lib/order.rb)

class Order
  attr_accessor :id, :customer_name, :date_placed, :items

  def initialize
    @items = []
  end
end
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# Table name: orders

# Repository class
# (in lib/order_repository.rb)

class OrderRepository

  # Selecting all items
  def all
    # Executes the SQL query:
    # SELECT id, customer_name, date_placed FROM orders;

    # Returns an array of Order objects.
  end

  # Adds new order to list
  # order is an instance of the Order class
  # item_ids is an array of integers: the ids of the items to add
  def create(order, item_ids)
    # Executes the SQL query:
    # INSERT INTO orders (id, customer_name, date_placed) VALUES ($1, $2, $3);
    # INSERT INTO items_orders (item_id, order_id) VALUES (...)

    # Returns nothing
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# 1
# Gets all orders
order_repo = OrderRepository.new
orders = order_repo.all

orders.length # => 6

orders.first.id # => 1
orders.first.customer_name # => "Customer One"
orders.first.date_placed # => "2022-01-01"

orders.last.id # => 6
orders.last.customer_name # => "Customer Four"
orders.last.date_placed # => "2022-01-08"

# 2
# Create adds an order with items to the database
order_repo = OrderRepository.new
item_repo = ItemRepository.new

new_order = Order.new
new_order.id = 7
new_order.customer_name = "Customer Five"
new_order.date_placed = "2022-01-08"
item_ids = [2,3]
order_repo.create(new_order, item_ids)

order_repo.all # => Contains the new element
item_repo.find_with_order(7) # => Contains items 2 and 3

# 3
# Create fails when trying to add an order with an order id already being used
order_repo = OrderRepository.new
item_repo = ItemRepository.new

new_order = Order.new
new_order.id = 3
new_order.customer_name = "Customer Five"
new_order.date_placed = "2022-01-08"
item_ids = [2,3]
order_repo.create(new_order, item_ids) # => fails

# 4
# Create fails when trying to add an order with items that don't exist
order_repo = OrderRepository.new

new_order = Order.new
new_order.id = 7
new_order.customer_name = "Customer Five"
new_order.date_placed = "2022-01-08"

fake_item_id = 5
order_repo.create(new_order, [fake_item_id]) # => fails

# 5
# Create fails when trying to create an order without items
order_repo = OrderRepository.new

new_order = Order.new
new_order.id = 7
new_order.customer_name = "Customer Five"
new_order.date_placed = "2022-01-08"

order_repo.create(new_order, []) # => fails
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# file: spec/item_repository_spec.rb

def reset_item_table
  seed_sql = File.read('spec/seeds_items.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_item_table
  end
end
```