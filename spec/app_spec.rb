require_relative '../app'
require_relative '../lib/items_repository'
require_relative '../lib/orders_repository'

RSpec.describe Application do

  def initialize(io)
    @io = io
  end

  before(:each) do 
    reset_tables('spec/seeds_items.sql')
    reset_tables('spec/seeds_orders.sql')
  end 

  describe "#welome_choices"
  context "text on initialisation" do
    it "puts list of actions a user can perform" do
      @io = double :io
      app = Application.new('shop_manager', @io, ItemRepository.new, OrderRepository.new)
      welcome
      options
      app.print_welcome
      app.print_options
    end
  end

  describe "user selection" do
    context "select 1" do
      it "returns a list of shop items" do
        @io = double :io
        app = Application.new('shop_manager', @io, ItemRepository.new, OrderRepository.new)
        welcome
        options
        gets("1")
        puts("Here's a list of all shop items: \n")
        puts("#1 Scrabble - Unit price: £14 - Quantity: 100")
        puts("#2 Catan - Unit price: £20 - Quantity: 25")
        app.run
      end
    end

    context "select 3" do
      it "returns a list of orders" do
        @io = double :io
        app = Application.new('shop_manager', @io, ItemRepository.new, OrderRepository.new)
        welcome
        options
        gets("3")
        puts("Here's a list of all orders: \n")
        puts("#1 Order name: Stephen - Order date: 2022-09-29")
        puts("#2 Order name: Alan - Order date: 2022-10-01")
        app.run
      end
    end

    context "select 2" do
      it "allows user to create new list item" do
        @io = double :io
        app = Application.new('shop_manager', @io, ItemRepository.new, OrderRepository.new)
        welcome
        options
        gets("2")
        puts("Please enter an item name")
        gets("Chess")
        puts("Please enter the item's price")
        gets("5")
        puts("Please enter a quantity of items")
        gets("300")
        puts("\nNew item added: ")
        puts("Chess - Unit price: £5 - Quantity: 300")
        app.run
      end
    end

    context "select 4" do
      it "allows user to create a new order" do
        @io = double :io
        app = Application.new('shop_manager', @io, ItemRepository.new, OrderRepository.new)
        welcome
        options
        gets("4")
        puts("Please enter the customer's name")
        gets("Margaret")
        puts("Please enter the order date (YYYY-MM-DD)")
        gets("2022-12-25")
        puts("\nNew order added: ")
        puts("New order: Customer name: Margaret - Date: 2022-12-25")
        app.run
      end
    end
  end
      
  private

  def reset_tables(table_name)
    seed_sql = File.read(table_name)
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager' })
    connection.exec(seed_sql)
  end

  def welcome
    puts("\nWelcome to the Game-azon management program!")
  end

  def options
    puts("\nWhat do you want to do?")
    puts("1 = list all shop items")
    puts("2 = create a new item")
    puts("3 = list all orders")
    puts("4 = create a new order")
    puts("9 = exit app\n\n")
    puts("Enter:")
  end

  def puts(string)
    expect(@io).to receive(:puts).with(string)
  end

  def gets(string)
    expect(@io).to receive(:gets).and_return(string)
  end
end