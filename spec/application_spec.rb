require 'application'
require './items/lib/item_repository'
require './orders/lib/order_repository'

RSpec.describe Application do
  context 'user selects to see list of items' do
    it 'outputs all entries within item table' do
      io = double :io

      expect(io).to receive(:puts).with("Welcome to the shop management program!")
      expect(io).to receive(:puts).with("What do you want to do?")
      expect(io).to receive(:puts).with("1 - List all shop items")
      expect(io).to receive(:puts).with("2 - Create a new item")
      expect(io).to receive(:puts).with("3 - List all orders")
      expect(io).to receive(:puts).with("4 - Create a new order")
      expect(io).to receive(:puts).with("Enter your choice:")
      expect(io).to receive(:gets).and_return("1")
      expect(io).to receive(:puts).with("Here is the list of items:")
      expect(io).to receive(:puts).with("1 Electric Guitar - Unit price: £500 - Quantity: 25")
      expect(io).to receive(:puts).with("2 PS5 - Unit price: £450 - Quantity: 200")
      expect(io).to receive(:puts).with("3 Macbook - Unit price: £875 - Quantity: 23")
      expect(io).to receive(:puts).with("4 Drum kit - Unit price: £750 - Quantity: 10")
      expect(io).to receive(:puts).with("5 Nintendo Switch - Unit price: £300 - Quantity: 500")
      expect(io).to receive(:puts).with("6 Printer - Unit price: £100 - Quantity: 45")
      expect(io).to receive(:puts).with("7 Bass Guitar - Unit price: £365 - Quantity: 99")

      app = Application.new('shop_manager', io, ItemRepository.new, OrderRepository.new)
      app.run
    end
  end

  context 'user chooses to create a new item' do
    xit 'creates a new instance of item' do
      io = double :io

      expect(io).to receive(:puts).with("Welcome to the shop management program!")
      expect(io).to receive(:puts).with("What do you want to do?")
      expect(io).to receive(:puts).with("1 - List all shop items")
      expect(io).to receive(:puts).with("2 - Create a new item")
      expect(io).to receive(:puts).with("3 - List all orders")
      expect(io).to receive(:puts).with("4 - Create a new order")
      expect(io).to receive(:puts).with("Enter your choice:")
      expect(io).to receive(:gets).and_return("2")
      expect(io).to receive(:puts).with("Please enter an item name")
      expect(io).to receive(:gets).and_return("Xbox")
      expect(io).to receive(:puts).with("Please enter a number representing price per unit in GBP")
      expect(io).to receive(:gets).and_return("299")
      expect(io).to receive(:puts).with("Please enter a number representing number of units")
      expect(io).to receive(:gets).and_return("1000")
      expect(io).to receive(:puts).with("Successfully created new item!")

      app = Application.new('shop_manager', io, ItemRepository.new, OrderRepository.new)
      app.run 
    end
  end

  context 'user selects to see list of orders' do
    it 'outputs all entries within a given table' do
      io = double :io

      expect(io).to receive(:puts).with("Welcome to the shop management program!")
      expect(io).to receive(:puts).with("What do you want to do?")
      expect(io).to receive(:puts).with("1 - List all shop items")
      expect(io).to receive(:puts).with("2 - Create a new item")
      expect(io).to receive(:puts).with("3 - List all orders")
      expect(io).to receive(:puts).with("4 - Create a new order")
      expect(io).to receive(:puts).with("Enter your choice:")
      expect(io).to receive(:gets).and_return("3")
      expect(io).to receive(:puts).with("Here is the list of orders:")
      expect(io).to receive(:puts).with("1 Jeff Winger - Date: 24.12.2021 - Item: PS5 - Price: £450")
      expect(io).to receive(:puts).with("2 Jeff Winger - Date: 24.12.2021 - Item: Macbook - Price: £875")
      expect(io).to receive(:puts).with("3 Raymond Holt - Date: 4.6.2022 - Item: Drum kit - Price: £750")
      expect(io).to receive(:puts).with("4 Jake Peralta - Date: 9.9.2022 - Item: Electric Guitar - Price: £500")
      expect(io).to receive(:puts).with("5 Michael Scott - Date: 1.10.2022 - Item: Nintendo Switch - Price: £300")
      expect(io).to receive(:puts).with("6 Dwight Schrute - Date: 6.10.2022 - Item: Printer - Price: £100")
      expect(io).to receive(:puts).with("7 John Dorian - Date: 25.11.2022 - Item: Nintendo Switch - Price: £300")
      
      app = Application.new('shop_manager', io, ItemRepository.new, OrderRepository.new)
      app.run
    end
  end

  context 'user chooses to create a new order' do
    xit 'creates a new instance of order' do
      io = double :io

      expect(io).to receive(:puts).with("Welcome to the shop management program!")
      expect(io).to receive(:puts).with("What do you want to do?")
      expect(io).to receive(:puts).with("1 - List all shop items")
      expect(io).to receive(:puts).with("2 - Create a new item")
      expect(io).to receive(:puts).with("3 - List all orders")
      expect(io).to receive(:puts).with("4 - Create a new order")
      expect(io).to receive(:puts).with("Enter your choice:")
      expect(io).to receive(:gets).and_return("4")
      expect(io).to receive(:puts).with("Please enter an customer name")
      expect(io).to receive(:gets).and_return("Rosa Diaz")
      expect(io).to receive(:puts).with("Please enter an item ID")
      expect(io).to receive(:gets).and_return("4")
      expect(io).to receive(:puts).with("Please enter an order date")
      expect(io).to receive(:gets).and_return("27.11.2022")
      expect(io).to receive(:puts).with("Successfully created new order!")

      app = Application.new('shop_manager', io, ItemRepository.new, OrderRepository.new)
      app.run 
    end
  end

  context 'user inputs option not in menu' do
    it 'asks the user to try again until command is recognised' do
      io = double :io

      item_repo = ItemRepository.new
      order_repo = OrderRepository.new

      expect(io).to receive(:puts).with("Welcome to the shop management program!")
      expect(io).to receive(:puts).with("What do you want to do?")
      expect(io).to receive(:puts).with("1 - List all shop items")
      expect(io).to receive(:puts).with("2 - Create a new item")
      expect(io).to receive(:puts).with("3 - List all orders")
      expect(io).to receive(:puts).with("4 - Create a new order")
      expect(io).to receive(:puts).with("Enter your choice:")
      expect(io).to receive(:gets).and_return("5")
      expect(io).to receive(:puts).with("Please enter a valid option:")
      expect(io).to receive(:puts).with("What do you want to do?")
      expect(io).to receive(:puts).with("1 - List all shop items")
      expect(io).to receive(:puts).with("2 - Create a new item")
      expect(io).to receive(:puts).with("3 - List all orders")
      expect(io).to receive(:puts).with("4 - Create a new order")
      expect(io).to receive(:puts).with("Enter your choice:")
      expect(io).to receive(:gets).and_return("1")
      expect(io).to receive(:puts).with("Here is the list of items:")
      expect(io).to receive(:puts).with("1 Electric Guitar - Unit price: £500 - Quantity: 25")
      expect(io).to receive(:puts).with("2 PS5 - Unit price: £450 - Quantity: 200")
      expect(io).to receive(:puts).with("3 Macbook - Unit price: £875 - Quantity: 23")
      expect(io).to receive(:puts).with("4 Drum kit - Unit price: £750 - Quantity: 10")
      expect(io).to receive(:puts).with("5 Nintendo Switch - Unit price: £300 - Quantity: 500")
      expect(io).to receive(:puts).with("6 Printer - Unit price: £100 - Quantity: 45")
      expect(io).to receive(:puts).with("7 Bass Guitar - Unit price: £365 - Quantity: 99")

      app = Application.new('shop_manager', io, ItemRepository.new, OrderRepository.new)
      app.run
    end
  end
end
