# {{TABLE NAME}} Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `students`*

```
# EXAMPLE 

Table: students

Columns:
id | name | cohort_name
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_{table_name}.sql)

-- Write your SQL seed here.



-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE items, orders RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO items (item_name, item_price, item_stock) VALUES ('Deepchord', '7', '10');
INSERT INTO items (item_name, item_price, item_stock) VALUES ('Autechre', '8', '10');
INSERT INTO items (item_name, item_price, item_stock) VALUES ('Gas', '5', '10');
INSERT INTO items (item_name, item_price, item_stock) VALUES ('Floating Points', '9', '10');
INSERT INTO items (item_name, item_price, item_stock) VALUES ('wzrdryAV', '6', '10');
INSERT INTO orders (order_number, customer_name, order_date, item_id) VALUES ('00010', 'mike oliver', '2022-10-15', '1');
INSERT INTO orders (order_number, customer_name, order_date, item_id) VALUES ('00011', 'orla oliver', '2022-10-20', '2');
INSERT INTO orders (order_number, customer_name, order_date, item_id) VALUES ('00010', 'marvin haberdashery', '2022-09-03', '3');
INSERT INTO orders (order_number, customer_name, order_date, item_id) VALUES ('00010', 'steve mercenary', '2022-08-27', '4');
INSERT INTO orders (order_number, customer_name, order_date, item_id) VALUES ('00010', 'bernard mctwist', '2022-03-16', '5');


```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE

# 

class Item

end

class ItemRepository

end

class Order

end

class OrderRepository

end









```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby

# EXAMPLE

# Table name: books

class Item
  attr_accessor :item_name :item_price :item_stock
end

class Order
  attr_accessor :order_number :customer_name :order_date
end



# Table name: albums

# Model class
# (in lib/album.rb)


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

# Table name: books

# Repository class
# lib/book_repository.rb

class ItemRepository
  def all

  # SQL: 'SELECT id, item_name, item_price, item_stock FROM items;'
  # returns an array of the items
  end

  def find(id)

  # SQL: 'SELECT id, item_name, item_price, item_stock FROM items WHERE id = $1;'
  # Returns a single item
  end

  def create(item)

  # SQL: 'INSERT INTO items (item_name, item_price, item_stock) VALUES($1, $2, $3);'
  # Doesn't need to return anything
  end

  def delete(id)

  # SQL: 'DELETE FROM items WHERE id = $1;'
  # Doesn't need to return anything
  end

  def update(item)

  # SQL: 'UPDATE items SET item_name = $1, item_price = $2, item_stock = $3 WHERE id = $4;'
  # Doesn't need to return anything
  end


class OrderRespository
  def all

  # SQL: 'SELECT order_number, customer_name, order_date, item_id FROM orders;'
  # returns an array of the orders
  end

  def find(id)

  #SQL: 'SELECT order_number, customer_name, order_date, item_id FROM posts WHERE id = $1;'
  # Returns a single order
  end

  def create(order)

  # SQL: 'INSERT INTO orders (order_number, customer_name, order_date, item_id) VALUES($1, $2, $3, $4);'
  # Doesn't need to return anything
  end

  def delete(id)

  # SQL: 'DELETE FROM orders WHERE id = $1;'
  # Doesn't need to return anything
  end

  def update(order

  # SQL: 'UPDATE orders SET order_number = $1, customer_name = $2, order_date = $3, item_id = $4 WHERE id = $5;'
  # Doesn't need to return anything
  end

```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all items and orders

repo = ItemRepository.new

items = repo.all
items.first.id # => '1'
items.length # => 5
items.first.item_name # => 'Deepchord'

repo = OrderRepository.new

orders = repo.all
orders.first.id # => '1'
orders.length # => 4
orders.first.customer_name # => 'mike oliver'


# 2
# Get a single item and order

repo = ItemRepository.new

item = repo.find(1)
item.item_name # => 'Deepchord'
item.item_price # => '7'

repo = OrderRepository.new

order = repo.find(1)
order.order_number # => '10'
order.customer_name # => 'mike oliver'


# 3
# Create a new item

repo = ItemRepository.new

item = Item.new
item.item_name = 'Aphex Twin'
item.item_price = '10'
item.item_stock = '10'

items = repo.all
repo.create(item)

last_item = items.last

expect(last_item.item_name).to eq ('Aphex Twin')
expect(last_item.item_price).to eq ('10')


# 4
# Delete an item

repo = ItemRepository.new

repo.delete(1)

expect(items.length).to eq 4
expect(items.first.id).to eq 2

repo = OrderRepository.new

repo.delete(1) # Delete an order with id 1

expect(orders.length).to eq 4
expect(items.first.id).to eq 2


# 5
# Update a user account

# repo = UserAccountRepository.new

# user_account = repo.find(1)

# user_account.email_address = 'mike@mike'
# user_account.username = 'mike'

# updated_user_account = repo.find(1)
# updated_user_account.email_address # => 'henry@henry'
# updated_user_account.username # => 'henry'


# repo = PostRepository.new

# post = repo.find(1)

# post.post_title = 'day one'
# post.post_contents = 'Once upon a time'

# updated_post.post_title # => 'To begin with'
# updated_post.post_contents # => 'I wandered lonely as a cloud...'






```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_user_accounts_table
  seed_sql = File.read('spec/seeds_user_accounts.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

describe StudentRepository do
  before(:each) do 
    reset_user_accounts_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._

<!-- BEGIN GENERATED SECTION DO NOT EDIT -->

---

**How was this resource?**  
[😫](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😫) [😕](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😕) [😐](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😐) [🙂](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=🙂) [😀](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😀)  
Click an emoji to tell us.

<!-- END GENERATED SECTION DO NOT EDIT -->