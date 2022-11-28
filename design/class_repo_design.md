Model and Repository Classes Design Recipe


1. Design and create the Table

| Record      | Properties                               |
| ----------- | -----------------------                  |
| items       | item_name, item_price, item_quantity     |
| orders      | customer_name, order_date                |



2. Create Test SQL seeds
Your tests will depend on data stored in PostgreSQL to run.


-- (file: spec/seeds_shop.sql)


TRUNCATE TABLE items,orders,order_items RESTART IDENTITY; 


INSERT INTO items (item_name,item_price,item_quantity) VALUES 
('Dyson Vaccum', '319','10'),
('Fitbit Sense 2', '90','30'),
('Galaxy Tab A8', '179','15'),
('Tefal Air Fryer', '99','21'),
('Nutribullet', '29','10'),
('Oral B CrossAction Toothbrush', '24','52');


INSERT INTO orders (customer_name,order_date) VALUES 
('Aimee', '02-12-22'),
('Zack', '04-12-22'),
('Chloe', '02-04-22'),
('Matthew', '05-03-22');


INSERT INTO items_orders(item_id,order_id) VALUES 
(1,2),
(2,2),
(3,1),
(4,4),
(5,3),
(6,1);


3. Define the class names
Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by Repository for the Repository class name.

class Item
    attr_accessor :id, :item_name , :item_price , item_quantity:
end


class Order
    attr_accessor :id, :customer_name, :order_date, :item

    def initialize
        @items []
    end
end 



5. Define the Repository Class interface
Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.



class ItemRepository

  def all
    # Executes the SQL query:
    # SELECT id, item_name, item_price, item_quantity FROM items;
    # Returns an array of Item objects.
  end

  def create(item)
    # creates a new item 
    # creates a new Item object 
  end 

  def update(item)
    # updates item quanity after a new order has been made   
  end

end


class OrderRepository

    def all
    # Executes the SQL query:
    # SELECT id, customer_name, order_date FROM orders;


    def create(order)
    # creates a new order 
    # creates a new Order object 
    # reduces item quanity in Items 

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
8. Test-drive and implement the Repository class behaviour
After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.

