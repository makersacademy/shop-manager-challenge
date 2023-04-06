# shop_manager Model and Repository Classes Design Recipe

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

## 2. Create Test SQL seeds



```sql
-- (file: spec/seeds.sql)

TRUNCATE TABLE items, items_orders, orders RESTART IDENTITY;

INSERT INTO items ("name", "unit_price", "quantity") VALUES
('MacBookPro', 999.99, 50),
('Magic Mouse', 30.00, 10),
('Charger', 50.49, 25);


INSERT INTO orders ("customer_name", "date") VALUES
('Uncle Bob', '05-Sep-2022'),
('Linus Torvalds', '22-Feb-2023');

INSERT INTO items_orders ("item_id", "order_id") VALUES
(3, 1),
(2, 1),
(1, 1),
(2, 2);


```
Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 shop_manager_test < spec/seeds.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# Table name: user_accounts

# Model user account
class Item
  attr_accessor :id, :name, :date, :quantity
end

# Repository class
class ItemRepository
  def all
    # Returns an array of Item objects
  end

  def create(item)
    # Inserts an Item object into the DB
    # Returns nil
  end
end

# Model user account
class Order
  attr_accessor :id, :customer_name, :date
end

# Repository class
class OrderRepository
  def all
    # Returns an array of Order objects
  end

  def create(item)
    # Inserts an Order object into the DB
    # Returns nil
  end
end
```

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# Table name: user_accounts

# Repository class
# (in lib/user_accounts_repository.rb)

class UserAccountRepository
  def all 
    # executes SQL query 'SELECT * FROM user_accounts;'
    # returns a array of UserAccount objects
  end

  def find(id) 
    # executes SQL query 'SELECT * FROM user_accounts WHERE id = $1;'
    # returns the firs item in an array of UserAccount objects
  end

  def create(user_account) 
    # executes SQL query 'INSERT INTO user_accounts (username, email) VALUES ($1, $2);'
    # take a UserAccount object as argument
    # inserts a new row into user_accounts table
    # rerturns nil
  end

  def delete(id) 
    # executes SQL query 'DELETE FROM user_accounts WHERE id = $1;'
    # returns nil
  end
end

```


```ruby
# Table name: posts

# Repository class
# (in lib/posts_repository.rb)

class PostsRepository
  def all 
    # executes SQL query 'SELECT * FROM posts;'
    # returns a array of post objects
  end

  def find(id) 
    # executes SQL query 'SELECT * FROM posts WHERE id = $1;'
    # returns the firs item in an array of Post objects
  end

  def create(post) 
    # executes SQL query 'INSERT INTO posts (title, content, views, user_account_id) VALUES ($1, $2, $3, $4);'
    # inserts a new row into posts table
    # rerturns nil
  end

  def delete(id) 
    # executes SQL query 'DELETE FROM posts WHERE id = $1;'
    # returns nil
  end
end

```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# UserAccount class

# all method

repo = UserAccountRepository.new
users = repo.all
users.length => 2
users.first.username => 'dave'
users.first.email => 'dave@gmail.com'
users.last.username => 'john_lennon'
users.last.id => 2
users.last.email => 'dayinthelife@gmail.com'

# find method

repo = UserAccountRepository.new
user = repo.find(2)
user.username => 'john_lennon'
user.id => 2
user.email => 'dayinthelife@gmail.com'


# create(user_account) method

user = UserAccount.new
user.username = 'paul_mccartney'
user.email = 'letitbe@hotmail.com'
repo = UserAccountRepository.new
repo.create(user)
users = repo.all
users.length => 3
users.last.username => 'paul_mccartney'
users.last.email = 'letitbe@hotmail.com'
users.last.id => 3

# delete(id) method

repo = UserAccountRepository.new
repo.delete(2)
users = repo.all
users.length => 1
users.first.username => 'dave'
users.first.email => 'dave@gmail.com'
users.first.id => 1

# Post class
# all

repo = PostsRepository.new
posts = repo.all
posts.length # => 2
posts.first.title # => 'Complaint'
posts.first.content # => 'TDD is really annoying'
posts.first.views # => 500
posts.first.user_account_id # => 1

posts.last.id # => 2
posts.last.content # => 'My love will turn you on'
posts.last.title # => 'Oh Yoko'
posts.last.views # => 50000
posts.last.user_account_id # => 2

# find(id)

repo = PostsRepository.new
post = find(1)
post.id # => 1 
post.title # => 'Complaint'
post.content # => 'TDD is really annoying'
post.views # => 500
post.user_account_id # => 1

# create(post)

post = Post.new
post.title = 'Across the Universe'
post.content = 'Jai guru deva om'
post.views = 1000000
post.user_account_id = 2
repo = PostsRepository.new
posts = repo.all
posts.length # => 3 
posts.first.title # => 'Complaint'
posts.last.title # => 'Across the Universe'
posts.last.content # => 'Jai guru deva om'
posts.last.views # => 1000000
posts.last.user_account_id # => 2

# delete(id)

repo = PostsRepository.new
repo.delete(2)
posts = repo.all
posts.length # => 1
posts.first.title # => 'Complaint'
posts.first.content # => 'TDD is really annoying'
posts.first.views # => 500
posts.first.user_account_id # => 1

```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby

# file: spec/post_repository_spec.rb

def reset_posts_table
  seed_sql = File.read('spec/seeds_user_accounts.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

describe PostRepository do
  before(:each) do 
    reset_post_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._



```ruby

class ItemRepository

  def create(item)
    # inserts an Item object into the items table
    # SQL:

end



class OrderRepository

  def create(order)
    # inserts an Order object into the items table
    # SQL:

end

```