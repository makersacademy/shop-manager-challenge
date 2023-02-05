{{Artists}} Model and Repository Classes Design Recipe


1. Design and create the Table √


2. Create Test SQL seeds
Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

-- EXAMPLE
-- (file: spec/seeds_{table_name}.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,so we can start with a fresh state.

-- (RESTART IDENTITY resets the primary key)
```sql
TRUNCATE TABLE artists RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.

-- Replace these statements with your own seed data.

INSERT INTO items (name, price, quantity) VALUES ('Notebook', 1, 10);
INSERT INTO items (name, price, quantity) VALUES ('Shirt', 5, 6);
INSERT INTO items (name, price, quantity) VALUES ('Trousers', 10, 15);
INSERT INTO items (name, price, quantity) VALUES ('Boots', 20, 5);


INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Janet', '2023-01-2', 1);
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Aaron', '2022-12-12', 3);
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Emily', '2022-10-23', 2);
INSERT INTO orders (customer_name, order_date, item_id) VALUES ('Camille', '2023-01-24', 4);

```
Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

psql -h 127.0.0.1 shop_manager_test < seeds_shop_manager.sql


3. Define the class names
Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by Repository for the Repository class name.

```ruby
# EXAMPLE
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

4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: items

# Model class
# (in lib/item.rb)

class Item
  attr_accessor :id, :name, :price, :quantity 
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object, here's an example:
#
# item = Item.new
# item.name = 'shirt'
# item.price = '5'
```

You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.


5. Define the Repository Class interface
Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: items

# Repository class
# (in lib/item_repository.rb)

class ItemRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, price, quantity FROM items;

    # Returns an array of item objects.
  end

   # select a single method 
   # given the id in an argument(a number)
  def find(id)
    # executes the SQL query: 
    # SELECT id, name, price, quantity FROM items WHERE id = $1

    # returns a single item 
  end 

  # insert a new item record 
  # takes an item object as an argument
  def create(item)
    # executes the SQL query: 
    # INSERT INTO items (name, price, quantity) VALUES($1, $2, $3);

    # returns nothing 
  end
 
end
```


6. Write Test Examples
Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all items

repo = ItemRepository.new

items = repo.all 
items.length # => 4
items.first.id # => 1 
items.first.name # => 'Notebook'
items.first.price # => '£1'
items.first.quantity # => "10"


# 2
# get a single item

repo = ItemRepository.new

item = repo.find(1)
item.name # => 'Notebook'
item.price # => '£1' 
item.quantity # => '10'



# 3
# get a single item

repo = ItemRepository.new

item = repo.find(3)
item.name # => 'Trousers'
item.price # => '£10' 
item.quantity # => '15'

# 4
# Create a new item 

repo = ItemRepository.new

item = item.new
item.name = 'Tank Top'
item.price = '£7' 
item.quantity = '13'

repo.create(item) => nil

items = repo.all 

last_item = items.last 
last_item.name # => 'Tank Top'
last_item.price # => '£7' 
last_item.quantity # => '13'

```

7. Reload the SQL seeds before each test run
Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

# EXAMPLE

# file: spec/item_repository_spec.rb

def reset_items_table
  seed_sql = File.read('spec/seeds_shop_manager.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_items_table
  end

  # (your tests will go here).
end
8. Test-drive and implement the Repository class behaviour
After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.