```ruby

# Model class
# (in lib/student.rb)
class Order
end

# Repository class
# (in lib/student_repository.rb)
class OrderRepository
end
4. Implement the Model class
Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

# EXAMPLE
# Table name: students

# Model class
# (in lib/student.rb)

class Order

  # Replace the attributes by your own columns.
  attr_accessor :id, :customer_name, :item_ordered, :date_order
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
Your Repository class will need to implement methods for each "read" or "write" operation youd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

# EXAMPLE
# Table name: students

# Repository class
# (in lib/student_repository.rb)

class OrderRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    pql = 'SELECT id, customer_name, item_ordered, date_order FROM orders;'
    results_set = DataConnection.exec_params(sql, [])
    orders = []

    result_set.each do |record|
    order = Order.new
    order.id = record['id']
    order.customer_name = record['customer_name']
    order.item_ordered = record['item_ordered']
    order.date_order = record['date_order']

    orders << order
    end 
    orders
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    sql = 'SELECT id, customer_name, item_ordered, date_order FROM orders WHERE id = $1;'
    params = [id]
    result_set = DatabaseConnection.exec_params(sql, params)

    record = result_set[0]

    order = Order.new
    order.id = record['id']
    order.customer_name = record['customer_name']
    order.item_ordered = record['item_ordered']
    order.date_order = record['date_order']

    # Returns a single Student object.
    return order 
  end

  # Add more methods below for each operation you'd like to implement.

   def create(order)
    sql =  sql = 'INSERT INTO order (customer_name, item_ordered, date_order) VALUES ($1, $2, $3);'
    
    sql_params = [order.customer_name, order.item_ordered, order.date_order]
    DatabaseConnection.exec_params(sql, sql_params)
   end

  # def update(student)
  # end

  # def delete(student)
  # end
end
6. Write Test Examples
Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

# EXAMPLES

# 1
# Get all students

repo = StudentRepository.new

students = repo.all

students.length # =>  2

students[0].id # =>  1
students[0].name # =>  'David'
students[0].cohort_name # =>  'April 2022'

students[1].id # =>  2
students[1].name # =>  'Anna'
students[1].cohort_name # =>  'May 2022'

# 2
# Get a single student

repo = StudentRepository.new

student = repo.find(1)

student.id # =>  1
student.name # =>  'David'
student.cohort_name # =>  'April 2022'

# Add more examples for each method
Encode this example as a test.

7. Reload the SQL seeds before each test run
Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_students_table
  seed_sql = File.read('spec/seeds_students.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'students' })
  connection.exec(seed_sql)
end

describe StudentRepository do
  before(:each) do 
    reset_students_table
  end

  # (your tests will go here).
end
