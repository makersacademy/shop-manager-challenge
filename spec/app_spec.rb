require_relative '../app'

RSpec.describe Application do
  def reset_orders_table 
    seed_sql = File.read('spec/seeds_orders.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  def reset_items_table 
    seed_sql = File.read('spec/seeds_items.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end  

  before(:each) do
    reset_orders_table
    reset_items_table
  end

  context 'When user Selects 1' do
    it 'prints all items' do
      io = double :io
      expect(io).to receive(:puts).with("Welcome to the shop management program!\n \nWhat would you like to do?\n1 = list all shop items\n2 = create a new item\n3 = list all orders\n4 = create a new order\n\n\n\nEnter your choice:").ordered
      expect(io).to receive(:gets).and_return("1").ordered
      expect(io).to receive(:puts).with("\nHere's a list of all shop items:\n").ordered
      expect(io).to receive(:puts).with("#1 Super Shark Vacuum Cleaner - Unit price: 99 - Quantity: 30").ordered
      expect(io).to receive(:puts).with("#2 Makerspresso Coffee Machine - Unit price: 69 - Quantity: 15").ordered

      app = Application.new('shop_manager_test', io, OrderRepository.new, ItemRepository.new)
      app.run
    end
  end

  context "When user Selects 2" do
    it 'should allow the user to create a new item and then return the full list' do
      io = double :io
      expect(io).to receive(:puts).with("Welcome to the shop management program!\n \nWhat would you like to do?\n1 = list all shop items\n2 = create a new item\n3 = list all orders\n4 = create a new order\n\n\n\nEnter your choice:").ordered
      expect(io).to receive(:gets).and_return("2").ordered
      expect(io).to receive(:puts).with("\nPlease enter the NAME of the item and hit enter")
      expect(io).to receive(:gets).and_return("Fight Milk").ordered
      expect(io).to receive(:puts).with("\nPlease enter the UNIT PRICE of the item and hit enter")
      expect(io).to receive(:gets).and_return("19").ordered
      expect(io).to receive(:puts).with("\nPlease enter the STOCK QUANTITY of the item and hit enter")
      expect(io).to receive(:gets).and_return("200").ordered
      expect(io).to receive(:puts).with("\nHere's a list of all shop items:\n").ordered
      expect(io).to receive(:puts).with("#1 Super Shark Vacuum Cleaner - Unit price: 99 - Quantity: 30").ordered
      expect(io).to receive(:puts).with("#2 Makerspresso Coffee Machine - Unit price: 69 - Quantity: 15").ordered
      expect(io).to receive(:puts).with("#3 Fight Milk - Unit price: 19 - Quantity: 200").ordered

      app = Application.new('shop_manager_test', io, OrderRepository.new, ItemRepository.new)
      app.run
    end
  end

  context 'When user Selects 3' do
    it 'prints all orders' do
      io = double :io
      expect(io).to receive(:puts).with("Welcome to the shop management program!\n \nWhat would you like to do?\n1 = list all shop items\n2 = create a new item\n3 = list all orders\n4 = create a new order\n\n\n\nEnter your choice:").ordered
      expect(io).to receive(:gets).and_return('3').ordered
      expect(io).to receive(:puts).with("\nHere's a list of all orders:\n").ordered
      expect(io).to receive(:puts).with("test")
      

      app = Application.new('shop_manager_test', io, OrderRepository.new, ItemRepository.new)
      app.run
    end
  end

  context "When user Selects 4" do
    it 'should allow the user to create a new item and then return the full list' do
      io = double :io
      expect(io).to receive(:puts).with("Welcome to the shop management program!\n \nWhat would you like to do?\n1 = list all shop items\n2 = create a new item\n3 = list all orders\n4 = create a new order\n\n\n\nEnter your choice:").ordered
      expect(io).to receive(:gets).and_return("4").ordered
      expect(io).to receive(:puts).with("\nPlease enter the CUSTOMER NAME of the order and hit enter")
      expect(io).to receive(:gets).and_return("John Smith").ordered
      expect(io).to receive(:puts).with("\nPlease enter the DATE of the order and hit enter (YYYY-MM-DD)")
      expect(io).to receive(:gets).and_return("1999-12-12").ordered
      expect(io).to receive(:puts).with("\nPlease enter the ITEM ID of the order and hit enter")
      expect(io).to receive(:gets).and_return("1").ordered
      expect(io).to receive(:puts).with("\nHere's a list of all orders:\n").ordered
      expect(io).to receive(:puts).with("#1 Customer: Jack Skates - Order date: 2023-04-28 - Item id: 1")
      expect(io).to receive(:puts).with("#2 Customer: Charlie Kelly - Order date: 2020-08-12 - Item id: 2")
      expect(io).to receive(:puts).with("#3 Customer: John Smith - Order date: 1999-12-12 - Item id: 1").ordered

      app = Application.new('shop_manager_test', io , OrderRepository.new, ItemRepository.new)
      app.run
    end
  end
end