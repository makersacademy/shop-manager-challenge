# {{items}} Model and Repository Classes Design Recipe

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
# Table name: items

# Model class
# (in lib/item.rb)
class Item
end

# Repository class
# (in lib/item_repository.rb)
class ItemRepository
end
```

## 4. Implement the Model class

```ruby
# Table name: items

# Model class
# (in lib/item.rb)

class Item
  attr_accessor :id, :name, :unit_price, :qty
end
```

## 5. Define the Repository Class interface

```ruby
# Table name: items

# Repository class
# (in lib/item_repository.rb)

class ItemRepository
  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT * FROM items;

    # Returns an array of Item objects.
  end

  # Create an item
  # Takes an Item object as an argument
  def create(item)
    # Executes the SQL query:
    # INSERT INTO items (name, unit_price, qty)
    # VALUES ($1, $2, $3);

    # params = [item.name, item.unit_price, item.qty]
    # Returns nothing
  end

  # Update an item
  # Takes an Item object as an argument
  def update(item)
    # Executes the SQL query:
    # UPDATE items SET (id, name, unit_price, qty)
    # VALUES ($1, $2, $3, $4)

    # params = [item.id, item.name, item.unit_price, item.qty]
    # Returns nothing
  end
end
```

## 6. Test Examples

```ruby

#1 Get all items

repo = ItemRepository.new
items = repo.all

items.length # =>  5

items[0].id # =>  1
items[0].name # =>  'Hoover'
items[0].unit_price # =>  '100'
items[0].qty # => '20'

items[1].id # =>  2
items[1].name # =>  'Washing Machine'
items[1].unit_price # =>  '400'
items[1].qty # => '30'

#2 Create an item

repo = ItemRepository.new

item = Item.new
item.name = 'Dishwasher'
item.unit_price = '429'
item.qty = '7'

repo.create(item)
items = repo.all

items.length # => 6

items[0].id # =>  1
items[0].name # =>  'Hoover'
items[0].unit_price # =>  '100'
items[0].qty # => '20'

items[5].id # =>  6
items[5].name # =>  'Dishwasher'
items[5].unit_price # =>  '429'
items[5].qty # => '7'

#3 Update an item

repo = ItemRepository.new

item = Item.new
item.name = 'Hoover'
item.unit_price = '149'
item.qty = '15'

repo.update(item)

items.length # => 5

items[0].id # =>  1
items[0].name # =>  'Hoover'
items[0].unit_price # =>  '149'
items[0].qty # => '15'

items[1].id # =>  2
items[1].name # =>  'Washing Machine'
items[1].unit_price # =>  '400'
items[1].qty # => '30'
```

## 7. Reload the SQL seeds before each test run

```ruby

# file: spec/student_repository_spec.rb

def reset_tables
  seed_sql = File.read('spec/seeds_items_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_tables
  end

  # (tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_Follow the test-driving process of red, green, refactor to implement the behaviour._
