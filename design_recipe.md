# Shop Manager Model and Repository Classes Design Recipe

## 1. Design and create the Table

| Record                | Properties          |
| --------------------- | ------------------  |
| item                  | name, unit_price, quantity
| order                 | customer_name, date_placed

For more details see table_schema.md

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
TRUNCATE TABLE items, orders, items_orders RESTART IDENTITY;

INSERT INTO items (name, unit_price, quantity) VALUES 
('White Desk Lamp', 18, 12),
('Mahogani Dining Table', 235, 5),
('Oak Bookshelf', 80, 15),
('Oriental Rug', 139, 21),
('Aloe Vera Houseplant', 12, 150),
('Leather Sofa', 1699, 2);

INSERT INTO orders (customer_name, date_placed) VALUES
('John Treat', '2022-08-12'),
('Amelia Macfarlane', '2022-08-14'),
('Eleanor Borgate', '2022-09-02');

INSERT INTO items_orders (item_id, order_id) VALUES
(3, 1),
(4, 1),
(6, 1),
(1, 2),
(5, 3),
(1, 3),
(3, 3);
```


## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
class Item
end

class ItemRepository
end

class Order
end

class OrderRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
class Item
  attr_accessor :id, :name, :unit_price, :quantity
end

class Order
  attr_accessor :id, :customer_name, :date_placed, :items
end

```

## 5. Define the Repository Class interface

```ruby

class ItemRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, unit_price, quantity FROM items;

    # Returns an array of Item objects.
  end

  # Creates a new record
  def create(item)
    # Executes the SQL query:
    # INSERT INTO items (name, unit_price, quantity) VALUES ($1, $2, $3);

    # returns nil
  end  

end



class OrderRepository

  # need to have the items that were ordered also accessed with the all method

  # need to have a way to add items for the create method

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT orders.id, orders.customer_name, orders.date_placed, items.name AS item_name, items.unit_price AS item_price FROM orders JOIN items_orders ON orders.id = items_orders.order_id JOIN items ON items.id = items_orders.item_id;

    # Returns an array of Order objects inlcuding a list of the Item objects
  end

  # Creates a new record
  def create(order)
    # Executes the SQL query:
    # INSERT INTO orders (customer_name, date_placed) VALUES ($1, $2);

    # And for each item in the order.items array, execute this:
    # INSERT INTO items_orders (item_id, order_id) VALUES ($1, $2)

    # returns nil
  end

  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby

# ITEM REPOSITORY TESTS
# 1
# Get all items

repo = ItemRepository.new

items = repo.all

items.length # =>  6

items[0].id # =>  '1'
items[0].name # =>  'White Desk Lamp'
items[0].unit_price # =>  '18'
items[0].quantity # => '12'
items[1].id # =>  '2'
items[1].name # =>  'Mahogani Dining Table'
items[1].unit_price # =>  '235'
items[1].quantity # => '5'
items[2].id # =>  '3'
items[2].name # =>  'Oak Bookshelf'
items[2].unit_price # =>  '80'
items[2].quantity # => '15'
items[3].id # =>  '4'
items[3].name # =>  'Oriental Rug'
items[3].unit_price # =>  '139'
items[3].quantity # => '21'
items[4].id # =>  '5'
items[4].name # =>  'Aloe Vera Houseplant'
items[4].unit_price # =>  '12'
items[4].quantity # => '150'
items[5].id # =>  '6'
items[5].name # =>  'Leather Sofa'
items[5].unit_price # =>  '1699'
items[5].quantity # => '2'


# 2
# Create a new item

repo = ItemRepository.new

item = Item.new
item.name = 'Luxury Armchair'
item.unit_price = 240
item.quantity = 7

repo.create(item)

repo.all.last.name # => 'Luxury Armchair'
repo.all.last.unit_price # => '240'
repo.all.last.quantity # => '7'



# ORDER REPOSITORY TESTS
# 1
# Get all orders

repo = OrderRepository.new

orders = repo.all

orders.length # =>  3

orders[0].id # =>  1
orders[0].customer_name # =>  'John Treat'
orders[0].date_placed # => '2022-08-12'
orders[0].items[0].name # => 'Oak Bookshelf'
orders[0].items[1].name # => 'Oriental Rug'
orders[0].items[2].name # => 'Leather Sofa'

orders[1].id # =>  2
orders[1].customer_name # =>  'Amelia Macfarlane'
orders[1].date_placed # => '2022-08-14'
orders[1].items[0].name # => 'White Desklamp'

orders[2].id # =>  3
orders[2].customer_name # =>  'Eleanor Borgate'
orders[2].date_placed # => '2022-09-02'
orders[2].items[0].name # => 'White Desk Lamp'
orders[2].items[1].name # => 'Oak Bookshelf'
orders[2].items[2].name # => 'Aloe Vera Houseplant'

# 2
# Create a new order

repo = OrderRepository.new

item1 = Item.new
item1.name = 'Leather Sofa'
item2 = Item.new
item2.name = 'Oriental Rug'

order = Order.new
order.customer_name = 'Bella Cruxiante'
order.date_placed = '2022-09-09'
order.items << item1
order.items << item2

repo.create(order)

created_order = repo.all.last
created_order.customer_name # => 'Bella Cruxiante'
created_order.date_placed # => '2022-09-09'
created_order.items[0].name # => 'Leather Sofa'
created_order.items[1].name # => 'Oriental Rug'


```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/user_repository_spec.rb

def reset_post_table
  seed_sql = File.read('spec/seeds_post.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

describe UserRepository do
  before(:each) do 
    reset_post_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._