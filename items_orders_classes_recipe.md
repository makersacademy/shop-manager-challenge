User stories

As a shop manager
So I can know which items I have in stock
I want to keep a list of my shop items with their name and unit price.

As a shop manager
So I can know which items I have in stock
I want to know which quantity (a number) I have for each item.

Method:
      As a shop manager
      So I can manage items
      I want to be able to create a new item.

As a shop manager
So I can know which orders were made
I want to keep a list of orders with their customer name.

As a shop manager
So I can know which orders were made
I want to assign each order to their corresponding item.

As a shop manager
So I can know which orders were made
I want to know on which date an order was placed. 

Method:
      As a shop manager
      So I can manage orders
      I want to be able to create a new order.




1. Design and create the table(s)
Otherwise, follow this post to design and create the SQL schema for your table.

After creating tables, create database and test database.



2. Create Test SQL seeds
Your tests will depend on data stored in StudentgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

-- (file: spec/seeds_items_orders.sql)

-- Write your SQL seed here. 


-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE items, orders, items_orders RESTART IDENTITY;

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO "items" (name, unit_price, quantity) VALUES ('Henry Hoover', 79, 19);
INSERT INTO "items" (name, unit_price, quantity) VALUES ('Dyson Vacuum', 199, 28);
INSERT INTO "items" (name, unit_price, quantity) VALUES ('Dualit Toaster', 49, 39);
INSERT INTO "items" (name, unit_price, quantity) VALUES ('Breville Kettle', 39, 34);
INSERT INTO "items" (name, unit_price, quantity) VALUES ('Panasonic Microwave', 59, 29);

INSERT INTO "orders" (customer_name, item_id, date) VALUES ('Andy Lewis', 2, '2022-11-23');
INSERT INTO "orders" (customer_name, item_id, date) VALUES ('James Scott', 5, '2022-11-24');
INSERT INTO "orders" (customer_name, item_id, date) VALUES ('Christine Smith', 4, '2022-11-24');
INSERT INTO "orders" (customer_name, item_id, date) VALUES ('Louise Stones', 1, '2022-11-25');
INSERT INTO "orders" (customer_name, item_id, date) VALUES ('Michael Kelly', 3, '2022-11-26');
INSERT INTO "orders" (customer_name, item_id, date) VALUES ('Catherine Wells', 2, '2022-11-27');

INSERT INTO "items_orders" (item_id, order_id) VALUES (1, 4);
INSERT INTO "items_orders" (item_id, order_id) VALUES (2, 1);
INSERT INTO "items_orders" (item_id, order_id) VALUES (2, 6);
INSERT INTO "items_orders" (item_id, order_id) VALUES (3, 5);
INSERT INTO "items_orders" (item_id, order_id) VALUES (4, 3);
INSERT INTO "items_orders" (item_id, order_id) VALUES (5, 2);




Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

psql -h 127.0.0.1 items_orders_test < seeds_items_orders.sql







3. Define the class names
Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by Repository for the Repository class name.


# 1 Table name: items

# Model class
# (in lib/post.rb)

class Post
end

# Repository class
# (in lib/post_repository.rb)
class PostRepository
end




# 2 Table name: orders

# Model class
# (in lib/tag.rb)

class Student
end

# Repository class
# (in lib/tag_repository.rb)
class TagRepository
end






4. Implement the Model class
Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.


# 1 Table name: items

# Model class
# (in lib/post.rb)

class Post
  # Replace the attributes by your own columns.
  attr_accessor :id, :title, :orders

  def initialize
    @orders = []
  end
end


# 2 Table name: orders

# Model class
# (in lib/orders.rb)

class Tag
  # Replace the attributes by your own columns.
  attr_accessor :id, :name, :items

  def intialize
    @items = []
  end
end


# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# student = Student.new
# student.name = 'Jo'
# student.name
You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.




5. Define the Repository Class interface
Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.


# 1 Table name: items

