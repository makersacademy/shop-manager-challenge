# Shop Manager Model and Repository Classes Design Recipe

## 1. Design and Create the table

User Stories/specification:

> As a shop manager
> So I can know which items I have in stock
> I want to keep a list of my shop items with their name and unit price.

> As a shop manager
> So I can know which items I have in stock
> I want to know which quantity (a number) I have for each item.

> As a shop manager
> So I can manage items
> I want to be able to create a new item.

> As a shop manager
> So I can know which orders were made
> I want to keep a list of orders with their customer name.

> As a shop manager
> So I can know which orders were made
> I want to assign each order to their corresponding item.

> As a shop manager
> So I can know which orders were made
> I want to know on which date an order was placed. 

> As a shop manager
> So I can manage orders
> I want to be able to create a new order.


#### relationship:

1. Can one Item have many Orders ? YES

-> An Item HAS MANY Orders
-> An Order BELONGS TO an Item
-> Therefore, the foreign key is on the Orders table.

Table design:
Items: id | name | unit_price | quantity
Orders: id | customer_name | date | item_id
 
id: SERIAL 
name: text
unit_price: int/float
quantity: int 

id: SERIAL
customer_name: text
date: timestamp -> changed to date to avoid having to input time/timezone.
item_id: int


#### Creating the tables:

```sql 
CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  item_name text,
  unit_price float,
  quantity int
);

CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name text,
  date_placed date,
  item_id int,
  constraint fk_item foreign key (item_id)
    references items(id)
    on delete cascade
);
```

Create table:
psql -h 127.0.0.1 shop_manager < DB_table_setup.sql


## 2. Create the SQL seeds
```sql
-- file: spec/social_network_seeds.sql)

TRUNCATE TABLE items RESTART IDENTITY CASCADE;
TRUNCATE TABLE orders RESTART IDENTITY CASCADE;

INSERT INTO items(item_name, unit_price, quantity) VALUES("Candlestick", 1.99, 10);
INSERT INTO items(item_name, unit_price, quantity) VALUES("Lead-Pipe", 4.45, 3);
INSERT INTO items(item_name, unit_price, quantity) VALUES("Gun", 12.95, 1);

INSERT INTO orders(customer_name, date_placed, item_id) VALUES("Professor Plum", 12/12/2023, 1);
INSERT INTO orders(customer_name, date_placed, item_id) VALUES("Colonel Mustard", 14/04/2023, 1);
INSERT INTO orders(customer_name, date_placed, item_id) VALUES("Miss Scarlet", 03/01/2023, 3);
INSERT INTO orders(customer_name, date_placed, item_id) VALUES("Reverend Green", 24/05/2023, 1);
INSERT INTO orders(customer_name, date_placed, item_id) VALUES("Mrs Peacock", 21/05/2023, 2);
INSERT INTO orders(customer_name, date_placed, item_id) VALUES("Chef White", 10/10/2023, 1);
INSERT INTO orders(customer_name, date_placed, item_id) VALUES("Miss Peach", 10/04/2023, 2);
INSERT INTO orders(customer_name, date_placed, item_id) VALUES("Madame Rose", 07/11/2023, 3);
INSERT INTO orders(customer_name, date_placed, item_id) VALUES("Lady Lavender", 08/12/2023, 1);

```

psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql

## 3. Define the class names

```ruby
# Model class'
# (in lib/item.rb)

class Item
end

# (in lib/order.rb)
class Order
end

# Repository class'
# (in lib/item_repository.rb)
class ItemRepository
end

# (in lib/user_repository.rb)
class UserRepository
end
```

## 4. Implement the Model class'

``` ruby

# Model class
# (in lib/item.rb)

class Item
  attr_accessor :id, :item_name, :unit_price, :quantity
end

# Model class 2
# (in lib/order.rb)

class Order
  attr_accessor :id, :customer_name, :date_placed, :item_id
end

```

## 5. Define the Repository Class' interface

