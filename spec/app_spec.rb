require_relative '../app'

RSpec.describe Application do
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
        double(:item, id: 1, item: 'item_1', unit_price: 1.99, quantity: 2),
        double(:item, id: 2, item: 'item_2', unit_price: 2.99, quantity: 4),
        double(:item, id: 3, item: 'item_3', unit_price: 3.99, quantity: 6),
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
      expect(item_repository).to receive(:create).and_return(10)
      expect(io).to receive(:puts).with("\n[+] New item created with id: 10")
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
    
    it "prints a list of orders when the user selects \'3\'" do
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
      expect(io).to receive(:gets).and_return('3')
      expect(order_repository).to receive(:all).and_return([
        double(:order, id: 1, order_date: '2022-10-10', customer_name: "customer_1"),
        double(:order, id: 2, order_date: '2022-10-11', customer_name: "customer_2"),
        double(:order, id: 3, order_date: '2022-10-12', customer_name: "customer_3")
      ])
      
      expect(io).to receive(:puts).with("\nHere\'s a list of all orders:\n\n")
      expect(io).to receive(:puts).with("#1 2022-10-10 - customer_1\n#2 2022-10-11 - customer_2\n#3 2022-10-12 - customer_3")
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
    
    it "creates a new order when the user selects \'4\'" do
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
      expect(io).to receive(:gets).and_return('4')
      expect(io).to receive(:puts).with("\nPlease provide details for the new order\n\n")
      expect(io).to receive(:print).with("Order date [YYYY-MM-DD]: ")
      expect(io).to receive(:gets).and_return('2022-10-19')
      expect(io).to receive(:print).with("Customer name: ")
      expect(io).to receive(:gets).and_return('new_customer')
      expect(order_repository).to receive(:create).and_return(20)
      expect(io).to receive(:puts).with("\n[+] New order created with id: 20\n\n")
      expect(io).to receive(:print).with("Which item would you like to link this order to?: ")
      expect(io).to receive(:gets).and_return('1')
      expect(order_repository).to receive(:assign_order_to_item)
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