# Repository class
# (in lib/post_repository.rb)
class PostRepository
  <!-- # Selecting all records
  # No arguments
  def all
    # Executes the SQL query below:
    sql = "SELECT id, name, email_address, username FROM items;"
    result_set = DatabaseConnection.exec_params(sql, [])

    items = []

    # loop through results and create an array of post objects
    # Return array of post objects.
  end -->

  <!-- # Finding one record
  # Taking the record id as an argument
  def find(id)
    sql = "SELECT id, name, email_address, username FROM items WHERE id = $1;"

    params = [id]

    result_set = DatabaseConnection.exec_params(sql, params)
    record = result_set[0]

    # (The code now needs to convert the result to an Album object and return it)
  end -->


  <!-- # Find one cohort and list orders in this cohort
  # (in lib/cohort_repository.rb)
  def find_with_orders(id)
    sql = "SELECT items.id AS item_id,
          items.name AS cohort_name,
          items.starting_date,
          orders.name AS student_name,
          orders.id AS student_id
          FROM items
          JOIN orders ON items.id = orders.item_id
          WHERE id = $1;"

    params = [id]

    result_set = DatabaseConnection.exec_params(sql, params)
    record = result_set[0]
    # create cohort object and add all data (from record)
    # add student info to cohort.@orders array (loop through result_set)
    # return cohort object    
  end -->

  # Find items by tag
  # (in lib/post_repository.rb)
  def find_by_tag(order_id)
    sql = "SELECT items.id AS item_id,
          items.title AS post_title
          FROM items
          JOIN items_orders ON items.id = items_orders.item_id
          JOIN orders ON items_orders.order_id = orders.id
          WHERE orders.id = $1;"

    params = [order_id]

    result_set = DatabaseConnection.exec_params(sql, params)
    record = result_set[0]
    
    # create items (/ @items) array??
    # loop through records, creating Post objects and adding to items array?
    # return items
  end

  <!-- # Creating a new post record (takes an instance of Cohort)
  def create(post)
    sql = "INSERT INTO items (name, email_address, username) VALUES($1, $2, $3);"
    params = [post.name, post.email_address, post.username]
    DatabaseConnection.exec_params(sql, params)
  end


  def delete(id)
    sql = "DELETE FROM items WHERE id = $1"
    params = [id]
    DatabaseConnection.exec_params(sql, params)
  end


  # def update(post)
  # end -->
end



# 2 Table name: orders

# Repository class
# (in lib/tag_repository.rb)
class TagRepository
  <!-- # Selecting all records
  # No arguments
  def all
    # Executes the SQL query below:
    sql = "SELECT id, title, content, views, item_id FROM orders;"
    result_set = DatabaseConnection.exec_params(sql, [])

    orders = []

    # loop through results and create an array of post objects
    # Return array of post objects.
  end

  # Finding one record
  # Taking the record id as an argument
  def find(id)
    sql = "id, title, content, views, item_id FROM orders WHERE id = $1;"

    params = [id]

    result_set = DatabaseConnection.exec_params(sql, params)
    record = result_set[0]

    # (The code now needs to convert the result to an Album object and return it)
  end -->

  # Find orders by post
  # (in lib/tag_repository.rb)
  def find_by_post(item_id)
    sql = "SELECT orders.id AS order_id,
          orders.name AS tag_name
          FROM orders
          JOIN items_orders ON orders.id = items_orders.order_id
          JOIN items ON items_orders.item_id = items.id
          WHERE items.id = $1;"

    params = [item_id]

    result_set = DatabaseConnection.exec_params(sql, params)
    record = result_set[0]
    
    # create orders (/ @orders) array??
    # loop through records, creating Tag objects and adding to orders array?
    # return orders
  end

  <!-- # Creating a new Student record (takes an instance of Student)
  def create(Student)
    sql = "INSERT INTO orders (title, content, views, item_id) VALUES($1, $2, $3, $4);"
    params = [Student.title, Student.content, Student.views, Student.item_id]
    DatabaseConnection.exec_params(sql, params)
  end


  def delete(id)
    sql = "DELETE FROM orders WHERE id = $1"
    params = [id]
    DatabaseConnection.exec_params(sql, params)
  end


  # def update(post)
  # end -->
end




6. Write Test Examples
Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.


# items

# Find items by tag - #find_by_tag

repo = PostRepository.new
items = repo.find_by_tag(1)

expect(items.length).to eq 4
expect(items[0].id).to eq '1'
expect(items[1].id).to eq '2'
expect(items[2].id).to eq '3'
expect(items[3].id).to eq '7'
expect(items[0].title).to eq 'How to use Git'
expect(items[1].title).to eq 'Ruby classes'
expect(items[2].title).to eq 'Using IRB'
expect(items[3].title).to eq 'SQL basics'

<!-- # Find items with orders - #find_with_orders

repo = CohortRepository.new
cohort = repo.find_with_orders(1)

expect(cohort.name).to eq 'One'
expect(cohort.starting_date).to eq '2022-09-01'
expect(cohort.orders.length).to eq 2
expect(cohort.orders.first.name).to eq 'Andy'
expect(cohort.orders.last.name).to eq 'James'
expect(cohort.orders.first.item_id).to eq '1'
expect(cohort.orders.last.item_id).to eq '1' -->


