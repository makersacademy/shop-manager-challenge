# shop_items Model and Repository Classes Design Recipe

## 1. Design and create the Table

```
Table: shop_items

Columns:
id | name | unit_price | quantity
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
TRUNCATE TABLE orders, shop_items, shop_items_orders RESTART IDENTITY; 

INSERT INTO orders (customer_name, date_placed) VALUES ('David', '08-Nov-2022');
INSERT INTO orders (customer_name, date_placed) VALUES ('Anna', '10-Nov-2022');
INSERT INTO orders (customer_name, date_placed) VALUES ('Jill', '11-Nov-2022');
INSERT INTO shop_items (name, unit_price, quantity) VALUES ('sandwich', 2.99, 10);
INSERT INTO shop_items (name, unit_price, quantity) VALUES ('bananas', 1.99, 15);
INSERT INTO shop_items (name, unit_price, quantity) VALUES ('toilet roll', 3.00, 20);
INSERT INTO shop_items (name, unit_price, quantity) VALUES ('crisps', 0.99, 15);
INSERT INTO shop_items (name, unit_price, quantity) VALUES ('sausage roll', 1.50, 10);
INSERT INTO shop_items_orders (shop_item_id, order_id) VALUES (1,1);
INSERT INTO shop_items_orders (shop_item_id, order_id) VALUES (4,1);
INSERT INTO shop_items_orders (shop_item_id, order_id) VALUES (5,1);
INSERT INTO shop_items_orders (shop_item_id, order_id) VALUES (2,2);
INSERT INTO shop_items_orders (shop_item_id, order_id) VALUES (3,3);
INSERT INTO shop_items_orders (shop_item_id, order_id) VALUES (1,3);
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
class ShopItem
end

class ShopItemRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
class ShopItem
  attr_accessor :id, :name, :unit_price, :quantity
end
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
class ShopItemRepository

  # Selecting all shop items
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, unit_price, quantity FROM shop_items;

    # Returns an array of shop item objects.
  end

  # inserts a new shop_item record
  # takes a shop item object as an argument
  def create(shop_item)
    # Executes the SQL query:
    # INSERT INTO shop_items (name, unit_price, quantity) VALUES($1, $2, $3);

    # doesnt need to return anything
  end

end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all shops items

repo = ShopItemRepository.new

shop_items = repo.all

shop_items.length # =>  5

shop_items[0].id # =>  1
shop_items[0].name # =>  'sandwich'
shop_items[0].unit_price # =>  '2.99'
shop_items[0].quantity # => '10'

shop_items[1].id # =>  2
shop_items[1].name # =>  'banana'
shop_items[1].unit_price # =>  '1.99'
shop_items[1].quantity # => '15'

# 2
# Creates a new shop item

repo = ShopItemRepository.new 

shop_item = ShopItem.new
shop_item.name = 'skittles'
shop_item.unit_price = 0.99
shop_item.quantity = 10

repo.create(shop_item)

shop_items = repo.all

shop_items.last.name # => 'skittles'
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_tables
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_challenge_test' })
  connection.exec(seed_sql)
end

describe ShopItemRepository do
  before(:each) do 
    reset_tables
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._

