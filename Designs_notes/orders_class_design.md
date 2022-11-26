# Items Model and Repository Classes Design Recipe


## 1. Table Design

See [table design file](designs_notes/shop_database_table_design.md)


## 2. Test SQL Seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

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

## 4. Model Class Interface 



```ruby

# Table name: order

# Model class
# (in lib/order.rb)

class Order
  attr_accessor :id, :customer_name, :date
end

```


## 5. Repository Class Interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby

# Table name: orders

# Repository class
# (in lib/order_repository.rb)

class OrderRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, customer_name, date FROM orders;

    # Returns an array of Order objects.
  end

  # Creates a new record

  def create(item)

    # Executes the SQL query:
    # INSERT INTO orders (customer_name, date) VALUES($1, $2);

    # Doesn't return anything

  end 
end
```

## 6.Test Examples


```ruby
# EXAMPLES

# 1
# Get all orders

repo = OrderRepository.new

orders = repo.all

orders.length # =>  3

orders[0].id # =>  1
orders[0].customer_name # => 'Joe Bloggs'
orders[0].date  # => '21-Nov-2022'

orders[1].id # =>  2
orders[1].customer_name # => 'Mrs Migginss'
orders[1].date  # => '23-Nov-2022'


orders[2].id # =>  3
orders[2].customer_name # => 'Jane Appleseed'
orders[2].date  # => '17-Nov-2022'

# 3 Create a new item object 

repo = OrderRepository.new 

order = Order.new

order.customer_name = 'Joe Schmoe'
order.date = '24-Nov-2022'

repo.create(order)

all_orders = repo.all

all_orders.length # => 4
all_orders.last.id # => '4'
all_orders.customer_name # => 'Joe Schmoe'
all_orders.last.date # => '24-Nov-2022'

```

## 7. Reloading the SQL seeds before each test run

To ensure fresh table contents every time the test suite is ran, the following code will be added 

```ruby
# EXAMPLE

# file: spec/order_repository_spec.rb

def reset_orders_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_database_test' })
  connection.exec(seed_sql)
end

describe OrderRepository do
  before(:each) do 
    reset_orders_table
  end

  # (tests will go here).

end
```