# **{{TABLE NAME}} Model and Repository Classes Design Recipe**

## **1. Design and create the Table**

## **2. Create Test SQL seeds**

-- (file: spec/seeds_shop.sql)

TRUNCATE TABLE items RESTART IDENTITY CASCADE;
TRUNCATE TABLE orders RESTART IDENTITY CASCADE;
TRUNCATE TABLE items_orders RESTART IDENTITY;

INSERT INTO items (item_name, item_price, item_quantity) VALUES ('Sherbet Lemons', 1, 500);
INSERT INTO items (item_name, item_price, item_quantity) VALUES ('Starmix', 3, 250);
INSERT INTO items (item_name, item_price, item_quantity) VALUES ('Candy Apple', 5, 20);
INSERT INTO items (item_name, item_price, item_quantity) VALUES ('Foam Bananas', 1, 40);
INSERT INTO items (item_name, item_price, item_quantity) VALUES ('Lollipops', 2, 650); 

INSERT INTO orders (customer_name, order_date) VALUES ('John Smith', '04012022');
INSERT INTO orders (customer_name, order_date) VALUES ('Jane Bower', '06012022');
INSERT INTO orders (customer_name, order_date) VALUES ('Slyvia Hanratty', '14112022');

INSERT INTO items_orders (item_id, order_id) VALUES (1, 1);
INSERT INTO items_orders (item_id, order_id) VALUES (2, 1);
INSERT INTO items_orders (item_id, order_id) VALUES (5, 1);
INSERT INTO items_orders (item_id, order_id) VALUES (1, 3);
INSERT INTO items_orders (item_id, order_id) VALUES (5, 3);
INSERT INTO items_orders (item_id, order_id) VALUES (1, 2);
INSERT INTO items_orders (item_id, order_id) VALUES (2, 3);
INSERT INTO items_orders (item_id, order_id) VALUES (4, 3);

`psql -h 127.0.0.1 shop_challenge < seeds_shop.sql`

## **3. Define the class names**

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

# Table name: items

# Model class
# (in lib/item.rb)
class Item
end

# Repository class
# (in lib/item_repository.rb)
class ItemRepository
end`

# Table name: orders

# Model class
# (in lib/order.rb)
class Order
end

# Repository class
# (in lib/order_repository.rb)
class OrderRepository
end

## **4. Implement the Model class**

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

# Table name: items

# Model class
# (in lib/item.rb)

class Item
  attr_accessor :id, :item_name, :item_price, :item_quantity :orders
end

# Table name: orders

# Model class
# (in lib/order.rb)

class Item
  attr_accessor :id, :customer_name, :order_date, :items
end


## **5. Define the Repository Class interface**

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

`# EXAMPLE
# Table name: items

# Repository class
# (in lib/item_repository.rb)

class ItemRepository
  def all
    # Executes the SQL query:
    # SELECT id, item_name, item_price, item_quantity FROM items;
    # Returns an array of Item objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, item_name, item_price, item_quantity FROM items WHERE id = $1;

    # Returns a single Student object.
  end

  def create(item)
  # 'INSERT INTO items (item_name, item_price, item_quantity) VALUES ($1, $2, $3);
  end
end`

# Table name: orders

# Repository class
# (in lib/order_repository.rb)

class OrderRepository
  def all
    # Executes the SQL query:
    # SELECT id, customer_name, order_date FROM orders;
    # Returns an array of Order objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, customer_name, order_date FROM orders WHERE id = $1;

    # Returns a single Order object.
  end

  def create(order)
  # 'INSERT INTO orders (customer_name, order_date) VALUES ($1, $2);
  end
end`

## **6. Write Test Examples**

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

`# EXAMPLES

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

# Add more examples for each method`

Encode this example as a test.

## **7. Reload the SQL seeds before each test run**

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

`# EXAMPLE

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
end`

## **8. Test-drive and implement the Repository class behaviour**

*After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.*