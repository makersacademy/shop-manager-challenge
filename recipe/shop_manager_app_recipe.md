# {{PROBLEM}} Multi-Class Planned Design Recipe

## 1. Describe the Problem

_Put or write the user story here. Add any clarifying notes you might have._

## 2. Design the Class System

_Consider diagramming out the classes and their relationships. Take care to
focus on the details you see as important, not everything. The diagram below
uses asciiflow.com but you could also use excalidraw.com, draw.io, or miro.com_

![Alt text](/shop_manager_app_design.png?raw=true "Optional Title")

_Also design the interface of each class in more detail._

```ruby
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
    # "Runs" the terminal application
    # so it can ask the user to enter some input
    # and then decide to run the appropriate action
    # or behaviour.

    # Use `@io.puts` or `@io.gets` to
    # write output and ask for user input.
  end
end

# Don't worry too much about this if statement. It is basically saying "only
# run the following code if this is the main file being run, instead of having
# been required or loaded by another file.
# If you want to learn more about __FILE__ and $0, see here: https://en.wikibooks.org/wiki/Ruby_Programming/Syntax/Variables_and_Constants#Pre-defined_Variables
if __FILE__ == $0
  app = Application.new(
    'shop_manager',
    Kernel,
    ItemRepository.new,
    OrderRepository.new
  )
  app.run
end
```

## 3. Create Examples as Integration Tests

_Create examples of the classes being used together in different situations and
combinations that reflect the ways in which the system will be used._

```ruby
# EXAMPLE

# 1 Puts interactive menu

    puts "Welcome to the shop management program!"
    puts "What do you want to do?"
    puts "  1 = list all shop items"
    puts "  2 = create a new item"
    puts "  3 = list all orders"
    puts "  4 = create a new order"


# 2  Puts interactive menu and puts all items when 1 input

    puts "Welcome to the shop management program!"
    puts "What do you want to do?"
    puts "  1 = list all shop items"
    puts "  2 = create a new item"
    puts "  3 = list all orders"
    puts "  4 = create a new order"
    gets 1
    puts "#1 item 1 - Unit price: £1.11 - Quantity: 1"
    puts "#1 item 2 - Unit price: £22.22 - Quantity: 22"
    puts "#1 item 3 - Unit price: £333.33 - Quantity: 333"
    puts "#1 item 4 - Unit price: £4444.44 - Quantity: 4444"

# 3  Puts all order when 3 input' do
      puts "Welcome to the shop management program!"
      puts "What do you want to do?"
      puts "  1 = list all shop items"
      puts "  2 = create a new item"
      puts "  3 = list all orders"
      puts "  4 = create a new order"
      gets 3
      puts "Here's a list of all shop orders:"
      puts "#1 customer 1 Order Date: 2022-01-25 Item: item 1"
      puts "#2 customer 2 Order Date: 2022-12-01 Item: item 2"
      puts "#3 customer 3 Order Date: 2021-01-03 Item: item 2"
      puts "#4 customer 4 Order Date: 2022-03-19 Item: item 3"
      puts "#5 customer 5 Order Date: 2022-02-01 Item: item 1"
      puts "#6 customer 6 Order Date: 2021-04-03 Item: item 3"
      puts "#7 customer 7 Order Date: 2022-05-30 Item: item 1"
      puts "#8 customer 8 Order Date: 2022-11-25 Item: item 4"


# 4  Inserts new item when 3 input' do

      puts "Welcome to the shop management program!"
      puts "What do you want to do?"
      puts "  1 = list all shop items"
      puts "  2 = create a new item"
      puts "  3 = list all orders"
      puts "  4 = create a new order"
      gets 2
      puts "Enter Item name:"
      gets "item 5"
      puts "Enter Unit Price:"
      gets 55555.55
      puts "Enter Quantity:"
      gets 55555
      puts "item 5 has been added"


# 5  Asks for unit price again if incorrect unit price' do

      puts "Welcome to the shop management program!"
      puts "What do you want to do?"
      puts "  1 = list all shop items"
      puts "  2 = create a new item"
      puts "  3 = list all orders"
      puts "  4 = create a new order"
      gets 2
      puts "Enter Item name:"
      gets "item 5"
      puts "Enter Unit Price:"
      gets "string"
      puts "Enter Unit Price:"
      gets "55555.55"
      puts "Enter Quantity:"
      gets 55555
      puts "item 5 has not been added"


# 6  Asks for quantity again if incorrect quantity' do

      puts "Welcome to the shop management program!"
      puts "What do you want to do?"
      puts "  1 = list all shop items"
      puts "  2 = create a new item"
      puts "  3 = list all orders"
      puts "  4 = create a new order"
      gets 2
      puts "Enter Item name:"
      gets "item 5"
      puts "Enter Unit Price:"
      gets "55555.55"
      puts "Enter Quantity:"
      gets "string"
      puts "Enter Quantity:"
      gets 55555
      puts "item 5 has not been added"

# 7  Inserts new order when 3 input' do

      puts "Welcome to the shop management program!"
      puts "What do you want to do?"
      puts "  1 = list all shop items"
      puts "  2 = create a new item"
      puts "  3 = list all orders"
      puts "  4 = create a new order"
      gets 4
      puts "Enter Customer name:"
      gets "customer 9"
      puts "Enter Order date:"
      gets "2022-01-25"
      puts "Enter Item ID:"
      gets 1
      puts "Order for customer 9 has been added"

# 8   Asks for Item ID again if incorrect if not int' do

      puts "Welcome to the shop management program!"
      puts "What do you want to do?"
      puts "  1 = list all shop items"
      puts "  2 = create a new item"
      puts "  3 = list all orders"
      puts "  4 = create a new order"
      gets 4
      puts "Enter Customer name:"
      gets "customer 9"
      puts "Enter Order date:"
      gets "2022-01-25"
      puts "Enter Item ID:"
      gets "string"
      puts "Enter Item ID:"
      gets 1
      puts "Order for customer 9 has been added"
   

# 9   Asks for Date again if incorrect date format' do

      puts "Welcome to the shop management program!"
      puts "What do you want to do?"
      puts "  1 = list all shop items"
      puts "  2 = create a new item"
      puts "  3 = list all orders"
      puts "  4 = create a new order"
      gets 4
      puts "Enter Customer name:"
      gets "customer 9"
      puts "Enter Order date:"
      gets "string"
      puts "Enter Order date:"
      gets "2022-01-25"
      puts "Enter Item ID:"
      gets 1
      puts "Order for customer 9 has been added"

# 8   Asks for Item ID again if incorrect if no item id' do

      puts "Welcome to the shop management program!"
      puts "What do you want to do?"
      puts "  1 = list all shop items"
      puts "  2 = create a new item"
      puts "  3 = list all orders"
      puts "  4 = create a new order"
      gets 4
      puts "Enter Customer name:"
      gets "customer 9"
      puts "Enter Order date:"
      gets "2022-01-25"
      puts "Enter Item ID:"
      gets 6
      puts "Enter Item ID:"
      gets 1
      puts "Order for customer 9 has been added"
   

```

## 4. Create Examples as Unit Tests

_Create examples, where appropriate, of the behaviour of each relevant class at
a more granular level of detail._

```ruby
# EXAMPLE

# Constructs a track
track = Track.new("Carte Blanche", "Veracocha")
track.title # => "Carte Blanche"
```

_Encode each example as a test. You can add to the above list as you go._

## 5. Implement the Behaviour

_After each test you write, follow the test-driving process of red, green,
refactor to implement the behaviour._
