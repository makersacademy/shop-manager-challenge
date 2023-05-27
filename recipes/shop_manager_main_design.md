# {{TABLE NAME}} Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `students`*

```

```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_accounts.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE accounts, posts RESTART IDENTITY;


-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO accounts (email, username) VALUES ('email1@gmail.com', 'user_name_1');
INSERT INTO accounts (email, username) VALUES ('email23@gmail.com', 'user_name_23');



TRUNCATE TABLE posts RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO posts (title, contents, views, account_id) VALUES ('title_1', 'con_1', 123, 1);
INSERT INTO posts (title, contents, views, account_id) VALUES ('title_2', 'con_2', 234, 2);
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: accounts

# Model class
# (in lib/account.rb)
class Account
end

# Repository class
# (in lib/account_repository.rb)
class AccountRepository
end

# EXAMPLE
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
# EXAMPLE
# Table name: accounts

# Model class
# (in lib/account.rb)

class Account

  # Replace the attributes by your own columns.
  attr_accessor :id, :email, :username
end

# Table name: posts

# Model class
# (in lib/post.rb)

class Post

  # Replace the attributes by your own columns.
  attr_accessor :id, :title, :contents, :views, :account_id
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
# Table name: accounts

# Repository class
# (in lib/account_repository.rb)

class AccountRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, email, username FROM accounts;

    # Returns an array of Account objects.
  end

  def find(id)
    # id is an integer representing the number of id to search for
    # SELECT email, username FROM accounts WHERE id = $1;'
    # returns an instance of Account object
  end

  def create(account)
    # Executes the SQL query;
    # INSERT INTO accounts (email, username) VALUES ($1, $2);

    # Doesn't nned to return anything 
  end

  def delete(id)
    # Executes the SQl;
    # DELETE FROM accounts WHERE id = $1;

    # Returns nothing (only deletes the record)
  end

  def update(account)
    # Executes the SQL;
    # UPDATE accounts SET email = $1, username = $2 WHERE id = $3;

    # Returns nothing(only updates)
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
    # SELECT id, title, contents, views, accout_id FROM posts;

    # Returns an array of Post objects.
  end

  def find(id)
    # id is an integer representing the number of id to search for
    # SELECT title, contents, views, accout_id FROM posts WHERE id = $1;'
    # returns an instance of Post object
  end

  def create(post)
    # Executes the SQL query;
    # INSERT INTO posts (title, contents, views, accout_id) VALUES ($1, $2, $3, $4);

    # Doesn't nned to return anything 
  end

  def delete(id)
    # Executes the SQl;
    # DELETE FROM posts WHERE id = $1;

    # Returns nothing (only deletes the record)
  end

  def update(post)
    # Executes the SQL;
    # UPDATE posts SET title = $1, contents= $2, views = $3, account_id =$4 WHERE id = $5;

    # Returns nothing(only updates)
  end


end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all accounts

repo = AccountRepository.new

acc = repo.all
acc.length # => 2
acc.first.email # => 'email1@gmail.com'
acc.first.username # => 'user_name_1'

# 2
# find with id 2

repo = AccountRepository.new

acc = repo.find(2)
acc.length # => 1
acc.first.email # => 'email23@gmail.com'
acc.first.username # => 'user_name_23'

# 3
# create new account

repo = AccountRepository.new

acc = Account.new
acc.first.email # => 'email56@gmail.com'
acc.first.username # => 'email56'

repo.create(acc)

accs = repo.all
last_acc = accs.last
last_acc.email # => 'email56@gmail.com'
last_acc.username # => 'email56'



# 4
# delete

repo = AccountRepository.new

id_to_delete = 1

repo.delete(id_to_delete)

all_accs = repo.all
all_accs.length # => 1
all_accs.first.id # => '2'

#5
# update
repo = AccountRepository.new

acc = repo.find(1)

acc.username = 'New_username'
acc.email = 'new_email'


repo.update(acc)

updated_acc = repo.find(1)
updated_acc.username = 'New_username'
updated_acc.email = 'new_email'
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/account_repository_spec.rb

def reset_accounts_table
  seed_sql = File.read('spec/seeds_accounts.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end


  before(:each) do 
    reset_accounts_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._
