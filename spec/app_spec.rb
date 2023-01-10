require './app.rb'
 require_relative '../lib/order_repository'
 require_relative '../lib/item_repository'


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

     it "lists all shop items" do 
         io = double :io
         item_repository = ItemRepository.new
         order_repository = OrderRepository.new

         expect(io).to receive(:puts).with("Welcome to the shop management program!").ordered
         expect(io).to receive(:puts).with("What would you like to do?").ordered
         expect(io).to receive(:puts).with("1 = List all shop items").ordered
         expect(io).to receive(:puts).with("2 = Create a new item").ordered
         expect(io).to receive(:puts).with("3 = List all orders").ordered
         expect(io).to receive(:puts).with("4 = Create a new order").ordered
        

         expect(io).to receive(:gets).and_return("1").ordered
         expect(io).to receive(:puts).with("Here is the list of all shop items:")
         expect(io).to receive(:puts).with("1 chocolate - unit price: 7 - quantity: 3")
         expect(io).to receive(:puts).with("2 coffee - Unit price: 5 - Quantity: 1")
          

         app = Application.new('shop_manager_test', io, item_repository, order_repository)
         app.run
     end

     it "creates a new item" do
         io = double :io
         item_repository = ItemRepository.new
         order_repository = OrderRepository.new

         expect(io).to receive(:puts).with("Welcome to the shop management program!").ordered
         expect(io).to receive(:puts).with("What would you like to do?").ordered
         expect(io).to receive(:puts).with("1 = List all shop items").ordered
         expect(io).to receive(:puts).with("2 = Create a new item").ordered
         expect(io).to receive(:puts).with("3 = List all orders").ordered
         expect(io).to receive(:puts).with("4 = Create a new order").ordered
        

         expect(io).to receive(:gets).and_return("2").ordered
         expect(io).to receive(:puts).with("What item would you like to add?").ordered
         expect(io).to receive(:gets).and_return("tea").ordered
         expect(io).to receive(:puts).with("What is the unit price of this item?").ordered
         expect(io).to receive(:gets).and_return("5").ordered
         expect(io).to receive(:puts).with("What are the stock levels for this item?").ordered
         expect(io).to receive(:gets).and_return("1").ordered

         app = Application.new('shop_manager_test', io, item_repository, order_repository)
         app.run

         expect(item_repository.all).to include(
             have_attributes(
                 name: "tea",
                 unit_price: 5,
                 quantity: 1
             )
         )  
     end

     it "lists all shop items" do 
         io = double :io
         item_repository = ItemRepository.new
         order_repository = OrderRepository.new


         expect(io).to receive(:puts).with("Welcome to the shop management program!").ordered
         expect(io).to receive(:puts).with("What would you like to do?").ordered
         expect(io).to receive(:puts).with("1 = List all shop items").ordered
         expect(io).to receive(:puts).with("2 = Create a new item").ordered
         expect(io).to receive(:puts).with("3 = List all orders").ordered
         expect(io).to receive(:puts).with("4 = Create a new order").ordered
        

         expect(io).to receive(:gets).and_return("3").ordered
         expect(io).to receive(:puts).with("Here is the list of all orders:").ordered

         expect(io).to receive(:puts).with("1 Maya - Order date: 2004-11-03 15:40:12 - Item ID: 2").ordered
         expect(io).to receive(:puts).with("2 Anna - Order date: 2004-10-19 10:23:54 - Item ID: 1").ordered
        

         app = Application.new('shop_manager_test', io, item_repository, order_repository)
         app.run

    

    
     end
 end
