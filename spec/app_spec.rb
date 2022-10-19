require_relative '../app'

def reset_tables
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe Application do
  before(:each) do 
    reset_tables
  end
  
  describe "#run" do
    it "quits when the user selects \'q\'" do
      io = double(:io)
      database_name = 'shop_manager_test'
      item_repository = double(:items)
      order_repository = double(:orders)
      
      application = Application.new(database_name, io, item_repository, order_repository)
      
      expect(io).to receive(:puts).with("\nWelcome to the shop management program!\n\n")
      expect(io).to receive(:puts).with("What do you want to do?")
      expect(io).to receive(:puts).with("  1 = list all shop items")
      expect(io).to receive(:puts).with("  2 = create a new item")
      expect(io).to receive(:puts).with("  3 = list all orders")
      expect(io).to receive(:puts).with("  4 = create a new order")
      expect(io).to receive(:puts).with("  q = quit\n\n")
      expect(io).to receive(:print).with("Your choice: ")
      expect(io).to receive(:gets).and_return('q')
      expect(io).to receive(:puts).with("\nGoodbye!")
      application.run
    end
    
    it "loops when the user inputs an invalid options" do
      io = double(:io)
      database_name = 'shop_manager_test'
      item_repository = double(:items)
      order_repository = double(:orders)
      
      application = Application.new(database_name, io, item_repository, order_repository)
      
      expect(io).to receive(:puts).with("\nWelcome to the shop management program!\n\n")
      expect(io).to receive(:puts).with("What do you want to do?")
      expect(io).to receive(:puts).with("  1 = list all shop items")
      expect(io).to receive(:puts).with("  2 = create a new item")
      expect(io).to receive(:puts).with("  3 = list all orders")
      expect(io).to receive(:puts).with("  4 = create a new order")
      expect(io).to receive(:puts).with("  q = quit\n\n")
      expect(io).to receive(:print).with("Your choice: ")
      expect(io).to receive(:gets).and_return('p')
      expect(io).to receive(:puts).with("\n[!] Please select a valid option\n\n")
      expect(io).to receive(:puts).with("What do you want to do?")
      expect(io).to receive(:puts).with("  1 = list all shop items")
      expect(io).to receive(:puts).with("  2 = create a new item")
      expect(io).to receive(:puts).with("  3 = list all orders")
      expect(io).to receive(:puts).with("  4 = create a new order")
      expect(io).to receive(:puts).with("  q = quit\n\n")
      expect(io).to receive(:print).with("Your choice: ")
      expect(io).to receive(:gets).and_return('q')
      expect(io).to receive(:puts).with("\nGoodbye!")
      application.run
    end
    
    it "prints a list of items when the user selects \'1\'" do
      io = double(:io)
      database_name = 'shop_manager_test'
      item_repository = double(:items)
      order_repository = double(:orders)
      
      application = Application.new(database_name, io, item_repository, order_repository)
      
      expect(io).to receive(:puts).with("\nWelcome to the shop management program!\n\n")
      expect(io).to receive(:puts).with("What do you want to do?")
      expect(io).to receive(:puts).with("  1 = list all shop items")
      expect(io).to receive(:puts).with("  2 = create a new item")
      expect(io).to receive(:puts).with("  3 = list all orders")
      expect(io).to receive(:puts).with("  4 = create a new order")
      expect(io).to receive(:puts).with("  q = quit\n\n")
      expect(io).to receive(:print).with("Your choice: ")
      expect(io).to receive(:gets).and_return('1')
      expect(item_repository).to receive(:all).and_return([
        double(:item_1, id: 1, item: 'item_1', unit_price: 1.99, quantity: 2),
        double(:item_2, id: 2, item: 'item_2', unit_price: 2.99, quantity: 4),
        double(:item_3, id: 3, item: 'item_3', unit_price: 3.99, quantity: 6),
      ])
      
      expect(io).to receive(:puts).with("\nHere\'s a list of all shop items:\n\n")
      expect(io).to receive(:puts).with(
        "#1 item_1 - Unit price: 1.99 - Quantity: 2\n#2 item_2 - Unit price: 2.99 - Quantity: 4\n#3 item_3 - Unit price: 3.99 - Quantity: 6")
      expect(io).to receive(:puts).with("\n\n")
      expect(io).to receive(:puts).with("What do you want to do?")
      expect(io).to receive(:puts).with("  1 = list all shop items")
      expect(io).to receive(:puts).with("  2 = create a new item")
      expect(io).to receive(:puts).with("  3 = list all orders")
      expect(io).to receive(:puts).with("  4 = create a new order")
      expect(io).to receive(:puts).with("  q = quit\n\n")
      expect(io).to receive(:print).with("Your choice: ")
      expect(io).to receive(:gets).and_return('q')
      expect(io).to receive(:puts).with("\nGoodbye!")
      application.run
    end
    
    it "creates a new item when the user selects \'2\'" do
      io = double(:io)
      database_name = 'shop_manager_test'
      item_repository = double(:items)
      order_repository = double(:orders)
          
      application = Application.new(database_name, io, item_repository, order_repository)
      
      expect(io).to receive(:puts).with("\nWelcome to the shop management program!\n\n")
      expect(io).to receive(:puts).with("What do you want to do?")
      expect(io).to receive(:puts).with("  1 = list all shop items")
      expect(io).to receive(:puts).with("  2 = create a new item")
      expect(io).to receive(:puts).with("  3 = list all orders")
      expect(io).to receive(:puts).with("  4 = create a new order")
      expect(io).to receive(:puts).with("  q = quit\n\n")
      expect(io).to receive(:print).with("Your choice: ")
      expect(io).to receive(:gets).and_return('2')
      expect(io).to receive(:puts).with("\nPlease provide details for the new item\n\n")
      expect(io).to receive(:print).with("Item name: ")
      expect(io).to receive(:gets).and_return('new_item')
      expect(io).to receive(:print).with("Unit price: ")
      expect(io).to receive(:gets).and_return('99.99')
      expect(io).to receive(:print).with("Quantity: ")
      expect(io).to receive(:gets).and_return('10000')
      expect(item_repository).to receive(:create).and_return(nil)
      expect(io).to receive(:puts).with("\n[+] New item created")
      
      expect(io).to receive(:puts).with("What do you want to do?")
      expect(io).to receive(:puts).with("  1 = list all shop items")
      expect(io).to receive(:puts).with("  2 = create a new item")
      expect(io).to receive(:puts).with("  3 = list all orders")
      expect(io).to receive(:puts).with("  4 = create a new order")
      expect(io).to receive(:puts).with("  q = quit\n\n")
      expect(io).to receive(:print).with("Your choice: ")
      expect(io).to receive(:gets).and_return('q')
      expect(io).to receive(:puts).with("\nGoodbye!")
      application.run

      
    end
  end
  
end
