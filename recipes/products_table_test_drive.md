2. Create Test SQL seeds

TRUNCATE TABLE products RESTART IDENTITY; -- replace with your own table name.

- Below this line there should only be `INSERT` statements.
- Replace these statements with your own seed data.

INSERT INTO products (name, unit_price, quatity) VALUES ('PS5', '£350', 2);
INSERT INTO products (name, unit_price, quatity) VALUES ('XBOX', '£275', 10);



 - Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

psql -h 127.0.0.1 shop_manager_test < spec/seeds.sql

3. Define the class names 
product

4. Modle class

class product 
   attr_accessor :id, :name, :unit_price, :quantity
end
5. Define the Repository Class interface

PostRepository

- all
  # Executes the SQL query:
  sql = 'SELECT * FROM products;'


- find(id)
  # Executes the SQL query:
  sql = 'SELECT * FROM products WHERE id = $1;'


- create(product)

  sql = 'INSERT INTO products (name, unit_price, quatity) VALUES ($1, $2, $3);'

- delete(id)

sql = 'DELETE FROM products WHERE id = $1;'

   


6. Example tests 

* 1. return all products
repo = productRepository.new
products = repo.all

expect(products.length) #=> 2

expect(products[0].name).to eq 'PS5'
expect(products[0].unit_price).to eq '350'
expect(products[0].quantity).to eq '2'
expect(products[1].name).to eq 'XBOX'
expect(products[1].unit_price).to eq '275'
expect(products[1].quantity).to eq '10'


* 2. find a specific product

repo = ProductRepository.new
product = repo.find(2)

expect(product.name).to eq 'XBOX'
expect(product.unit_price).to eq '275'
expect(product.quantity).to eq '10'

* 3. Create a new product

repo = ProductRepository.new #Create our new repo class

#Create our new product

new_product = Product.new
new_product.name = 'NINTENDO SWITCH'
new_product.unit_price = '300'
new_product.quantity = '25'
repo.create(new_product)

#Call all method on productrepository
products = repo.all

expect(products.length) #=> 3
expect(products[2].name).to eq 'NINTENDO SWITCH'
expect(products[2].unit_price).to eq '300'
expect(products[2].quantity).to eq 25'

* 4 Delete a product

repo = ProductRepository.new #Create our new repo class
repo.delete(1)
products = repo.all
expect(products.length).to eq 1
expect(products[0].name).to eq 'XBOX'




7. Reload the SQL seeds before each test run
Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

# EXAMPLE

def reset_posts_table
  seed_sql = File.read('spec/seeds_posts.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

describe PostRepository do
  before(:each) do 
    reset_posts_table
  end

  # (your tests will go here).
end