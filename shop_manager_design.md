# {{TABLE NAME}} Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `students`*

```
# Refer to tables_design.md

Table: accounts

Columns:
id | email_address | username

Table: posts

Columns:
id | title | content | views | account_id
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- (file: spec/seeds_accounts.sql)

TRUNCATE TABLE accounts, posts RESTART IDENTITY;

INSERT INTO accounts (email_address, username) VALUES ('naomi_schlosser@hotmail.com', 'nschlosser');
INSERT INTO accounts (email_address, username) VALUES ('anne_zorro@gmail.com', 'azorro');

-- (file: spec/seeds_posts.sql)

TRUNCATE TABLE posts RESTART IDENTITY;

INSERT INTO posts (title, content, views, account_id) VALUES ('FAKE TITLE1', 'FAKE CONTENT1', 50, 1);
INSERT INTO posts (title, content, views, account_id) VALUES ('FAKE TITLE2', 'FAKE CONTENT2', 100, 1);
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# Table name: accounts

# Model class
# (in lib/account.rb)
class Account
end

# Repository class
# (in lib/account_repository.rb)
class AccountRepository
end

# Table name: posts

# Model class
# (in lib/post.rb)
class Post
end

# Repository class
# (in lib/post_repository.rb)
class PostRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# Table name: accounts

# Model class
# (in lib/accounts.rb)

class Account
  attr_accessor :id, :email_address, :username
end

# Table name: accounts

# Model class
# (in lib/accounts.rb)

class Post
  attr_accessor :id, :title, :content, :views, :account_id
end
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# Table name: accounts

# Repository class
# (in lib/account_repository.rb)

class AccountRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT * FROM accounts;
*
    # Returns an array of Account objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT * FROM accounts WHERE id = $1;

    # Returns a single Account object.
  end

  # Ceates a new account
  # One argument: an Account object
  def create(account)
    # Executes the SQL query:
    # INSERT INTO accounts (email_address, username) VALUES ($1, $2);

    # Returns nothing
  end

  # Deletes a single record by its ID
  # One argument: the id (number)
  def delete(id)
    # Executes the SQL query:
    # DELETE FROM accounts WHERE id = $1;

    # Returns nothing
  end

  def update(account)
    # Executes the SQL query:
    # UPDATE accounts SET email_address = $1, username = $2 WHERE id = $3;

    # Returns nothing
  end
end

# Table name: posts

# Repository class
# (in lib/post_repository.rb)

class PostRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT * FROM posts;
*
    # Returns an array of Post objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT * FROM posts WHERE id = $1;

    # Returns a single Post object.
  end

  # Ceates a new post
  # One argument: an Post object
  def create(post)
    # Executes the SQL query:
    # INSERT INTO posts (title, content, views, account_id) VALUES ($1, $2, $3, $4);

    # Returns nothing
  end

  # Deletes a single record by its ID
  # One argument: the id (number)
  def delete(id)
    # Executes the SQL query:
    # DELETE FROM posts WHERE id = $1;

    # Returns nothing
  end

  def update(post)
    # Executes the SQL query:
    # UPDATE posts SET title = $1, content = $2, views = $3, account_id = $4 WHERE id = $5;

    # Returns nothing
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# AccountRepository
# 1
# Get all accounts

repo = AccountRepository.new

accounts = repo.all

accounts.length # =>  2

accounts[0].id # =>  '1'
accounts[0].email_address # =>  'naomi_schlosser@hotmail.com'
accounts[0].username # =>  'nschlosser'

accounts[1].id # =>  '2'
accounts[1].email_address # =>  'anne_zorro@gmail.com'
accounts[1].username # =>  'azorro'

# 2
# Get a single account

repo = AccountRepository.new

account = repo.find(1)

account.id # =>  '1'
account.email_address # =>  'naomi_schlosser@hotmail.com'
account.username # =>  'nschlosser'

# 3
# Create a new account

repo = AccountRepository.new

account = Account.new
account.email_address = 'hello123@yahoo.com'
account.username = 'hello123'

repo.create(account)

all_accounts = repo.all

all_accounts.length # => 3

all_accounts.last.id # =>  '3'
all_accounts.last.email_address # => 'hello123@yahoo.com'
all_accounts.last.username # => 'hello123'

# 4
# Delete an account

repo = AccountRepository.new

repo.delete(1)

all_accounts = repo.all

all_accounts.length # => 1

all_accounts.first.id # => '2'
all_accounts.first.email_address # => 'anne_zorro@gmail.com'
all_accounts.first.username # => 'azorro'

# 5
# Update an account

repo = AccountRepository.new

id_to_update = 1

account = repo.find(id_to_update)
account.email_address = 'test@hotmail.com'

repo.update(account)

updated_account = repo.find(id_to_update)
updated_account.email_address # => 'test@hotmail.com'

# PostRepository
# 1
# Get all posts

repo = PostRepository.new

posts = repo.all

posts.length # =>  2

posts[0].id # => '1'
posts[0].title # => 'FAKE TITLE1'
posts[0].content # => 'FAKE CONTENT1'
posts[0].views # => '50'
posts[0].account_id # => '1'

posts[1].id # => '2'
posts[1].title # => 'FAKE TITLE2'
posts[1].content # => 'FAKE CONTENT2'
posts[1].views # => '100'
posts[1].account_id # => '1'

# 2
# Get a single post

repo = PostRepository.new

post = repo.find(1)

posts.id # => '1'
posts.title # => 'FAKE TITLE1'
posts.content # => 'FAKE CONTENT1'
posts.views # => '50'
posts.account_id # => '1'

# 3
# Create a new post

repo = PostRepository.new

post = Post.new
post.title = 'FAKE TITLE3'
post.content = 'FAKE CONTENT3'
post.views = 25
post.account_id = 2

repo.create(post)

all_posts = repo.all

all_posts.length # => 3

all_posts.last.id # => '3'
all_posts.last.title # => 'FAKE TITLE3'
all_posts.last.content # => 'FAKE CONTENT3'
all_posts.last.views # => 25
all_posts.last.account_id # => 2

#4
# Delete a post

repo = PostRepository.new

repo.delete(1)

all_posts = repo.all

all_posts.length # => 1

all_posts.first.id # => '2'
all_posts.first.title # => 'FAKE TITLE2'
all_posts.first.content # => 'FAKE CONTENT2'
all_posts.first.views # => '100'
all_posts.first.account_id # => '1'

# 5
# Update a post

repo = PostRepository.new

id_to_update = 1

post = repo.find(id_to_update)
post.title = 'test'

repo.update(post)

updated_post = repo.find(id_to_update)
updated_post.title # => 'test'
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# file: spec/account_repository_spec.rb

def reset_accounts_table
  seed_sql = File.read('spec/seeds_accounts.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

RSpec.describe AccountRepository do
  before(:each) do 
    reset_accounts_table
  end

  # (your tests will go here).
end

# file: spec/post_repository_spec.rb

def reset_posts_table
  seed_sql = File.read('spec/seeds_posts.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

RSpec.describe PostRepository do
  before(:each) do 
    reset_posts_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._