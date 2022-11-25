2. Create Test SQL seeds

TRUNCATE TABLE Users RESTART IDENTITY; -- replace with your own table name.

- Below this line there should only be `INSERT` statements.
- Replace these statements with your own seed data.

INSERT INTO Users (username, email) VALUES ('username 1', 'username_1@email.com');
INSERT INTO Users (username, email) VALUES ('username_2', 'username_2@email.com');


 - Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

psql -h 127.0.0.1 social_network_test < spec/seeds_users.sql

3. Define the class names 
User

4. Modle class

class User 
   attr_accessor :id, :username, :email
end
5. Define the Repository Class interface

UserRepository

- all
  # Executes the SQL query:
  sql = 'SELECT * FROM users;'


- find(id)
  # Executes the SQL query:
  sql = 'SELECT * FROM users WHERE id = $1;'


- create(user)

  sql = 'INSERT INTO users (username, email) VALUES ($1, $2);'

- delete(id)

sql = 'DELETE FROM users WHERE id = $1;'

   


6. Example tests 

* 1. return all users
repo = UserRepository.new
users = repo.all

expect(users.length) #=> 2

expect(users[0].username).to eq 'username_1'
expect(users[0].email).to eq 'username_1@email.com'
expect(users[1].username).to eq 'username_2'
expect(users[1].email).to eq 'username_2@email.com'


* 2. find a specific user

repo = UserRepository.new
user = repo.find(2)

expect(user.username).to eq 'username_2'
expect(user.email).to eq 'username_2@email.com'

* 3. Create a new user 

repo = UserRepository.new #Create our new repo class

#Create our new user 

new_user = User.new
new_user.username = 'username_3'
new_user.email = 'username_3@email.com'
repo.create(new_user)

#Call all method on userrepository
users = repo.all

expect(users.length) #=> 3
expect(users[2].username).to eq 'username_3'
expect(users[2].email).to eq 'username_3@email.com'

* 4 Delete a user

repo = UserRepository.new #Create our new repo class
repo.delete(1)
users = repo.all
expect(users.length).to eq 1
expect(users[0].username).to eq 'username_2'




7. Reload the SQL seeds before each test run
Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

# EXAMPLE

def reset_users_table
  seed_sql = File.read('spec/seeds_users.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

describe UserRepository do
  before(:each) do 
    reset_users_table
  end

  # (your tests will go here).
end