# Shop_Manager_class  Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `students`*

```
# EXAMPLE

Table: users
id: SERIAL
username: text
email_address: text

Table: posts
id: SERIAL
title: text
content: text
views: int,
user_id: int
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_shop_manager.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE items, orders RESTART IDENTITY; -- replace with your own table name.


-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO items (name, unit_price, quantity) VALUES
('Climbing rope', 40.99, 5),
('Waterproof jacket', 50.00, 2),
('Hiking boots', 130.99, 10),
('Guidebook', 40, 1)
;

INSERT INTO orders (customer_name, date_ordered, item_id) VALUES
('David Green', '2022-08-05', 3),
('Nadine Dorris', '2022-07-30', 4),
('Gary Neville', '2022-06-27', 1),
('Calvin Klein', '2022-07-28', 2),
('Duncan Russell', '2022-07-01', 1),
('Barry Clark', '2022-08-01', 3);


```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 social_network < spec/seeds_social_network.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# Table name: users

# Model class
# (in lib/user.rb)
class Item
end

class Order
end

# Repository class
# (in lib/user_repository.rb)
class ItemRepository
end

# Table name: posts

# Model class
# (in lib/post.rb)
class UserRepository
end

```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# Table name: users

# Model class
# (in lib/users.rb)

class Item
  attr_accessor :id, :name, :unit_price, :quantity
end

# Table name: posts

# Model class
# (in lib/post.rb)

class Order
  attr_accessor :id, :customer_name, :date_ordered, :item_id,
end
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# Table name: users

# Repository class
# (in lib/user_repository.rb)

class ItemRepository

  def all
    # execute sql command:
    # SELECT * FROM items;

    # returns an array of Item objects
  end

  def create(item)
    # execute sql command:
    # INSERT INTO items VALUES ($1, $2, $3);

    # returns nothing
  end
end

# Table name: posts
class OrderRepository

  def all
    # execute sql command:
    # SELECT * FROM orders;

    # returns an array of Order objects
  end

  def create(order)
    # execute sql command:
    # INSERT INTO order VALUES ($1, $2, $3);

    # returns nothing
  end
end

# Repository class
# (in lib/post_repository.rb)


```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# table = items
# Get all items
item_repository = ItemRepository.new
items = item_repository.all
items.length # => 3
items[0].id # => "1"
items[0].name # => "Climbing rope"
items[0].unit_price # => "40.99"
items[0].quantity # => "5"
items[3].id # => "4"
items[3].name # => "Guidebook"
items[3].unit_price # => "40.00"
items[3].quantity # => "1"

# create new item
item_repository = ItemRepository.new
item = Item.new
item.name = "Fishing rod"
item.unit_price = "200.00"
item.quantity = "4"
item_repository.create(item)
items = item_repository.all
items.length # => 5
items[4].id # => "5"
items[4].name # => "Fishing rod"
items[4].unit_price # => "200.00"
items[4].quantity # => "4"

#table: orders
# Get all orders
order_repository = OrderRepository.new
orders = item_repository.all
orders.length # => 6
orders[0].id # => "1"
orders[0].customer_name # => "David Green"
orders[0].date_ordered # => "2022-08-05"
orders[0].item_id # => "3"
orders[5].id # => "6"
orders[5].customer_name # => "Barry Clark"
orders[5].date_ordered # => "2022-08-01"
orders[5].item_id # => "3"

# create new orders
order_repository = OrderRepository.new
Order = Order.new
order.customer_name = "Michael John"
order.date_ordered = "2022-08-05"
order.item_id = "3"
order_repository.create(order)
orders = order_repository.all
orders.length # => 7
orders[6].id # => "7"
orders[6].customer_name # => "Barry Clark"
orders[6].date_ordered # => "2022-08-01"
orders[6].item_id # => "3"
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_students_table
  seed_sql = File.read('spec/seeds_students.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

describe StudentRepository do
  before(:each) do 
    reset_students_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._

<!-- BEGIN GENERATED SECTION DO NOT EDIT -->

---

**How was this resource?**  
[😫](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy/databases&prefill_File=resources/repository_class_recipe_template.md&prefill_Sentiment=😫) [😕](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy/databases&prefill_File=resources/repository_class_recipe_template.md&prefill_Sentiment=😕) [😐](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy/databases&prefill_File=resources/repository_class_recipe_template.md&prefill_Sentiment=😐) [🙂](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy/databases&prefill_File=resources/repository_class_recipe_template.md&prefill_Sentiment=🙂) [😀](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy/databases&prefill_File=resources/repository_class_recipe_template.md&prefill_Sentiment=😀)  
Click an emoji to tell us.

<!-- END GENERATED SECTION DO NOT EDIT -->