require_relative "../app.rb"

RSpec.describe Application do
  context 'from a user menu' do 
    it 'lists all shop items' do
      io = double :io
      app = Application.new("shop_manager_test", io, OrderRepository.new, ItemRepository.new)
      expect(io).to receive(:puts).with "Welcome to the shop management program!"
      expect(io).to receive(:puts).with "\nWhat do you want to do?"
      expect(io).to receive(:puts).with "1 = list all shop items\n2 = create a new item"
      expect(io).to receive(:puts).with "3 = list all orders\n4 = create a new order"
      expect(io).to receive(:puts).with "Enter your choice:"
      expect(io).to receive(:gets).and_return "1"
      expect(io).to receive(:puts).with "Here is the list of items:"
      expect(io).to receive(:puts).with "* 1 - Fanta - Unit price: 1 - Quantity: 300" 
      expect(io).to receive(:puts).with "* 2 - Coke - Unit price: 2 - Quantity: 400"
      app.run 
    end
  end
end