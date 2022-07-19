# {{SHOP MANAGEMENT APP}} Model and Repository Classes Design Recipe

## 1. Design and create the Table

```
As a shop manager
So I can know which items I have in stock
I want to keep a list of my shop items with their name and unit price.

As a shop manager
So I can know which items I have in stock
I want to know which quantity (a number) I have for each item.

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

As a shop manager
So I can manage orders
I want to be able to create a new order.

Added function:
As a shop manager
So I can manage orders and stock inventory
I want to be able to view items, available stock adn reserved stock with corresponding orders.

Refer to the shop_manager_table_design.md for more information on tables

```
## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

## 3. Define the class names

```ruby

# (in app.rb)
class Application
end

```

## 4. Implement the Application class

```ruby

# (in app.rb)
class Application
# The Application class initializer
  # takes four arguments:
  #  * The database name to call `DatabaseConnection.connect`
  #  * the Kernel object as `io` (so we can mock the IO in our tests)
  #  * the AlbumRepository object (or a double of it)
  #  * the ArtistRepository object (or a double of it)
  def initialize(database_name, io, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run
    # provides a list of options to uses and return results accordingly:
    #   lists items
    #   creates item
    #   lists orders
    #   creates an order with items - offeres the user an option to choose itemsto add to the order
    #   view order details 
    #   view item with orders
    # end
  end

  #private functions that execute user choices

  def  list_items
  end
      
  def create_item
  end
  
  def list_orders
  end

  def create_order_with_items
  end
    
  def view_order_details 
  end

  def view_item_with_orders
  end
end

```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby

# Tests are in app_spec.rb.

```
## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# file: spec/app_spec.rb

def reset_shop_database_tables
  seed_sql = File.read('spec/seeds_shop_data.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_database_test' })
  connection.exec(seed_sql)
end


describe Application do
  before(:each) do 
    reset_shop_database_tables
  end

  # (your tests will go here).
end

```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._
