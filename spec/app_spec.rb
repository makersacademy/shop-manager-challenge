require_relative "../app.rb"

RSpec.describe Application do

    def reset_shop_tables
      seed_sql = File.read('spec/shop_manager_seeds.sql')
      connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
      connection.exec(seed_sql)
    end
  
    before(:each) do 
      reset_shop_tables
    end

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

    it 'lists all shop orders' do
      io = double :io
      app = Application.new("shop_manager_test", io, OrderRepository.new, ItemRepository.new)
      expect(io).to receive(:puts).with "Welcome to the shop management program!"
      expect(io).to receive(:puts).with "\nWhat do you want to do?"
      expect(io).to receive(:puts).with "1 = list all shop items\n2 = create a new item"
      expect(io).to receive(:puts).with "3 = list all orders\n4 = create a new order"
      expect(io).to receive(:puts).with "Enter your choice:"
      expect(io).to receive(:gets).and_return "3"
      expect(io).to receive(:puts).with "Here is the list of orders:"
      expect(io).to receive(:puts).with "* 1 - Brenda - Fanta - Order date: 2023-01-01"
      expect(io).to receive(:puts).with "* 2 - Keith - Coke - Order date: 2022-12-31"
      app.run 
    end

    it 'creates a new item' do
      io = double :io
      app = Application.new("shop_manager_test", io, OrderRepository.new, ItemRepository.new)
      expect(io).to receive(:puts).with "Welcome to the shop management program!"
      expect(io).to receive(:puts).with "\nWhat do you want to do?"
      expect(io).to receive(:puts).with "1 = list all shop items\n2 = create a new item"
      expect(io).to receive(:puts).with "3 = list all orders\n4 = create a new order"
      expect(io).to receive(:puts).with "Enter your choice:"
      expect(io).to receive(:gets).and_return "2"
      expect(io).to receive(:puts).with "Enter new item name:"
      expect(io).to receive(:gets).and_return "Redbull"
      expect(io).to receive(:puts).with "Enter new item unit price:"
      expect(io).to receive(:gets).and_return "3"
      expect(io).to receive(:puts).with "Enter new item quantity:"
      expect(io).to receive(:gets).and_return "600"      
      app.run 
    end

    it 'creates a new order' do
      io = double :io
      app = Application.new("shop_manager_test", io, OrderRepository.new, ItemRepository.new)
      expect(io).to receive(:puts).with "Welcome to the shop management program!"
      expect(io).to receive(:puts).with "\nWhat do you want to do?"
      expect(io).to receive(:puts).with "1 = list all shop items\n2 = create a new item"
      expect(io).to receive(:puts).with "3 = list all orders\n4 = create a new order"
      expect(io).to receive(:puts).with "Enter your choice:"
      expect(io).to receive(:gets).and_return "4"
      expect(io).to receive(:puts).with "Enter new customer name:"
      expect(io).to receive(:gets).and_return "Clive"
      expect(io).to receive(:puts).with "Enter new item name:"
      expect(io).to receive(:gets).and_return "Vimto"
      expect(io).to receive(:puts).with "Enter new order date (YYYY-MM--DD):"
      expect(io).to receive(:gets).and_return "2023-03-24"      
      app.run 
    end

    it 'returns an error message for an invalid input' do
      io = double :io
      app = Application.new("shop_manager_test", io, OrderRepository.new, ItemRepository.new)
      expect(io).to receive(:puts).with "Welcome to the shop management program!"
      expect(io).to receive(:puts).with "\nWhat do you want to do?"
      expect(io).to receive(:puts).with "1 = list all shop items\n2 = create a new item"
      expect(io).to receive(:puts).with "3 = list all orders\n4 = create a new order"
      expect(io).to receive(:puts).with "Enter your choice:"
      expect(io).to receive(:gets).and_return "5"
      expect(io).to receive(:puts).with "That is an invalid input."
      app.run 
   end
  end

end