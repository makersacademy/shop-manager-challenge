require_relative '../app'
require_relative '../lib/items_repository'
require_relative '../lib/orders_repository'

RSpec.describe Application do

  def initialize(io)
    @io = io
  end

  def reset_items_table
    seed_sql = File.read('spec/seeds_items.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager' })
    connection.exec(seed_sql)
  end

  def reset_orders_table
    seed_sql = File.read('spec/seeds_orders.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_items_table
    reset_orders_table
  end 

  describe "#welome_choices"
  context "text on initialisation" do
    it "puts list of actions a user can perform" do
      items_repository = double :item_repository
      orders_repository = double :order_repository
      @io = double :io
      database_name = 'shop_manager'
      app = Application.new(database_name, @io, items_repository, orders_repository)
      welcome
      options
      app.print_welcome
      app.print_options
    end
  end

  describe "user selection" do
    context "select 1" do
      it "returns a list of shop items" do
        items_repository = ItemRepository.new
        orders_repository = double :order_repository
        @io = double :io
        database_name = 'shop_manager'
        app = Application.new(database_name, @io, items_repository, orders_repository)
        welcome
        options
        expect(@io).to receive(:gets).and_return("1")
        expect(@io).to receive(:puts).with("Here's a list of all shop items: \n")
        expect(@io).to receive(:puts).with("#1 Scrabble - Unit price: £14 - Quantity: 100")
        expect(@io).to receive(:puts).with("#2 Catan - Unit price: £20 - Quantity: 25")
        app.run
      end
    end

    context "select 3" do
      it "returns a list of orders" do
        items_repository = ItemRepository.new
        orders_repository = OrderRepository.new
        @io = double :io
        database_name = 'shop_manager'
        app = Application.new(database_name, @io, items_repository, orders_repository)
        welcome
        options
        expect(@io).to receive(:gets).and_return("3")
        expect(@io).to receive(:puts).with("Here's a list of all orders: \n")
        expect(@io).to receive(:puts).with("#1 Order name: Stephen - Order date: 2022-09-29")
        expect(@io).to receive(:puts).with("#2 Order name: Alan - Order date: 2022-10-01")
        app.run
      end
    end

    context "select 2" do
      it "allows user to create new list item" do
        items_repository = ItemRepository.new
        orders_repository = OrderRepository.new
        @io = double :io
        database_name = 'shop_manager'
        app = Application.new(database_name, @io, items_repository, orders_repository)
        welcome
        options
        expect(@io).to receive(:gets).and_return("2")
        expect(@io).to receive(:puts).with("Please enter an item name")
        expect(@io).to receive(:gets).and_return("Chess")
        expect(@io).to receive(:puts).with("Please enter the item's price")
        expect(@io).to receive(:gets).and_return("5")
        expect(@io).to receive(:puts).with("Please enter a quantity of items")
        expect(@io).to receive(:gets).and_return("300")
        expect(@io).to receive(:puts).with("\nNew item added: ")
        expect(@io).to receive(:puts).with("Chess - Unit price: £5 - Quantity: 300")
        app.run
      end
    end

    context "select 4" do
      it "allows user to create a new order" do
        items_repository = ItemRepository.new
        orders_repository = OrderRepository.new
        @io = double :io
        database_name = 'shop_manager'
        app = Application.new(database_name, @io, items_repository, orders_repository)
        welcome
        options
        expect(@io).to receive(:gets).and_return("4")
        expect(@io).to receive(:puts).with("Please enter the customer's name")
        expect(@io).to receive(:gets).and_return("Margaret")
        expect(@io).to receive(:puts).with("Please enter the order date (YYYY-MM-DD)")
        expect(@io).to receive(:gets).and_return("2022-12-25")
        expect(@io).to receive(:puts).with("\nNew item added: ")
        expect(@io).to receive(:puts).with("Customer name: Margaret - Date: 2022-12-25")
      end
    end
  end
      
  private

  def welcome
    expect(@io).to receive(:puts).with("\nWelcome to the Game-azon management program!")
  end

  def options
    expect(@io).to receive(:puts).with("\nWhat do you want to do?")
    expect(@io).to receive(:puts).with("1 = list all shop items")
    expect(@io).to receive(:puts).with("2 = create a new item")
    expect(@io).to receive(:puts).with("3 = list all orders")
    expect(@io).to receive(:puts).with("4 = create a new order")
    expect(@io).to receive(:puts).with("9 = exit app\n\n")
    expect(@io).to receive(:puts).with("Enter:")
  end
end