require_relative '../app'

RSpec.describe Application do 
    it 'takes user choice and lists all items' do 
        io = double :io

        expect(io).to receive(:puts).with("Welcome to the shop management program!")
        expect(io).to receive(:puts).with("What would you like to do?")
        expect(io).to receive(:puts).with("1 - List all shop items")
        expect(io).to receive(:puts).with("2 - create a new item")
        expect(io).to receive(:puts).with("3 - list all orders")
        expect(io).to receive(:puts).with("4 - create a new order")
        expect(io).to receive(:puts).with("Enter your choice: ")
        expect(io).to receive(:gets).and_return("1")
        expect(io).to receive(:puts).with("Here is the list of all shop items:")
        expect(io).to receive(:puts).with("#1 - item_1 - Unit price: 10  - Quantity: 100")
        expect(io).to receive(:puts).with("#1 - item_2 - Unit price: 22 - Quantity: 150")
        
  
        app = Application.new('shop_manager_test', io, 'stock_repository', 'order_repository')
        app.run 
    end
end