require_relative '../app'

RSpec.describe Application do
  def reset_items_and_orders_tables
    seed_sql = File.read('spec/seeds_shop_manager.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end
    
  before(:each) do 
    reset_items_and_orders_tables
  end

  describe "#run" do
    context "when the users selects 1" do
      it "returns the list of items" do
        io = double :terminal
        expect(io).to receive(:puts).with("Welcome to the shop management program!\n \n").ordered
        expect(io).to receive(:puts).with("What do you want to do?\n1 = list all shop items\n2 = create a new item\n3 = list all orders\n4 = create a new order\n").ordered
        expect(io).to receive(:gets).and_return('1').ordered
        expect(io).to receive(:puts).with("\nHere's a list of all shop items:\n").ordered
        expect(io).to receive(:puts).with("#1 Coffee Machine - Unit price: 99£ - Quantity: 7").ordered
        expect(io).to receive(:puts).with("#2 Vacuum Cleaner - Unit price: 125£ - Quantity: 42").ordered
        expect(io).to receive(:puts).with("#3 Curtain - Unit price: 34£ - Quantity: 205").ordered
        
        app = Application.new('shop_manager_test', io, ItemRepository.new, OrderRepository.new)
        app.run
      end
    end  
    
    context "when the users selects 2" do
      it "creates a new item" do
        io = double :terminal
        expect(io).to receive(:puts).with("Welcome to the shop management program!\n \n").ordered
        expect(io).to receive(:puts).with("What do you want to do?\n1 = list all shop items\n2 = create a new item\n3 = list all orders\n4 = create a new order\n").ordered
        expect(io).to receive(:gets).and_return("2").ordered
        expect(io).to receive(:puts).with("What is the name of the item?").ordered
        expect(io).to receive(:gets).and_return("Projector").ordered
        expect(io).to receive(:puts).with("What is the unit price of the item?").ordered
        expect(io).to receive(:gets).and_return("34").ordered
        expect(io).to receive(:puts).with("What is the stock quantity of the item?").ordered
        expect(io).to receive(:gets).and_return("20").ordered
        expect(io).to receive(:puts).with("The item Projector has been created!").ordered

        app = Application.new('shop_manager_test', io, ItemRepository.new, OrderRepository.new)
        app.run
      end
    end  
    
    context "when the users selects 3" do
      it "returns the list of orders" do
        io = double :terminal
        expect(io).to receive(:puts).with("Welcome to the shop management program!\n \n").ordered
        expect(io).to receive(:puts).with("What do you want to do?\n1 = list all shop items\n2 = create a new item\n3 = list all orders\n4 = create a new order\n").ordered
        expect(io).to receive(:gets).and_return("3").ordered
        expect(io).to receive(:puts).with("\nHere's a list of all shop orders:\n").ordered
        expect(io).to receive(:puts).with("#1 - Customer's name: Andrea - Date: 2023-01-18 - Ordered Item: 1").ordered
        expect(io).to receive(:puts).with("#2 - Customer's name: Céline - Date: 2023-03-14 - Ordered Item: 2").ordered
        expect(io).to receive(:puts).with("#3 - Customer's name: Chiara - Date: 2023-04-19 - Ordered Item: 3").ordered

        app = Application.new('shop_manager_test', io, ItemRepository.new, OrderRepository.new)
        app.run
      end
    end     

    context "when the users selects 4" do
      it "creates a new order" do
        io = double :terminal
        expect(io).to receive(:puts).with("Welcome to the shop management program!\n \n").ordered
        expect(io).to receive(:puts).with("What do you want to do?\n1 = list all shop items\n2 = create a new item\n3 = list all orders\n4 = create a new order\n").ordered
        expect(io).to receive(:gets).and_return("4").ordered
        expect(io).to receive(:puts).with("What is the customer's name of the new order?")
        expect(io).to receive(:gets).and_return("Barbara").ordered
        expect(io).to receive(:puts).with("When has the order been placed? (AAAA-MM-DD)")
        expect(io).to receive(:gets).and_return("2023-04-30").ordered
        expect(io).to receive(:puts).with("What is the item's ID?")
        expect(io).to receive(:gets).and_return("1").ordered
        expect(io).to receive(:puts).with("A new order for the item 1 has been created!")

        app = Application.new('shop_manager_test', io, ItemRepository.new, OrderRepository.new)
        app.run
      end
    end  
  end
end
