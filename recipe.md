# Shop Manager Model and Repository Classes Design Recipe

## 1. Design and Create the table

User Stories/specification:
> As a 



Nouns: 

#### relationship:

1. Can one  have many ? YES
2. Can one   have many  ? NO

-> A user HAS MANY posts
-> A post BELONGS TO a user
-> Therefore, the foreign key is on the posts table.

Table design:
Users: id | email_address | username (could include a fullname, DOB etc.)
Posts: title | content | views | users_id
 
id: SERIAL 
name: text
average_cooking_time: text (number followed by 'minutes' as a string)
rating: int

#### Creating the tables:

```sql 
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  email_address text,
  username text
);

CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  title text,
  content text,
  views int,
  user_id int,
  constraint fk_user foreign key (user_id)
    references users(id)
    on delete cascade
);
```

Create table:
psql -h 127.0.0.1 social_network < social_network_tables_setup.sql


## 2. Create the SQL seeds
```sql
-- file: spec/social_network_seeds.sql)

TRUNCATE TABLE users RESTART IDENTITY;
TRUNCATE TABLE posts RESTART IDENTITY;

INSERT INTO users (email_address, username) VALUES('obsidian_fire_mage69@gmail.com', 'GreatBallsOfFire');
INSERT INTO users (email_address, username) VALUES('pitbul420@gmail.com', 'Mr.Wolrdwide');
INSERT INTO users (email_address, username) VALUES('gengenpressed_to_perfection@tisacli.net', 'BigKlopp');
INSERT INTO users (email_address, username) VALUES('test_email@gmail.com', 'TestUsername');

INSERT INTO posts (title, content, views, user_id) VALUES('Had a really bad day', 'I ran out of mana so no more fire balls', 100, 1);
INSERT INTO posts (title, content, views, user_id) VALUES('Had another bad day', 'Took a bath - water extinguishes fire. What was I thinking?', 4, 1);
INSERT INTO posts (title, content, views, user_id) VALUES('We back', 'I am the god of hellfire and i bring you!', 15, 1);
INSERT INTO posts (title, content, views, user_id) VALUES('At the barbers', 'Fresh trim', 3000, 2);
INSERT INTO posts (title, content, views, user_id) VALUES('Checking in', 'Hey, its me, the normal one', 14, 3);
INSERT INTO posts (title, content, views, user_id) VALUES('We got again', 'Its been a bad season lets be honest', 25, 3);
INSERT INTO posts (title, content, views, user_id) VALUES('Recording a new banger', 'Mr.Worldwide is back', 10, 2);
INSERT INTO posts (title, content, views, user_id) VALUES('Test', 'Test number 4', 4, 4);

```

psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by Repository for the Repository class name.

# Table name: recipes

```ruby
# Model class'
# (in lib/user.rb)

class User
end

# (in lib/post.rb)
class Post
end

# Repository class'
# (in lib/user_repository.rb)
class UserRepository
end

# (in lib/post_repository.rb)
class PostRepository
end
```

## 4. Implement the Model class'

``` ruby

# Model class
# (in lib/user.rb)

class User
  attr_accessor :id, :email_address, :username
end

# Model class 2
# (in lib/post.rb)

class Post
  attr_accessor :id, :title, :content, :views, :user_id
end

```

## 5. Define the Repository Class' interface

```ruby
# EXAMPLE
# Table name: users

# Repository class
# (in lib/user_repository.rb)

class UserRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT * FROM users;

    # Returns an array of user objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT email_address, username FROM users WHERE id = $1;
    # params = [id]

    # Returns a single user object.
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
    # 'DELETE FROM users WHERE id = $1;'
    # params = [id]
    # No return
  end
end

#This repository class acts on post objects 
class PostRepository

  def all 
    
  end

  def create(post_obj)
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

repo = UserRepository.new
repo.all.length => # returns correct integer dependent on how many rows are in DB
repo.all.first.id => #always will return 1
repo.all.last.id => #should return the same int as first test line 
repo[2].username => #returns the username of object at index 2 (assuming there are 3 objs in array)

# if database is empty should return => []

# 2. find selected
repo = UserRepository.new 
user = repo.find(2)
expect(user.username).to eq # 'selected/expected username'

# 3. Add a user obj to database
# Is this an integartion test now?
repo = UserRepository.new
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