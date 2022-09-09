# Shop Manager Model and Repository Classes Design Recipe

## 1. Design and create the Table

| Record                | Properties          |
| --------------------- | ------------------  |
| item                  | name, unit_price, quantity
| order                 | customer_name, date_placed

For more details see table_schema.md

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
TRUNCATE TABLE items, orders, items_orders RESTART IDENTITY;

INSERT INTO items (name, unit_price, quantity) VALUES 
('White Desk Lamp', 18, 12),
('Mahogani Dining Table', 235, 5),
('Oak Bookshelf', 80, 15),
('Oriental Rug', 139, 21),
('Aloe Vera Houseplant', 12, 150),
('Leather Sofa', 1699, 2);

INSERT INTO orders (customer_name, date_placed) VALUES
('John Treat', '2022-08-12'),
('Amelia Macfarlane', '2022-08-14'),
('Eleanor Borgate', '2022-09-02');

INSERT INTO items_orders (item_id, order_id) VALUES
(3, 1),
(4, 1),
(6, 1),
(1, 2),
(5, 3),
(1, 3),
(3, 3);
```


## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
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
class Item
  attr_accessor :id, :name, :unit_price, :quantity
end

class Order
  attr_accessor :id, :customer_name, :date_placed
end

```

## 5. Define the Repository Class interface

```ruby

class UserRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, email FROM post;

    # Returns an array of User objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, name, email FROM post WHERE id = $1;

    # Returns a single User object.
  end


  # Creates a new record
  def create(user)
    # Executes the SQL query:
    # INSERT INTO post (name, email) VALUES ($1, $2);

    # returns nil
  end

  # Deletes a record
  def delete(id)
    # Executes the SQL query:
    # DELETE FROM post WHERE id = $1;

    # returns nil
  end  
  
  # Updates a record given
  def update(user)
    # Executes the SQL query:
    # UPDATE post SET name = $1, email = $2 WHERE id = $3;

    # returns nil
  end
end



class PostRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, title, content, number_of_views, user_id FROM posts;

    # Returns an array of Post objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, title, content, number_of_views, user_id FROM posts WHERE id = $1;

    # Returns a single Post object.
  end

  # Creates a new record
  def create(post)
    # Executes the SQL query:
    # INSERT INTO posts (title, content, number_of_views, user_id) VALUES ($1, $2, $3, $4);

    # returns nil
  end

  # Deletes a record
  def delete(id)
    # Executes the SQL query:
    # DELETE FROM posts WHERE id = $1;

    # returns nil
  end  
  
  # Updates a record given
  def update(post)
    # Executes the SQL query:
    # UPDATE posts SET title = $1, content = $2, number_of_views = $3, user_id = $4 WHERE id = $5

    # returns nil
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby

# USER REPOSITORY TESTS
# 1
# Get all post

repo = UserRepository.new

post = repo.all

post.length # =>  2

post[0].id # =>  1
post[0].name # =>  'David'
post[0].email # =>  'david@makers.com'

post[1].id # =>  2
post[1].name # =>  'Anna'
post[1].email # =>  'anna@makers.com'

# 2
# Get a single user

repo = UserRepository.new

user = repo.find(1)

user.id # =>  1
user.name # =>  'David'
user.email # =>  'david@makers.com'

# 3
# Create a single user

repo = UserRepository.new

user = User.new
user.name = 'Jane'
user.email = 'jane@makers.com'

repo.create(user)

repo.all.last.name # => 'Jane'
repo.all.last.email # => 'jane@makers.com'

# 4
# Delete a single user

repo = UserRepository.new

repo.delete(1)

repo.all.length #=> 1
repo.all.first.id # => '2'
repo.all.first.name # => 'Anna'
repo.all.first.email # => 'anna@makers.com'

# 5
# Update a single user

repo = UserRepository.new

user = repo.find(1)
user.email = 'david@gmail.com'
repo.update(user)

updated_user = repo.find(1)
updated_user.email # => 'david@gmail.com'



# POST REPOSITORY TESTS
# 1
# Get all post

repo = PostRepository.new

posts = repo.all

posts.length # =>  2

posts[0].id # =>  1
posts[0].title # =>  'First Day'
posts[0].content # =>  'Today was a great day.'
posts[0].number_of_views # => '132'
posts[0].user_id # => '1'

posts[1].id # =>  2
posts[1].title # =>  'Learning SQL'
posts[1].content # =>  'I have learned so much.'
posts[1].number_of_views # => '472'
posts[1].user_id # => '2'


# 2
# Get a single post

repo = PostRepository.new

post = repo.find(1)

post.id # =>  1
post.title # =>  'First Day'
post.content # =>  'Today was a great day.'
post.number_of_views # => '132'
post.user_id # => '1'

# 3
# Create a single post

repo = PostRepository.new

post = Post.new
post.title = 'Golden square'
post.content = 'OOD and TDD'
post.number_of_views = 245
post.user_id = 2

repo.create(post)

repo.all.last.title # => 'Golden square'
repo.all.last.content # => 'OOD and TDD'

# 4
# Delete a single post

repo = PostRepository.new

repo.delete(1)

repo.all.length #=> 1
repo.all.first.id # => '2'
repo.all.first.title # => 'Learning SQL'
repo.all.first.content # => 'I have learned so much.'

# 5
# Update a single post

repo = PostRepository.new

post = repo.find(1)
post.content = 'Today was HARD!'
repo.update(post)

updated_post = repo.find(1)
updated_post.content # => 'Today was HARD!'


# Add more examples for each method
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/user_repository_spec.rb

def reset_post_table
  seed_sql = File.read('spec/seeds_post.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

describe UserRepository do
  before(:each) do 
    reset_post_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._