<!-- # 1
# Get all items - #all

repo = CohortRepository.new
items = repo.all

expect(items.length).to eq 3
expect(items.first.id).to eq '1'
expect(items.last.id).to eq '3'
expect(items.last.name).to eq 'Scott'


# 2
# Find a post - #find(id)

# 1
repo = CohortRepository.new
post = repo.find(1)

expect(post.id).to eq '1'
expect(post.name).to eq 'Andy'
expect(post.email_address).to eq 'andy@gmail.com'
expect(post.username).to eq 'andy123'

# 2
repo = CohortRepository.new
post = repo.find(2)

expect(post.id).to eq '2'
expect(post.name).to eq 'James'
expect(post.email_address).to eq 'james@outlook.com'
expect(post.username).to eq 'james456'


# 3
# Delete a post
repo = CohortRepository.new

repo.delete(3)
expect(items.length).to eq 2
expect(items.last.id).to eq '2'
expect(items.last.name).to eq 'James'


# 4
# Create a post
repo = CohortRepository.new

new_post = Cohort.new
new_post.name = 'Lewis'
new_post.email_address = 'lewis@gmail.com'
new_post.username = '1lewis23'

repo.create(new_post)

items = repo.all

expect(items.last.id).to eq '4'
expect(items.last.name).to eq 'Lewis'
expect(items.last.email_address).to eq 'lewis@gmail.com'
expect(items.last.username).to eq '1lewis23'




# orders

# 1
# Get all orders - #all

repo = StudentRepository.new
orders = repo.all

expect(orders.length).to eq 5
expect(orders.first.id).to eq '1'
expect(orders.last.id).to eq '5'
expect(orders.last.title).to eq 'Deactivate account'
expect(orders[2].item_id).to eq '3'


# 2
# Find a Student - #find(id)

# 1
repo = StudentRepository.new
Student = repo.find(1)

expect(Student.id).to eq '1'
expect(Student.title).to eq 'Hello'
expect(Student.content).to eq 'Hello, this is Andy'
expect(Student.views).to eq '54'
expect(item_id).to eq '1'

# 2
repo = StudentRepository.new
Student = repo.find(2)

expect(Student.id).to eq '2'
expect(Student.title).to eq 'Test'
expect(Student.content).to eq 'Testing, 123'
expect(Student.views).to eq '100'
expect(item_id).to eq '2'


# 3
# Delete a Student
repo = StudentRepository.new

repo.delete(3)
expect(orders.length).to eq 4
expect(orders.last.id).to eq '5' # or 4??? will IDs after deleted one decrement?
expect(orders[2].title).to eq 'Sport'


# 4
# Create a Student
repo = StudentRepository.new

new_Student = Student.new
new_Student.title = 'New Student'
new_Student.content = 'I am adding a new Student'
new_Student.views = '2'
new.item_id.to eq '2'

repo.create(new_Student)

orders = repo.all

expect(orders.last.id).to eq '6'
expect(orders.last.title).to eq 'New Student'
expect(orders.last.content).to eq 'I am adding a new Student'
expect(orders.last.views).to eq '2'
expect(item_id).to eq '2' -->



# orders


# Find orders by post - #find_by_post

repo = TagRepository.new
orders = repo.find_by_post(6)

expect(orders.length).to eq 2
expect(orders[0].id).to eq '2'
expect(orders[1].id).to eq '3'
expect(orders[0].name).to eq 'travel'
expect(orders[1].name).to eq 'cooking'





<!-- # EXAMPLES

# 1
# Get all orders

repo = StudentRepository.new

orders = repo.all

orders.length # =>  2

orders[0].id # =>  1
orders[0].name # =>  'David'
orders[0].cohort_name # =>  'April 2022'

orders[1].id # =>  2
orders[1].name # =>  'Anna'
orders[1].cohort_name # =>  'May 2022'

# 2
# Get a single student

repo = StudentRepository.new

student = repo.find(1)

student.id # =>  1
student.name # =>  'David'
student.cohort_name # =>  'April 2022'

# Add more examples for each method
Encode this example as a test. -->




7. Reload the SQL seeds before each test run
Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.


# file: spec/post_repository_spec.rb

# Repository tests
def reset_tables
  seed_sql = File.read('spec/seeds_blog_items_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'blog_items_orders_test' })
  connection.exec(seed_sql)
end

describe PostRepository do
  before(:each) do 
    reset_tables
  end

  # (your tests will go here).
end




8. Test-drive and implement the Repository class behaviour
After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.
