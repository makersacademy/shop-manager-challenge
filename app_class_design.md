# App Class Design Recipe

## 1. Describe the Problem

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

## 2. Design the Class Interface

_Include the initializer and public methods with all parameters and return values._

```ruby
# app.rb is at the root of the project directory 

require_relative 'database_connection'
require_relative 'item_repository'
require_relative 'order_repository'

class App
  def initialize # initialises with database_name, terminal, item_repository, order_repository
    DtabaseConnection.connect(database_name) # calls connect method from DatabaseConnection class to connect to databse
  end

  def view_items
    # takes no args
    # creates an instance of item_repository
    # calls ItemRepository.all method
    # loops through results
    # each returning in a readable format to the termnal 
  end 

  def view_orders
     # takes no args
    # creates an instance of order_repository
    # calls ItemRepository.all method
    # loops through results
    # each returning in a readable format to the termnal 
  end 

  def add_item
    # takes no args
    # creates a new Item object
    # takes user input via terminal to generate query params
    # calls ItemRepository.create(Item object)
   
  end 

  def add_order
    # takes no args
    # creates a new Order object
    # takes user input via terminal to generate query params
    # calls OrderRepository.create(Order object)
    
  end 

  def update_item_name
    
    # takes no args
    
    # takes user input via terminal to generate query params
    # calls ItemRepository.update_item_name(new_name, id)
  end 

  def update_item_price
    # takes no args
    
    # takes user input via terminal to generate query params
    # calls ItemRepository.update_item_price(new_price, id)
    
  end 

  def update_item_quantity
   # takes no args
    
    # takes user input via terminal to generate query params
    # calls ItemRepository.update_item_quantity(new_quantity, id)
  end

  def display_menu
   # putses a series of options in the terminal
   # gets user input to execute a method
  end
```
#### Terminal output design
```ruby
# EXAMPLE

# Terminal Output


app = App.new()
app.display_menu 

# should return the terminal output below
=begin
             Shop Manager................    
                 [1]  view all items             
                 [2]  view all orders 
                 [3]  add new item 
                 [4]  add new order 
                 [5]  update item name   
                 [6]  update item price 
                 [7]  update item quantity    
                  

             ............................. 
                
              Select an option[ ] 
=end
```

## 3. Create Examples as Tests

_Make a list of examples of how the class will behave in different situations._


```ruby

# Terminal output test 

            puts "Shop Manager................"  
            puts "    [1]  view all items "     
            puts "    [2]  view all orders"
            puts "    [3]  add new item"
            puts "    [4]  add new order"
            puts "    [5]  update item name"  
            puts "    [6]  update item price"
            puts "    [7]  update item quantity"   
            puts "............................."   
            puts " Select an option[ ]"

            selected_option = gets.chomp

# 1. User selects '1'
#    view_items 
#    selected_option = '1'
    
    items = @item_repository.all
    puts # => "id: 1, name: Joe Bloggs, order date: 2022-12-31, item_id: 1"
    puts # => rest of the records in the table, in the above format...

# 2. User selects '2'
#    view_orders
#    selected_option = '2'

    orders = @order_repository.all
    puts # => "id: 1, name: Joe Bloggs, order date: 2022-12-31, item_id: 1"
    puts # => rest of the records in the table, in the above format...

# 3. User selects '3'
#   add_item 
#   selected_option = '3'
    items = @item_repository.all
    item = Item.new
    puts "Enter item name: "
    # item.item_name = gets.chomp
    puts "Enter item price: "
    # item.price = gets.chomp
    puts "Enter item quantity: "
    # item.quantity = gets.chomp
    @item_repository.create(item)

# 4. User selects '4'
#   add_order 
#   selected_option = '4'
    orders = @order_repository.all
    order = Order.new
    puts "Enter customer name: "
    # order.customer_name = gets.chomp
    puts "Enter order date: "
    # order.order_date = gets.chomp
    puts "Enter item id: "
    # order.item_id = gets.chomp
    @order_repository.create(order)

# 5. User selects '5'
#   update_item_name 
#   selected_option = '5'
    puts "Enter item id: "
    # id = @io.gets.chomp
    puts "Enter new item name: "
    # new_name = @io.gets.chomp
    puts "Item updated"
    @item_repository.update_item_name(new_name, id)

# 6. User selects '6'
#   update_item_price
#   selected_option = '6'
    puts "Enter item id: "
    # id = @io.gets.chomp
    puts "Enter new item price: "
    # new_price = @io.gets.chomp
    puts "Item updated"
    @item_repository.update_unit_price(new_price, id)

# 7. User selects '7'
#   update_item_quantity
#   selected_option = '7'
    puts "Enter item id: "
    # id = @io.gets.chomp
    puts "Enter new item quantity: "
    # new_quantity = @io.gets.chomp
    puts "Item updated"
    @item_repository.update_item_quantity(new_quantity, id)



```

_Encode each example as a test. You can add to the above list as you go._

## 4. Implement the Behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._

