require_relative '../app'
require 'item_repository'
require 'order_repository'

def reset_tables
  seed_sql = File.read('spec/seeds_items_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'items_orders_test' })
  connection.exec(seed_sql)
end

describe Application do
  
  before(:each) do 
    reset_tables
  end

  context "when user requests app to 'list all shop items'" do
    it "lists all shop items" do
      database_name = "items_orders_test"
      io = double :io
      item_repository = ItemRepository.new
      order_repository = OrderRepository.new
      app = Application.new(database_name, io, item_repository, order_repository)
      
      expect(io).to receive(:puts).with("Welcome to the shop management program!\n")
      expect(io).to receive(:puts).with("What do you want to do?")
      expect(io).to receive(:puts).with(" 1 = list all shop items")
      expect(io).to receive(:puts).with(" 2 = create a new item")
      expect(io).to receive(:puts).with(" 3 = list all orders")
      expect(io).to receive(:puts).with(" 4 = create a new order\n")
      expect(io).to receive(:gets).and_return("1")
      expect(io).to receive(:puts).with("\nHere's a list of all shop items:\n")
      expect(io).to receive(:puts).with(" #1 Henry Hoover - unit price: £79 - quantity remaining: 19")
      expect(io).to receive(:puts).with(" #2 Dyson Vacuum - unit price: £199 - quantity remaining: 28")
      expect(io).to receive(:puts).with(" #3 Dualit Toaster - unit price: £49 - quantity remaining: 39")
      expect(io).to receive(:puts).with(" #4 Breville Kettle - unit price: £39 - quantity remaining: 34")
      expect(io).to receive(:puts).with(" #5 Panasonic Microwave - unit price: £59 - quantity remaining: 29")

      app.run
    end
  end

  context "when user requests app to 'create a new item'" do
    it "creates a new item" do
      database_name = "items_orders_test"
      io = double :io
      item_repository = ItemRepository.new
      order_repository = OrderRepository.new
      app = Application.new(database_name, io, item_repository, order_repository)

      expect(io).to receive(:puts).with("Welcome to the shop management program!\n")
      expect(io).to receive(:puts).with("What do you want to do?")
      expect(io).to receive(:puts).with(" 1 = list all shop items")
      expect(io).to receive(:puts).with(" 2 = create a new item")
      expect(io).to receive(:puts).with(" 3 = list all orders")
      expect(io).to receive(:puts).with(" 4 = create a new order\n")
      expect(io).to receive(:gets).and_return("2")

      expect(io).to receive(:puts).with("Please enter the following item information:")
      expect(io).to receive(:puts).with("Item name: ")
      expect(io).to receive(:gets).and_return("Nespresso Coffee Maker")
      expect(io).to receive(:puts).with("Unit price: ")
      expect(io).to receive(:gets).and_return("49")
      expect(io).to receive(:puts).with("Quantity remaining: ")
      expect(io).to receive(:gets).and_return("32")
      expect(io).to receive(:puts).with("This item has been successfully added")
      
      app.run

      expect(io).to receive(:puts).with("Welcome to the shop management program!\n")
      expect(io).to receive(:puts).with("What do you want to do?")
      expect(io).to receive(:puts).with(" 1 = list all shop items")
      expect(io).to receive(:puts).with(" 2 = create a new item")
      expect(io).to receive(:puts).with(" 3 = list all orders")
      expect(io).to receive(:puts).with(" 4 = create a new order\n")
      expect(io).to receive(:gets).and_return("1")
      expect(io).to receive(:puts).with("\nHere's a list of all shop items:\n")
      expect(io).to receive(:puts).with(" #1 Henry Hoover - unit price: £79 - quantity remaining: 19")
      expect(io).to receive(:puts).with(" #2 Dyson Vacuum - unit price: £199 - quantity remaining: 28")
      expect(io).to receive(:puts).with(" #3 Dualit Toaster - unit price: £49 - quantity remaining: 39")
      expect(io).to receive(:puts).with(" #4 Breville Kettle - unit price: £39 - quantity remaining: 34")
      expect(io).to receive(:puts).with(" #5 Panasonic Microwave - unit price: £59 - quantity remaining: 29")
      expect(io).to receive(:puts).with(" #6 Nespresso Coffee Maker - unit price: £49 - quantity remaining: 32")


      app.run
    end
  end

  context "when user requests app to 'list all orders'" do
    it "lists all orders" do
      database_name = "items_orders_test"
      io = double :io
      item_repository = ItemRepository.new
      order_repository = OrderRepository.new
      app = Application.new(database_name, io, item_repository, order_repository)
      
      expect(io).to receive(:puts).with("Welcome to the shop management program!\n")
      expect(io).to receive(:puts).with("What do you want to do?")
      expect(io).to receive(:puts).with(" 1 = list all shop items")
      expect(io).to receive(:puts).with(" 2 = create a new item")
      expect(io).to receive(:puts).with(" 3 = list all orders")
      expect(io).to receive(:puts).with(" 4 = create a new order\n")
      expect(io).to receive(:gets).and_return("3")
      expect(io).to receive(:puts).with("\nHere's a list of all orders:\n")
      expect(io).to receive(:puts).with(" #1 Customer: Andy Lewis - item id: 2 - date order was placed: 2022-11-23")
      expect(io).to receive(:puts).with(" #2 Customer: James Scott - item id: 5 - date order was placed: 2022-11-24")
      expect(io).to receive(:puts).with(" #3 Customer: Christine Smith - item id: 4 - date order was placed: 2022-11-24")
      expect(io).to receive(:puts).with(" #4 Customer: Louise Stones - item id: 1 - date order was placed: 2022-11-25")
      expect(io).to receive(:puts).with(" #5 Customer: Michael Kelly - item id: 3 - date order was placed: 2022-11-26")
      expect(io).to receive(:puts).with(" #6 Customer: Catherine Wells - item id: 2 - date order was placed: 2022-11-27")

      app.run
    end
  end

  context "when user requests app to 'create a new order'" do
    it "creates a new order" do
      database_name = "items_orders_test"
      io = double :io
      item_repository = ItemRepository.new
      order_repository = OrderRepository.new
      app = Application.new(database_name, io, item_repository, order_repository)
      
      expect(io).to receive(:puts).with("Welcome to the shop management program!\n")
      expect(io).to receive(:puts).with("What do you want to do?")
      expect(io).to receive(:puts).with(" 1 = list all shop items")
      expect(io).to receive(:puts).with(" 2 = create a new item")
      expect(io).to receive(:puts).with(" 3 = list all orders")
      expect(io).to receive(:puts).with(" 4 = create a new order\n")
      expect(io).to receive(:gets).and_return("4")

      expect(io).to receive(:puts).with("Please enter the following order information:")
      expect(io).to receive(:puts).with("Customer name: ")
      expect(io).to receive(:gets).and_return("Joe Bloggs")
      expect(io).to receive(:puts).with("Item id: ")
      expect(io).to receive(:gets).and_return("1")
      expect(io).to receive(:puts).with("Date of order (YYYY-MM-DD): ")
      expect(io).to receive(:gets).and_return("2022-11-28")
      expect(io).to receive(:puts).with("This order has been successfully added")

      app.run

      expect(io).to receive(:puts).with("Welcome to the shop management program!\n")
      expect(io).to receive(:puts).with("What do you want to do?")
      expect(io).to receive(:puts).with(" 1 = list all shop items")
      expect(io).to receive(:puts).with(" 2 = create a new item")
      expect(io).to receive(:puts).with(" 3 = list all orders")
      expect(io).to receive(:puts).with(" 4 = create a new order\n")
      expect(io).to receive(:gets).and_return("3")
      expect(io).to receive(:puts).with("\nHere's a list of all orders:\n")
      expect(io).to receive(:puts).with(" #1 Customer: Andy Lewis - item id: 2 - date order was placed: 2022-11-23")
      expect(io).to receive(:puts).with(" #2 Customer: James Scott - item id: 5 - date order was placed: 2022-11-24")
      expect(io).to receive(:puts).with(" #3 Customer: Christine Smith - item id: 4 - date order was placed: 2022-11-24")
      expect(io).to receive(:puts).with(" #4 Customer: Louise Stones - item id: 1 - date order was placed: 2022-11-25")
      expect(io).to receive(:puts).with(" #5 Customer: Michael Kelly - item id: 3 - date order was placed: 2022-11-26")
      expect(io).to receive(:puts).with(" #6 Customer: Catherine Wells - item id: 2 - date order was placed: 2022-11-27")
      expect(io).to receive(:puts).with(" #7 Customer: Joe Bloggs - item id: 1 - date order was placed: 2022-11-28")

      app.run
    end
  end

  context "when user enters an invalid command" do
    it "raises error" do
      database_name = "items_orders_test"
      io = double :io
      item_repository = ItemRepository.new
      order_repository = OrderRepository.new
      app = Application.new(database_name, io, item_repository, order_repository)
      
      expect(io).to receive(:puts).with("Welcome to the shop management program!\n")
      expect(io).to receive(:puts).with("What do you want to do?")
      expect(io).to receive(:puts).with(" 1 = list all shop items")
      expect(io).to receive(:puts).with(" 2 = create a new item")
      expect(io).to receive(:puts).with(" 3 = list all orders")
      expect(io).to receive(:puts).with(" 4 = create a new order\n")
      expect(io).to receive(:gets).and_return("5")
      expect(io).to receive(:puts).with("Only 1, 2, 3 and 4 are valid commands")

      app.run
    end
  end
end