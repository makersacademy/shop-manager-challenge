# {{TABLE NAME}} Model and Repository Classes Design Recipe

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql

TRUNCATE TABLE orders RESTART IDENTITY; 

INSERT INTO orders (date, customer) VALUES ('2023-03-01', 'Jim');
INSERT INTO orders (date, customer) VALUES ('2023-02-01', 'Tim');
INSERT INTO orders (date, customer) VALUES ('2023-01-01', 'Kim');
INSERT INTO orders (date, customer) VALUES ('2022-12-01', 'Lim');
INSERT INTO orders (date, customer) VALUES ('2022-11-01', 'Yim');

TRUNCATE TABLE items RESTART IDENTITY; 

INSERT INTO items (name, price, quantity) VALUES ('Xbox series X', 399, 20);
INSERT INTO items (name, price, quantity) VALUES ('Dell Monitor 4K', 499, 25);
INSERT INTO items (name, price, quantity) VALUES ('Macbook Air', 1249, 30);
INSERT INTO items (name, price, quantity) VALUES ('Logitech Keyboard', 119, 35);
INSERT INTO items (name, price, quantity) VALUES ('Samsung Galaxy Tab', 299, 40);
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# Model class
class Item / Order
end
# Repository class
class ItemRepository / OrderRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
class Item
  attr_accessor :id, :name, :price, :quantity
end
class Order
  attr_accessor :id, :date, :customer
end
```

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
class OrderRepository

  def all
  # returns a list of orders
  end

  def find(id)
  # returns a single order with items ordered
  end

  def create
  # add an order in the orders table
  # do not return anything
  end

  def update
  # update an order from the orders table
  # do not return anything
  end

  def delete
  # delete an order from the table
  # do not return anything
  end
end
```
```ruby
class ItemRepository

  def all
  # returns a list of orders
  end

  def find(id)
  # returns a single order with items ordered
  end

  def find_orders(id)
  # returns a list of orders that contain this item
  end

  def create
  # add an order in the orders table
  # do not return anything
  end

  def update
  # update an order from the orders table
  # do not return anything
  end

  def delete
  # delete an order from the table
  # do not return anything
  end
end
```

## 6. Write Test Examples

```ruby
# 1
# Get all students


# 2
# Get a single student


```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

```ruby
describe Repository do
  def reset_table
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: '' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_table
  end
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._