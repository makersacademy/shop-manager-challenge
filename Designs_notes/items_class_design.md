# Items Model and Repository Classes Design Recipe


## 1. Table Design

See [table design file](designs_notes/shop_database_table_design.md)


## 2. Test SQL Seeds


```sql

-- (file: spec/seeds.sql)

TRUNCATE TABLE items, orders, items_orders RESTART IDENTITY; -- replace with your own table name.

INSERT INTO items (name, unit_price, quantity) VALUES ('Semi Skimmed Milk: 2 Pints', 1.30, 30);
INSERT INTO items (name, unit_price, quantity) VALUES ('Cathedral City Mature Cheddar: 550G', 5.25, 15);
INSERT INTO items (name, unit_price, quantity) VALUES ('Hovis Soft White Medium Bread: 800G', 1.40, 10);
INSERT INTO items (name, unit_price, quantity) VALUES ('Nestle Shreddies The Original Cereal 630G', 0.52, 8);
INSERT INTO items (name, unit_price, quantity) VALUES ('Walkers Baked Cheese & Onion 37.5G', 2.40, 80);

INSERT INTO orders (customer_name, date) VALUES ('Joe Bloggs', '21-Nov-2022');
INSERT INTO orders (customer_name, date) VALUES ('Mrs Miggins', '23-Nov-2022');
INSERT INTO orders (customer_name, date) VALUES ('Jane Appleseed', '17-Nov-2022');

INSERT INTO items_orders (item_id, order_id) VALUES ('4', '1');
INSERT INTO items_orders (item_id, order_id) VALUES ('3', '1');
INSERT INTO items_orders (item_id, order_id) VALUES ('2', '1');
INSERT INTO items_orders (item_id, order_id) VALUES ('5', '2');
INSERT INTO items_orders (item_id, order_id) VALUES ('1', '2');
INSERT INTO items_orders (item_id, order_id) VALUES ('1', '3');



```

## 3. Class Names

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

## 4. Model Class Interface 



```ruby

# Table name: item

# Model class
# (in lib/item.rb)

class Item

  # Replace the attributes by your own columns.
  attr_accessor :id, :name, :unit_price, :quantity
end

```


## 5. Repository Class Interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby

# Table name: items

# Repository class
# (in lib/item_repository.rb)

class ItemRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, unit_price, quantity FROM items;

    # Returns an array of Item objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)

  def find(id)
    # Executes the SQL query:
    # SELECT id, name, unit_price, quanity  FROM items WHERE id = $1;

    # Returns a single Student object.
  end

  # Creates a new record

  def create(item)

    # Executes the SQL query:
    # INSERT INTO items (name, unit_price, quantity) VALUES($1, $2, $3);

    # Doesn't return anything

  end 
end
```

## 6.Test Examples


```ruby
# EXAMPLES

# 1
# Get all items

repo = ItemRepository.new

items = repo.all

items.length # =>  5

items[0].id # =>  1
items[0].name # =>  'Semi Skimmed Milk: 2 Pints'
items[0].unit_price  # =>  '1.30'
items[0].quantity  # =>  '15'

items[3].id # =>  3
items[3].name # =>  'Hovis Soft White Medium Bread: 800G'
items[3].unit_price  # =>  '1.40'
items[3].quantity  # =>  '10'

items[4].id # =>  4
items[4].name # =>  'Nestle Shreddies The Original Cereal 630G'
items[4].unit_price  # =>  '0.52'
items[4].quantity  # =>  '8'

# 3 Create a new item object 

repo = ItemRepository.new 

item = Item.new

item.name = 'Fanta Orange 500Ml'
item.unit_price = '0.32'
item.quantity = '40'

repo.create(item)

all_items = repo.all

all_items.length # => 6
all_items.last.id # => '6'
all_items.last.name # => 'Fanta Orange 500Ml'
all_items.last.unit_price # => '0.32'
all_items.last.quantity # => '40'



# 2
# # Get a single student

# repo = StudentRepository.new

# student = repo.find(1)

# student.id # =>  1
# student.name # =>  'David'
# student.cohort_name # =>  'April 2022'

# # Add more examples for each method
```

## 7. Reloading the SQL seeds before each test run

TTo ensure fresh table contents every time the test suite is ran, the following code will be added 

```ruby
# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_items_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_database_test' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_items_table
  end

  # (tests will go here).
end
```