require_relative '../app'
require_relative '../lib/item_repository'
require_relative '../lib/order_repository'
require_relative 'reseed_shop_manager_db'
RSpec.describe Application do
  describe Application do
    before(:each) do 
      reseed_tables
    end

    def displays_welcome_message(io)
      expect(io).to receive(:puts).with("Welcome to the shop management program!")
      expect(io).to receive(:puts).with(no_args)
      expect(io).to receive(:puts).with("What do you want to do?")
      expect(io).to receive(:puts).with(" 1 - list all shop items")
      expect(io).to receive(:puts).with(" 2 - create a new item")
      expect(io).to receive(:puts).with(" 3 - list all orders")
      expect(io).to receive(:puts).with(" 4 - create a new order")
      expect(io).to receive(:puts).with(no_args)
      expect(io).to receive(:puts).with("Enter your choice: ")
    end

    def displays_all_items(io)
      expect(io).to receive(:puts).with("#1 - Super Shark Vacuum Cleaner - Unit price: 99 - Quantity: 30")
      expect(io).to receive(:puts).with("#2 - Makerspresso Coffee Machine - Unit price: 69 - Quantity: 15")
      expect(io).to receive(:puts).with("#3 - Bush Smart HD TV - Unit price: 75 - Quantity: 10")
      expect(io).to receive(:puts).with("#4 - Bosh Food Processor - Unit price: 60 - Quantity: 20")
      expect(io).to receive(:puts).with("#5 - Nutribullet Juicer - Unit price: 80 - Quantity: 30")
      expect(io).to receive(:puts).with("#6 - Bush Smart HD TV - Unit price: 75 - Quantity: 10")
    end

    def displays_all_orders(io)
      expect(io).to receive(:puts).with("Customer name: Ana - Order date: 2023-01-01")
      expect(io).to receive(:puts).with("Customer name: Sam - Order date: 2023-02-01")
      expect(io).to receive(:puts).with("Customer name: Jane - Order date: 2023-03-01")
      expect(io).to receive(:puts).with("Customer name: Carol - Order date: 2023-04-01")
      expect(io).to receive(:puts).with("Customer name: Ana - Order date: 2023-01-01")
      expect(io).to receive(:puts).with("Customer name: Ana - Order date: 2023-01-01")
    end

    it 'displays all items' do 
      io = double :io
      displays_all_items(io)
      item_repository = ItemRepository.new
      order_repository = OrderRepository.new
      app = Application.new('shop_manager_test', io, item_repository, order_repository)
      app.list_of_items
    end

    it 'displays_all_orders' do
      io = double :io
       displays_all_orders(io)
      item_repository = ItemRepository.new
      order_repository = OrderRepository.new
      app = Application.new('shop_manager_test', io, item_repository, order_repository)
      app.list_of_orders
    end

    it "Lists all items when users chooses 1" do
      io = double :io
      displays_welcome_message(io)
      expect(io).to receive(:gets).and_return("1")
      displays_all_items(io)
      expect(io).to receive(:puts).with(no_args)
      item_repository = ItemRepository.new
      order_repository = OrderRepository.new
      app = Application.new('shop_manager_test', io, item_repository, order_repository)
      app.run
    end

    it "Lists all orders when users chooses 3" do
      io = double :io
      displays_welcome_message(io)
      expect(io).to receive(:gets).and_return("3")
      displays_all_orders(io)
      expect(io).to receive(:puts).with(no_args)
      item_repository = ItemRepository.new
      order_repository = OrderRepository.new
      app = Application.new('shop_manager_test', io, item_repository, order_repository)
      app.run
    end
    
    it "displays an error message if user makes wrong choice" do
      io = double :io 
      displays_welcome_message(io)       
      expect(io).to receive(:gets).and_return("5")
      expect(io).to receive(:puts).with("That is not a valid choice.")
      expect(io).to receive(:puts).with(no_args)
      item_repository = ItemRepository.new
      order_repository = OrderRepository.new
      app = Application.new('shop_manager_test', io, item_repository, order_repository)
      app.run
    end

    it 'creates a new item' do
      io = double :io
      displays_welcome_message(io)       
      expect(io).to receive(:gets).and_return("2")
      expect(io).to receive(:puts).with("A new item was created!")
      expect(io).to receive(:puts).with("Bosh Rice Cooker - Unit price: 10, Quantity: 33")
      expect(io).to receive(:puts).with(no_args)
      item_repository = ItemRepository.new
      order_repository = OrderRepository.new
      app = Application.new('shop_manager_test', io, item_repository, order_repository)
      app.run
    end

    it 'creates a new order' do
      io = double :io
      displays_welcome_message(io)       
      expect(io).to receive(:gets).and_return("4")
      expect(io).to receive(:puts).with("A new order was created!")
      expect(io).to receive(:puts).with("Customer name: Bernard, - Order date: 2023-05-01")
      expect(io).to receive(:puts).with(no_args)
      item_repository = ItemRepository.new
      order_repository = OrderRepository.new
      app = Application.new('shop_manager_test', io, item_repository, order_repository)
      app.run
    end

    it 'handles manager choice 2' do
      io = double :io
      expect(io).to receive(:puts).with(no_args)
      expect(io).to receive(:puts).with("A new item was created!")
      expect(io).to receive(:puts).with("Bosh Rice Cooker - Unit price: 10, Quantity: 33")
      item_repository = ItemRepository.new
      order_repository = OrderRepository.new
      app = Application.new('shop_manager_test', io, item_repository, order_repository)
      app.handle_choice("2")
    end

    it 'handles manager choice 4' do
      io = double :io
      expect(io).to receive(:puts).with(no_args)
      expect(io).to receive(:puts).with("A new order was created!")
      expect(io).to receive(:puts).with("Customer name: Bernard, - Order date: 2023-05-01")
      item_repository = ItemRepository.new
      order_repository = OrderRepository.new
      app = Application.new('shop_manager_test', io, item_repository, order_repository)
      app.handle_choice("4")
    end

    it 'handles manager choice 1' do
      io = double :io
      expect(io).to receive(:puts).with(no_args)
      displays_all_items(io)     
      item_repository = ItemRepository.new
      order_repository = OrderRepository.new
      app = Application.new('shop_manager_test', io, item_repository, order_repository)
      app.handle_choice("1")
    end

    it 'handles manager choice 3' do
      io = double :io
      expect(io).to receive(:puts).with(no_args)
      displays_all_orders(io)
      item_repository = ItemRepository.new
      order_repository = OrderRepository.new
      app = Application.new('shop_manager_test', io, item_repository, order_repository)
      app.handle_choice("3")
    end
  end
end
