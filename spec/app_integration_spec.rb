require_relative '../app'

def reset_tables
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

RSpec.describe "Application Integration" do
  
  describe "#choice_prompt" do
    it "presents a list of options and returns the user\'s choice" do
      io = Kernel
      database_name = 'shop_manager_test'
      item_repository = ItemRepository.new
      order_repository = OrderRepository.new
      
      application = Application.new(database_name, io, item_repository, order_repository)
      
      expect(io).to receive(:puts).with("What do you want to do?")
      expect(io).to receive(:puts).with("  1 = list all shop items")
      expect(io).to receive(:puts).with("  2 = create a new item")
      expect(io).to receive(:puts).with("  3 = list all orders")
      expect(io).to receive(:puts).with("  4 = create a new order")
      expect(io).to receive(:puts).with("  q = quit\n\n")
      expect(io).to receive(:print).with("Your choice: ")
      expect(io).to receive(:gets).and_return('1')
      application.choice_prompt
    end
  end
  
  describe "#list_all_items" do
    it "prints a list of all items in the items table" do
      io = Kernel
      database_name = 'shop_manager_test'
      item_repository = ItemRepository.new
      order_repository = OrderRepository.new
      
      application = Application.new(database_name, io, item_repository, order_repository)
      
      expect(io).to receive(:puts).with("\nHere\'s a list of all shop items:\n\n")
      expect(io).to receive(:puts).with("#1 item_1 - Unit price: 2.99 - Quantity: 2\n#2 item_2 - Unit price: 3.99 - Quantity: 5\n#3 item_3 - Unit price: 5.49 - Quantity: 3\n#4 item_4 - Unit price: 8.99 - Quantity: 10\n#5 item_5 - Unit price: 6.49 - Quantity: 12\n#6 item_6 - Unit price: 9.49 - Quantity: 1\n#7 item_7 - Unit price: 2.49 - Quantity: 30\n#8 item_8 - Unit price: 12.49 - Quantity: 25\n#9 item_9 - Unit price: 11.99 - Quantity: 7\n#10 item_10 - Unit price: 1.49 - Quantity: 9")
      expect(io).to receive(:puts).with("\n\n")
      application.list_all_items
    end
  end
  
  describe "#add_new_item_prompt" do
    it "allows the user to add a new item to the items table" do
      io = Kernel
      database_name = 'shop_manager_test'
      item_repository = ItemRepository.new
      order_repository = OrderRepository.new
      
      number_of_items = item_repository.all.length
          
      application = Application.new(database_name, io, item_repository, order_repository)
      
      expect(io).to receive(:puts).with("\nPlease provide details for the new item\n\n")
      expect(io).to receive(:print).with("Item name: ")
      expect(io).to receive(:gets).and_return('new_item')
      expect(io).to receive(:print).with("Unit price: ")
      expect(io).to receive(:gets).and_return('99.99')
      expect(io).to receive(:print).with("Quantity: ")
      expect(io).to receive(:gets).and_return('10000')
      expect(io).to receive(:puts).with("\n[+] New item created with id: 11")
      application.add_new_item_prompt
      
      expect(item_repository.all.length).to eq (number_of_items + 1)
      expect(item_repository.all).to include (
        have_attributes(
          id: 11,
          item: 'new_item',
          unit_price: 99.99,
          quantity: 10_000
        )
      )
    end
  end
  
  describe "#list_all_orders" do
    it "prints a list of all orders in the orders table" do
      io = Kernel
      database_name = 'shop_manager_test'
      item_repository = ItemRepository.new
      order_repository = OrderRepository.new
      
      application = Application.new(database_name, io, item_repository, order_repository)
      
      expect(io).to receive(:puts).with("\nHere\'s a list of all orders:\n\n")
      expect(io).to receive(:puts).with("#1 2022-10-10 - customer_1\n#2 2022-10-16 - customer_2\n#3 2022-10-18 - customer_3\n#4 2022-10-11 - customer_4\n#5 2022-10-17 - customer_5\n#6 2022-10-09 - customer_6")
      expect(io).to receive(:puts).with("\n\n")
      application.list_all_orders
    end
  end
  
  describe "#add_new_order_prompt" do
    it "allows the user to add a new order to the orders table and link to a given item" do
      io = Kernel
      database_name = 'shop_manager_test'
      item_repository = ItemRepository.new
      order_repository = OrderRepository.new
      
      number_of_orders = order_repository.all.length
      
      application = Application.new(database_name, io, item_repository, order_repository)
      
      expect(io).to receive(:puts).with("\nPlease provide details for the new order\n\n")
      expect(io).to receive(:print).with("Order date [YYYY-MM-DD]: ")
      expect(io).to receive(:gets).and_return('2022-10-19')
      expect(io).to receive(:print).with("Customer name: ")
      expect(io).to receive(:gets).and_return('new_customer')
      expect(io).to receive(:puts).with("\n[+] New order created with id: 7\n\n")
      expect(io).to receive(:print).with("Which item would you like to link this order to?: ")
      expect(io).to receive(:gets).and_return('1')

      application.add_new_order_prompt
      
      expect(order_repository.all.length).to eq (number_of_orders + 1)
      expect(order_repository.all).to include (
        have_attributes(
          id: 7,
          order_date: '2022-10-19',
          customer_name: 'new_customer'
        )
      )
    end
  end
end