```ruby

# Table name: items

# Repository class
# (in lib/item_repository.rb)

class ItemRepository

  # Selecting all records
  def all
    # Executes the SQL query:
    # SELECT * FROM items;
    # Returns all records as an array of user objects. - to be used by other methods.
  end

  # Gets a single record from the DB by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT * FROM items WHERE id = $1;
    # params = [id]

    # Returns a single item object.
  end

  # Adds a user to the users table in DB
  def create(user_obj)
    # adds a user object to the database
    # 'INSERT INTO users(email_address, username) VALUES($1, $2);'
    # params = [user_obj.email_address, user_obj.username]
    # No return
  end

 # Removes an object/row from the users table in DB 
 # SHOULD also remove corresponding objects from posts DB due to setup.
  def delete(id)
    # takes an id as arg and removes a row from the database with that arg id
    # 'DELETE FROM items WHERE id = $1;'
    # params = [id]
    # No return
  end
end

#Table name: orders
#This repository class acts on order objects 
# (in lib/order_repository.rb)
class OrderRepository

  def all 
    # Returns an array of all 
    # Method can be called by other methods later
  end

  def create(order_obj)
    # Adds a postobj to the posts table if post corresponds to existing user 
    # 'INSERT INTO posts(title, content, views, user_id) VALUES($1, $2, $3, $4);'
    # params = [post_obj.title, post_obj.content, post_obj.views, post_obj.user_id]
    # No return
  end

 # Should only remove an object/row from the posts table in DB
  def delete(id)
    # takes an id as arg and removes a row from the database with that arg id
    # 'DELETE FROM posts WHERE id = $1;'
    # params = [id]
  end

  def update(post)
    # Takes a user object and updates that user row in DB
    # 'UPDATE posts SET title = $1, content = $2, views = $3, user_id = $4 WHERE id = $1;'
    # params = [post.title, post.content, post.views, post.user_id]
  end

end
```

## 6. Write Test Examples
These examples will later be encoded as RSpec tests.

```ruby

# EXAMPLES

# 1. Get all users

repo = ItemRepository.new
repo = OrderRepository.new
repo.all.length => # returns correct integer dependent on how many rows are in DB
repo.all.first.id => #always will return 1
repo.all.last.id => #should return the same int as first test line 
repo[2]. => #returns the username of object at index 2 (assuming there are 3 objs in array)

# if database is empty should return => []

# 2. find selected
repo = ItemRepository.new 
repo = OrderRepository.new
user = repo.find(2)
expect(user.username).to eq # 'selected/expected username'

# 3. Add a user obj to database
repo = ItemRepository.new
repo = OrderRepository.new
user_1 = User.new
user_1.email_address = 'mattymoomilk@tiscali.net'
user_1.username = 'MattyMooMilk'
repo.create(user_1)
expect(repo.all.last.email_address).to eq 'mattymoomilk@tiscali.net'
expect(repo.all.last.username).to eq 'MattyMooMilk'
expect(repo.all.length) # => an integer 1 greater than our current length
expect(repo.all.last.id).to eq # => ^ same integer as previous expect line ^

# 4. Delete a user object 
repo = UserRepository.new
repo.delete(1)
expect(repo.all.length)to eq # integer one less than current repo.length 

# from app.rb line can run from test DB .all to check - also repo.all[int] returns error out of scope

# 5. Update a user object
repo = UserRepository.new
user_1 = repo.find(1)
user_1.email_address = 'updatedemailaddress@gmail.com'
user_1.username = 'updatedusername'
repo.update(user_1)
updated = repo.find(1)
expect(updated.email_address).to eq 'updatedemailaddress@gmail.com'
expect(updated.username).to eq 'updatedusername'

```

## 7. Reload the SQL seeds before each test run
Running the SQL code present in the seed file will empty the table and re-insert the seed data.

```ruby
# EXAMPLE

# file: spec/user_repository_spec.rb

 def reset_   _table
    seed_sql = File.read('spec/user_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_users_table
  end
end

# file: spec/post_repository_spec.rb

 def reset_   _table
    seed_sql = File.read('spec/post_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_post_table
  end
end
```

## 8. Test-drive and implement the Repository class behaviour
_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._