# Item Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

```
Table: items

Columns:
id | name | unit_price | quantity
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- (file: spec/seeds_items.sql)
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
psql -h 127.0.0.1 shop_manager_test < spec/seeds_items.sql
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
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# Table name: items

# Model class
# (in lib/item.rb)

class Item
  attr_accessor :id, :name, :cohort_name
end
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# Table name: items

# Repository class
# (in lib/item_repository.rb)

class ItemRepository

  # Selecting all items
  def all
    # Executes the SQL query:
    # SELECT id, name, unit_price, quantity FROM items;

    # Returns an array of Item objects.
  end

  # Selecting all items associated with an order
  # id (int) is the id of the order we are looking at
  def find_with_order(id)
    # Executes the SQL query:
    # SELECT
    #   items.id,
    #   items.name,
    #   items.unit_price,
    #   items.quantity
    # FROM items
    # JOIN items_orders
    #   ON items.id = items_orders.item_id
    # JOIN orders
    #   ON items_orders.order_id = orders.id
    # WHERE
    #   orders.id = $1;

    # Returns an array of Item objects.
  end

  # Adds new item to list
  # item is an instance of the Item class
  def create(item)
    # Executes the SQL query:
    # INSERT INTO items (id, name, unit_price, quantity) VALUES ($1, $2, $3, $4);

    # Returns nothing
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# 1
# Gets all items
item_repo = ItemRepository.new
items = item_repo.all

items.length # => 4

items.first.id # => 1
items.first.name # => "Hammer"
items.first.unit_price # => 5.99
items.first.quantity # => 20

items.last.id # => 4
items.last.name # => "Drill"
items.last.unit_price # => 49.99
items.last.quantity # => 7

# 2
# Create adds an item to the database
item_repo = ItemRepository.new

new_item = Item.new
new_item.id = 5
new_item.name = "Saw"
new_item.unit_price = 6.50
new_item.quantity = 15
item_repo.create(item)

item_repo.all # => Contains the new element

# 3
# Create fails when trying to add an item with an id already being used
item_repo = ItemRepository.new

new_item = Item.new
new_item.id = 3
new_item.name = "Saw"
new_item.unit_price = 6.50
new_item.quantity = 15

item_repo.create(item) # => fails

# 4
# #find_with_order successfully fetches all items associated with an order
item_repo = ItemRepository.new
items = item_repo.find_with_order(1)

items.length # => 3

items[0].id # => 1
items[0].name # => "Hammer"

items[1].id # => 3
items[1].name # => "Nails (0.5kg)"

items[2].id # => 4
items[2].name # => "Drill"

# 5
# #find_with_order fails when given an order id that doesn't exist
item_repo = ItemRepository.new
item_repo.find_with_order(10) # => fails
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