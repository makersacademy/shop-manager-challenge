# Items Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `students`*

```
# EXAMPLE

Table: items

Columns:
id | item_name | unit_price | quantity 
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- (file: spec/seeds_items_order.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE items, orders RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO items (item_name, unit_price, quantity) VALUES ('Chips', 2.99, 1);
INSERT INTO items (item_name, unit_price, quantity) VALUES ('Pizza', 3.49, 2);
INSERT INTO items (item_name, unit_price, quantity) VALUES ('Sandwich', 1.99, 3);

INSERT INTO orders (customer_name, order_date) VALUES ('Sara', '2022-09-01');
INSERT INTO orders (customer_name, order_date) VALUES ('Anne', '2022-12-12');


INSERT INTO items_orders (item_id, order_id) VALUES (1, 1);
INSERT INTO items_orders (item_id, order_id) VALUES (2, 1);
INSERT INTO items_orders (item_id, order_id) VALUES (3, 2);


-- Add items_orders values below 




```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 shop_manager_test < seeds_items_order.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: students

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
# EXAMPLE
# Table name: items

# Model class
# (in lib/item.rb)

class Item

  # Replace the attributes by your own columns.
  attr_accessor :id, :item_name, :unit_price, :quantity
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# student = Student.new
# student.name = 'Jo'
# student.name
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: students

# Repository class
# (in lib/student_repository.rb)

class ItemRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    sql = 'SELECT id, item_name, unit_price, quantity FROM items;'
    result_set = DatabaseConnection.exec_params(sql, [])
    
    items = []
    
    result_set.each do |record|
      item = Item.new 
      item.id = record['id']
      item.item_name = record['item_name']
      item.unit_price = record['unit_price']
      item.quantity = record['quantity']
      
      items << item
    end
    return items 
  end

  def find(id)
    sql = 'SELECT id, item_name, unit_price, quantity FROM items WHERE id = $1;'
    sql_params = [id]
    
    result = DatabaseConnection.exec_params(sql, sql_params)
    
    record = result[0]
    
    item = Item.new
    item.id = record['id']
    item.item_name = record['item_name']
    item.unit_price = record['unit_price']
    item.quantity = record['quantity']
    
    return item
  end

  # Add more methods below for each operation you'd like to implement.

  def create(item)
    sql = 'INSERT INTO items (item_name, unit_price, quantity) VALUES ($1, $2, $3);'
    sql_params = [item.item_name, item.unit_price, item.quantity]
    DatabaseConnection.exec_params(sql, sql_params) 
  end

  # def update(item)
  #   sql = 'UPDATE items SET item_name = $1, unit_price = $2, quantity = $3 WHERE id = $4;'
  #   sql_params = [item.item_name, item.unit_price, item.quantity]
  #   DatabaseConnection.exec_params(sql, sql_params) 
  # end

  def delete(id)
    sql = 'DELETE FROM items WHERE id = $1;'
    sql_params = [id]
    DatabaseConnection.exec_params(sql, sql_params)
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
item = repo.all
expect(item.length).to eq(3)
expect(item[0].id).to eq('1')
expect(item[0].item_name).to eq('Item name')
expect(item[0].item_price).to eq(1.99)
expect(item[0].quantity).to eq('1')
#REPEAT FOR THE SECOND ITEM 




# 2
# Get a single ITEM

repo = ItemRepository.new
item = repo.find(1)
expect(item.id).to eq('1')
expect(item.item_name).to eq('Item name')
expect(item.item_price).to eq(1.99)
expect(item.quantity).to eq('1')

# 3 it creates a new item 
repo = ItemRepository.new

new_item = Item.new 
new_item.item_name = 'New item'
new_item.unit_price = '1.50'
new_item.quantity = '5'

repo.create(new_item)
items = repo.all 
last_item = items.last 

expect(last_item.item_name).to eq('New name')
expect(last_item.unit_price).to eq(1.50)
expect(last_item.quantity).to eq('5')

#4 It deletes an item 

repo = ItemRepository.new
id_to_delete = 1
repo.delete(id_to_delete)

all_items = repo.all 
expect(all_items.length).to eq(2)
expect(all_items.first.id).to eq('2')

#5 it updates item with new values UPDATE NOT REQUIRED IN USER STORY
# repo = ItemRepository.new
# item = repo.find(1)
# item.item_name = 'Updated item'
# item.unit_price = '$4.88'
# item.quantity = '3'
#
# repo.update(item)
#
# updated_item = repo.find(1)
# expect(updated_item.item_name).to eq('Updated name')
# expect(updated_item.unit_price).to eq('$4.88')
# expect(updated_item.quantity).to eq('3')
# Add more examples for each method
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_itemsorders_table
  seed_sql = File.read('spec/seeds_itemsorders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

RSpec.describe ItemRepository do
  before(:each) do
    reset_itemsorders_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._

## 9. Application Class 
Welcome to the shop management program!

What do you want to do?
1 = list all shop items
2 = create a new item
3 = list all orders
4 = create a new order

1 [enter]

Here's a list of all shop items:

#1 Super Shark Vacuum Cleaner - Unit price: 99 - Quantity: 30
#2 Makerspresso Coffee Machine - Unit price: 69 - Quantity: 15
(...)