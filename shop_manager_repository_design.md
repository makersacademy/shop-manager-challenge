# Shop Manager Model and Repository Classes Design Recipe

## 1. Design and create the Table

```
Table: items

Columns:
name | price | quantity



Table: orders

Columns: 
customer | date | item_id
```

## 2. Create Test SQL seeds

```sql
-- seeds_items.sql

TRUNCATE TABLE items RESTART IDENTITY; --

INSERT INTO items (name, price, quantity) VALUES ('1950s Wedding Dresses', 50, 2);
INSERT INTO items (name, price, quantity) VALUES ('Band Merch', 100, 10);

-- seeds_orders.sql

TRUNCATE TABLE orders RESTART IDENTITY; --

INSERT INTO orders (customer, date, item_id) VALUES ('Piper', 2022-10-01, 1);
INSERT INTO orders (customer, date, item_id) VALUES ('Lily', 2022-06-01, 2);
```

```bash
psql -h 127.0.0.1 shop_manager_test < seeds_items.sql

psql -h 127.0.0.1 shop_manager_test < seeds_orders.sql
```

## 3. Define the class names

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

## 4. Implement the Model class

```ruby
# Table name: items

# Model class
# (in lib/item.rb)

class Item

  attr_accessor :id, :name, :price, :quantity
end

# Table name: orders

# Model class
# (in lib/order.rb)

class Order

  attr_accessor :id, :customer, :date, :item_id
end
```

## 5. Define the Repository Class interface

```ruby
# Table name: items

# Repository class
# (in lib/item_repository.rb)

class ItemRepository
  def all
    # SELECT id, name, price, quantity FROM items;

  end

  def create(item)
    # INSERT INTO items (name, price, quantity) VALUES($1, $2, $3);

  end
end



# Table name: orders

# Repository class
# (in lib/order_repository.rb)

class OrderRepository
  def all
    # SELECT id, customer, date, item_id FROM orders;

  end

  def create(order)
    # INSERT INTO orders (customer, date, item_id) VALUES($1, $2, $3);

  end
end
```

## 6. Write Test Examples

```ruby
# 1
# Get all items

repo = ItemRepository.new

items = repo.all

items.length # =>  2

items[0].id # =>  "1"
items[0].name # =>  "1950s Wedding Dresses"
items[0].price # =>  "50"
items[0].quantity # =>  "2"

items[2].id # =>  "2"
items[2].name # =>  "Band Merch"
items[2].price # =>  "100"
items[2].quantity # =>  "10"

# 2
# Create an item

repo = ItemRepository.new

new_item = Account.new
new_item.name # => "Rat Cage"
new_item.price # => 3
new_item.quantity # => 6

repo.create(new_item)

all_items = repo.all

expect(all_items). to include(
  have_attributes(
    name: new_item.name,
    price: "3",
    quantity: "6"
  )
)

# 3
# Get all orders

repo = OrderRepository.new

orders = repo.all

orders.length # =>  2

orders[0].id # =>  "1"
orders[0].customer # =>  "Piper"
orders[0].date # =>  "2022-10-01"
orders[0].item_id # =>  "1"

orders[2].id # =>  "2"
orders[2].customer # =>  "Lily"
orders[2].date # =>  "2022-06-01"
orders[2].item_id # =>  "2"

# 4
# Create an order

repo = OrderRepository.new

new_order = Order.new
new_order.customer # => "Abi"
new_order.date # => 2022-10-02
new_order.item_id # => 3

repo.create(new_order)

all_orders = repo.all

expect(all_orders). to include(
  have_attributes(
    customer: new_order.customer,
    date: "2022-10-02",
    item_id: "3"
  )
)
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/student_repository_spec.rb

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
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._
