# {{TABLE NAME}} Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](.-single_table_design_recipe_template.md).

_In this template, we'll use an example table `students`_

```
# EXAMPLE
| Record                | Properties          |
| --------------------- | ------------------  |
| items                 | name, price, quantity
| orders                | name, date 

```

## 2. Create Test SQL seeds

Your tests will depend on data stored in ordergreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec-seeds_{table_name}.sql)
-- Write your SQL seed here.
-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)
TRUNCATE TABLE items RESTART IDENTITY CASCADE; -- replace with your own table name.
-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.
INSERT INTO items (name, price, quantity) VALUES ('ball', '10', '100');
INSERT INTO items (name, price, quantity) VALUES ('shoes', '50', '200');
INSERT INTO items (name, price, quantity) VALUES ('socks', '5', '100');
INSERT INTO items (name, price, quantity) VALUES ('jersey', '70', '50');
INSERT INTO items (name, price, quantity) VALUES ('shorts', '20', '300');


-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE orders RESTART IDENTITY CASCADE; -- replace with your own table name.
-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO orders (name, date) VALUES ('Lamar', '2022-11-01' );
INSERT INTO orders (name, date) VALUES ('Justin', '2022-11-10');
INSERT INTO orders (name, date) VALUES ('Patrick', '2022-11-22');
INSERT INTO orders (name, date) VALUES ('Josh', '2022-11-12');
INSERT INTO orders (name, date) VALUES ('Kirk', '2022,11,15');

```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 shop_manager_test < spec-seeds_items.sql
psql -h 127.0.0.1 shop_manager_test < spec-seeds_orders.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: items
# Model class
# (in lib-item.rb)
class Item
end
# Repository class
# (in lib-item_repository.rb)
class ItemRepository
end


# (in lib-order.rb)
class Order
end
# Repository class
# (in lib-order_repository.rb)
class OrderRepository
end


```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: students
# Model class
# (in lib-item.rb)
class Item
  # Replace the attributes by your own columns.
  attr_accessor :id, :name, :price, :quantity
end
# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# student = Student.new
# student.name = 'Shah'
# student.name

# (in lib-order.rb)
class Order
  # Replace the attributes by your own columns.
  attr_accessor :id, :name, :date, :item_id
end

```

_You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed._

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: items
# Repository class
# (in lib-item_repository.rb)
class ItemRepository
 
  def all
    sql = 'SELECT id, name, price, quantity, FROM items;'
    result_set = DatabaseConnection.exec_params(sql, [])
    items = []

    result_set.each do |record|
      item = Item.new
      item.id = record['id']
      item.name = record['name']
      item.price = record['price']
      item.quantity = record['quantity']
      items << item
    end
    items
  end

  def find(id)
    sql = 'SELECT id, name, price, quantity FROM items WHERE id = $1;'
    params = [id]
    result_set = DatabaseConnection.exec_params(sql, params)

    record = result_set[0]
    item = Item.new
    item.id = record['id']
    item.name = record['name']
    item.price = record['price']
    item.quantity = record['quantity']
    
    item
  end

  def create(item)
    sql = 'INSERT INTO items (name, price, quantity) VALUES ($1, $2, $3);'
    params = [item.name, item.price, quantity]
    DatabaseConnection.exec_params(sql, params)
  end

  def delete(id)
    sql = 'DELETE FROM items WHERE id = $1;'
    params = [id]
    DatabaseConnection.exec_params(sql, params)
  end
end
```

```ruby
# EXAMPLE
# Table name: orders
# Repository class
# (in lib-order_repository.rb)
class OrdersRepository
  
  def all
    sql = 'SELECT id, name, date, item_id FROM orders;'
    result_set = DatabaseConnection.exec_params(sql, [])
    orders = []
    
    result_set.each do |record|
      order = order.new
      order.id = record['id']
      order.name = record['name']
      order.date = record['date']
      order.item_id = record['item_id']
      orders << order
    end
    orders
  end

  def find(id)
    sql = 'SELECT id, name, date, item_id FROM orders WHERE id = $1;'
    params = [id]
    result_set = DatabaseConnection.exec_params(sql, params)
    record = result_set[0]
    order = Order.new
    order.id = record['id']
    order.name = record['name']
    order.date = record['date']
    order.item_id = record['item_id']
    order
  end

  def create(order)
    sql = 'INSERT INTO orders (name, date, item_id) VALUES ($1, $2, $3);'
    params = [order.name, order.date, order.item_id]
    DatabaseConnection.exec_params(sql, params)
  end

  def delete(id)
    sql = 'DELETE FROM orders WHERE id = $1;'
    params = [id]
    DatabaseConnection.exec_params(sql, params)
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES
# 1
# Get all items
repo = ItemRepository.new
items = repo.all
expect(items.length).to eq 5
expect(items[0].id).to eq '1'
expect(items[0].name).to eq 'ball'
expect(items[0].price).to eq '10'
expect(items[0].quantity).to eq '100'
expect(items[1].id).to eq '2'
expect(items[1].name).to eq 'shoes'
expect(items[1].price).to eq '50'
expect(items[1].quantity).to eq '200'


# 2
# Get a single item
repo = ItemRepository.new
items = repo.find(1)
expect(items.id).to eq 1
expect(items.name).to eq 'ball'
expect(items.price).to eq '10'
expect(items.quantity).to eq '100'

# 3
# create a item
repo = ItemRepository.new
new_item = Item.new
new_item.name = 'hat'
new_item.price = '15'
new_item.quantity = '150'


repo.create(new_item)
items = repo.all
last_item = items.last

expect(last_item.name).to eq 'hat'
expect(last_item.price).to eq '15'
expect(last_item.quantity).to eq '150'

# # 4
# # delete a item
# repo = itemRepository.new
# repo.delete(1)
# result_set = repo.all

# expect(result_set.length).to eq 1
# expect(result_set.first.id).to eq '2'

# 6
# Get all orders
repo = OrderRepository.new
orders = repo.all
expect(orders.length).to eq 5
expect(orders[0].id).to eq '1'
expect(orders[0].name).to eq 'Lamar'
expect(orders[0].date).to eq '2022-11-01'
expect(orders[0].item_id).to eq 1

# 7 
# finds a order
repo = OrdersRepository.new
orders = repo.find(1)
expect(orders.name).to eq 'Lamar'
expect(orders.date).to eq '2022-11-01'
expect(orders.item_id).to eq '1'

# 8
# creates a order
repo = OrdersRepository.new
new_order = Order.new
new_order.name = 'Fields'
new_order.date = '2022-11-05'
new_order.item_id = '5'

repo.create(new_order)
orders = repo.all
last_order = orders.last

expect(last_order.name).to eq 'Fields'
expect(last_order.date).to eq '2022-11-05'
expect(last_order.item_id).to eq '5'


# # 7
# # delete a order
# repo = ordersRepository.new
# repo.delete(1)

# result_set = repo.all
# expect(result_set.length).to eq 1
# expect(result_set.first.id).to eq '2'

```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh tabls ever you run the test suite.

```ruby
# EXAMPLE
# file: spec-item_repository_spec.rb
def reset_items_table
  seed_sql = File.read('spec-seeds_items.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

  before(:each) do
    reset_items_table
  end
  # (your tests will go here).
end

# file: spec-order_repository_spec.rb
def reset_orders_table
  seed_sql = File.read('spec-seeds_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

  before(:each) do
    reset_orders_table
  end
  # (your tests will go here).


```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._