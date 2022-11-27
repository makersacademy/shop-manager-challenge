require 'application'
require './items/lib/item_repository'
require './orders/lib/order_repository'

RSpec.describe Application do
  context 'user selects to see list of items' do
    it 'outputs all entries within item table' do
      io = double :io

      item_repo = ItemRepository.new
      order_repo = OrderRepository.new

      items = item_repo.all
      orders = order_repo.all

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

      app = Application.new('shop_manager', io, item_repo, order_repo)
      app.run
    end
  end

  context 'user selects to see list of orders' do
    it 'outputs all entries within a given table' do
      io = double :io

      item_repo = ItemRepository.new
      order_repo = OrderRepository.new

      orders = order_repo.all
      orders = order_repo.all

      expect(io).to receive(:puts).with("Welcome to the shop management program!")
      expect(io).to receive(:puts).with("What do you want to do?")
      expect(io).to receive(:puts).with("1 - List all shop items")
      expect(io).to receive(:puts).with("2 - Create a new item")
      expect(io).to receive(:puts).with("3 - List all orders")
      expect(io).to receive(:puts).with("4 - Create a new order")
      expect(io).to receive(:puts).with("Enter your choice:")
      expect(io).to receive(:gets).and_return("3")
      expect(io).to receive(:puts).with("Here is the list of orders:")
      expect(io).to receive(:puts).with("1 Jeff Winger - Item ID: 2 - Date: 24.12.2021")
      expect(io).to receive(:puts).with("2 Jeff Winger - Item ID: 3 - Date: 24.12.2021")
      expect(io).to receive(:puts).with("3 Raymond Holt - Item ID: 4 - Date: 4.6.2022")
      expect(io).to receive(:puts).with("4 Jake Peralta - Item ID: 1 - Date: 9.9.2022")
      expect(io).to receive(:puts).with("5 Michael Scott - Item ID: 5 - Date: 1.10.2022")
      expect(io).to receive(:puts).with("6 Dwight Schrute - Item ID: 6 - Date: 6.10.2022")
      expect(io).to receive(:puts).with("7 Troy Barnes - Item ID: 5 - Date: 25.11.2022")

      app = Application.new('shop_manager', io, order_repo, order_repo)
      app.run
    end
  end
end
