# {{items & orders}} Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

```
| Tables                | Columns             |
| --------------------- | ------------------  |
| items                 | item_name, unit_price, quantity
| orders                | customer_name, order_date, item_id

```

## 2. Create Test SQL seeds

```sql
-- (file: schema/items_orders_seeds.sql)
-- needs to truncate orders first as sql can't truncate a table (items) referenced in a foreign key constraint
TRUNCATE TABLE items, orders RESTART IDENTITY;

INSERT INTO items (item_name, unit_price, quantity) 
VALUES ('Jollof rice', 5.50, 200),
       ('Playstation 5', 479.99, 30),
       ('Standing desk', 200, 400),
       ('Cereal', 3.20, 500);

INSERT INTO orders (customer_name, order_date, item_id) 
VALUES ('Sasuke Uchiha', '2023-03-04', 4),
       ('Ross Geller', '1999-10-10', 1),
       ('Monica Geller', '1997-10-10', 1),
       ('Ted Moseby', '2006-10-10', 3), 
       ('Barney Stintson', '2007-05-27', 2);
```

```bash
psql -h 127.0.0.1 shop < schema/items_orders_seeds.sql
psql -h 127.0.0.1 shop_test < schema/items_orders_seeds.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
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
```

## 4. Implement the Model classes

```ruby
# Table name: items

# Model class
# (in lib/item.rb)
class Item
  attr_accessor :id, :item_name, :unit_price, :quantity
end

# Table name: orders

# Model class
# (in lib/order.rb)
class Order
  attr_accessor :customer_name, :order_date, :item_id
end
```

## 5. Define the Repository Class interfaces

```ruby

# Table name: items

# Repository class
# (in lib/item_repository.rb)

class ItemRepository
  # Creates instance varaible for kernel
  def initialize(terminal_io) # One argument - double
    # instance variable for terminal_io
  end

  # Selecting all records
  # No arguments
  def list_all_items
    # Executes the SQL query:
    # SELECT * FROM items;

    # Returns an array of Item objects.
  end

  # Creates a new item and inserts it into items table
  # No arguments
  def create_new_item
    # Use gets to prompt user for necessary item attributes
    # Once item is created executes the SQL query:
    # INSERT INTO items (item_name, unit_price, quantity) VALUES($1, $2, $3);
    # Put string showing successful completion

    # Returns nothing
  end
end

class OrderRepository

  # Creates instance varaible for kernel
  def initialize(terminal_io) # One argument - double
    # instance variable for terminal_io
  end

  # Selecting all records
  # No arguments
  def list_all_orders
    # Executes the SQL query:
    # SELECT * FROM orders;

    # Returns an array of order objects.
  end

  # Creates a new order and inserts it into orders table
  # No arguments
  def create_new_order
    # Use gets to prompt user for necessary order attributes
    # Once order is created executes the SQL query:
    # INSERT INTO orders (customer_name, order_date, item_id) VALUES($1, $2, $3);
    # Put string showing successful completion

    # Returns nothing
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# file: spec/item_repository_spec.rb

# Before hook
  @repo = ItemRepository.new

# 1
# lists all shop items

items = @repo.list_all_items

items.length # =>  4

items[0].id # =>  1
items[0].item_name # =>  'Jollof rice'
items[0].unit_price # =>  5.50
items[0].quantity # =>  200

items[1].id # =>  2
items[1].item_name # =>  'Playstation 5'
items[1].unit_price # =>  479.99
items[1].quantity # =>  30

# 2
# creates a new item
terminal_io = double :terminal_io

# What is the name of the item?
terminal_io # expect to receive :gets and return 'Samsung Galxy Fold 6' ordered

# What is the unit price of #{item_name}?
terminal_io # expect to receive :gets and return 1649

# How many #{item_name} items do you have?
terminal_io # expect to receive :gets and return 900

new_item = @repo.create_new_item
all_items = @repo.list_all_items

all_items # => includes have_attributes of new_item


# file: spec/order_repository_spec.rb

# Before hook
  @repo = OrderRepository.new

# 1
# lists all orders

orders = @repo.list_all_orders

orders.length # =>  5

orders[2].id # =>  3
orders[2].customer_name # =>  'Monica Geller'
orders[2].order_date # =>  '1997-10-10'
orders[2].item_id # =>  1

orders[3].id # =>  4
orders[3].customer_name # =>  'Ted Moseby'
orders[3].order_date # =>  '2006-10-10'
orders[3].item_id # =>  3

# 2
# creates a new order

terminal_io = double :terminal_io

# What is the name of the customer?
terminal_io # expect to receive :gets and return 'Samuel Badru' ordered

# What is the order date (YYYY-MM-DD format)?
terminal_io # expect to receive :gets and return 2023-09-27

# What is the item id for this order?
terminal_io # expect to receive :gets and return 4

new_order = @repo.create_new_order
all_orders = @repo.list_all_orders

all_orders # => includes have_attributes of new_order
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

```ruby

# file: spec/item_repository_spec.rb

def reset_items_table
# may need to reference differently as seed is in schema instead of spec
  seed_sql = File.read('schema/items_orders_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'items' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before do 
    reset_items_table
    @repo = ItemRepository.new
  end

  # (your tests will go here).
end


# file: spec/order_repository_spec.rb

def reset_orders_table
  seed_sql = File.read('schema/items_orders_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'orders' })
  connection.exec(seed_sql)
end

describe OrderRepository do
  before do 
    reset_orders_table
    @repo = OrderRepository.new
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._

