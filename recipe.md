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
    # Returns all records as an array of user objects. - to be used by other methods in app.rb.
  end

  # Adds a user to the users table in DB
  def create(item_obj)
    # adds a user object to the database
    # 'INSERT INTO items(item_name, unit_price, quantity) VALUES($1, $2, $3);'
    # params = [item_obj.item_name, item_obj.unit_price, item_obj.quantity]
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
    # Executes the SQL query:
    # SELECT * FROM orders;
  end

  def create(order_obj)
    # Adds a postobj to the posts table if post corresponds to existing user 
    # 'INSERT INTO orders(title, content, views, user_id) VALUES($1, $2, $3, $4);'
    # params = [post_obj.title, post_obj.content, post_obj.views, post_obj.user_id]
    # No return
  end
end
```

## 6. Write Test Examples
These examples will later be encoded as RSpec tests.

```ruby

# EXAMPLES

# 1. Get all items
repo = ItemRepository.new
repo.all.length => # returns correct integer dependent on how many rows are in DB
repo.all.first.id => #always will return 1
repo.all.last.id => #should return the same int as first test line 
repo[2].item_name => #returns the item name of object at index 2 (assuming there are 3 objs in array)

# Get all orders:
repo = OrderRepository.new
repo.all.length => # returns correct integer dependent on how many rows are in DB
repo.all.first.id => #always will return 1
repo.all.last.id => #should return the same int as first test line 
repo[2].customer_name => #returns the customer name of object at index 2 (assuming there are 3 objs in array)

# if database is empty should return => []


# 2. Add an item obj to database
repo = ItemRepository.new
item_1 = Item.new # => can be a double => double :item, item_name: 'name', unit_price: '1.29', quantity: 1
item_1.item_name = 'Big Skeng'
item_1.unit_price = 3.99
item_1.quantity = 5
repo.create(item_1)
expect(repo.all.last.item_name).to eq 'Big Skeng'
expect(repo.all.last.unit_price).to eq '3.99'
expect(repo.all.length) # => an integer 1 greater than our current length
expect(repo.all.last.id).to eq # => ^ same integer as previous expect line ^

# Add order obj to database 
repo = OrderRepository.new
order_1 = Item.new # => can be a double
order_1.customer_name = 'Sean Paul'
order_1.date_placed = '12/12/2023'
order_1.item_id = 1
repo.create(order_1)
expect(repo.all.last.customer_name).to eq 'Sean Paul'
expect(repo.all.last.date_placed).to eq '12/12/2023'
expect(repo.all.length) # => an integer 1 greater than our current length
expect(repo.all.last.id).to eq # => ^ same integer as previous expect line ^

# from command line can run app.rb from using test DB .all to check - also repo.all[int] returns error out of scope

```

## 7. Reload the SQL seeds before each test run
Running the SQL code present in the seed file will empty the table and re-insert the seed data.

```ruby

# file: spec/item_repository_spec.rb

 def reset_items_table
    seed_sql = File.read('spec/item_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_items_table
  end
end

# file: spec/order_repository_spec.rb

 def reset_orders_table
    seed_sql = File.read('spec/order_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_orders_table
  end
end
```

## 8. Test-drive and implement the Repository class behaviour
_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._