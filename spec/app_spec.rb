require_relative '../app'

RSpec.describe App do
    def reset_data
        seed_sql = File.read('spec/seeds_shop_manager.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
        connection.exec(seed_sql)
    end

    before(:each) do
        reset_data
    end
    context "When app main display recieves the user input for option 1" do
      it "puts all items to the terminal" do
        io = double :io
        expect(io).to receive(:puts).with("Shop Manager................")  
        expect(io).to receive(:puts).with("    [1]  view all items ")     
        expect(io).to receive(:puts).with("    [2]  view all orders")
        expect(io).to receive(:puts).with("    [3]  add new item")
        expect(io).to receive(:puts).with("    [4]  add new order")
        expect(io).to receive(:puts).with("    [5]  update item name")  
        expect(io).to receive(:puts).with("    [6]  update item price")
        expect(io).to receive(:puts).with("    [7]  update item quantity")   

        expect(io).to receive(:puts).with(".............................")   
        expect(io).to receive(:puts).with(" Select an option[ ]")
        expect(io).to receive(:gets).and_return('1')

        expect(io).to receive(:puts).with("id: 1, name: paint set, unit price: 16, qty: 8")
        expect(io).to receive(:puts).with("id: 2, name: brush set, unit price: 8, qty: 24")
        expect(io).to receive(:puts).with("id: 3, name: pencil set, unit price: 5, qty: 17")
        expect(io).to receive(:puts).with("id: 4, name: small canvas, unit price: 7, qty: 5")
        expect(io).to receive(:puts).with("id: 5, name: large canvas, unit price: 12, qty: 3")


        item_repository = ItemRepository.new
        order_repository = OrderRepository.new
        
            
        app = App.new('shop_manager_test', io, item_repository, order_repository)
        app.display_menu 
        
        end
    end
    context "When app main display recieves the user input for option 2" do
        it "puts all orders to the terminal" do
            item_repository = ItemRepository.new
            order_repository = OrderRepository.new
            io = double :io
            
            expect(io).to receive(:puts).with("Shop Manager................")  
            expect(io).to receive(:puts).with("    [1]  view all items ")     
            expect(io).to receive(:puts).with("    [2]  view all orders")
            expect(io).to receive(:puts).with("    [3]  add new item")
            expect(io).to receive(:puts).with("    [4]  add new order")
            expect(io).to receive(:puts).with("    [5]  update item name")  
            expect(io).to receive(:puts).with("    [6]  update item price")
            expect(io).to receive(:puts).with("    [7]  update item quantity")   
    
            expect(io).to receive(:puts).with(".............................")   
            expect(io).to receive(:puts).with(" Select an option[ ]")
            expect(io).to receive(:gets).and_return('2')

            expect(io).to receive(:puts).with("id: 1, name: Joe Bloggs, order date: 2022-12-31, item_id: 1")
            expect(io).to receive(:puts).with("id: 2, name: John Smith, order date: 2023-01-01, item_id: 2")
            expect(io).to receive(:puts).with("id: 3, name: Eva Jones, order date: 2023-01-04, item_id: 3")
            expect(io).to receive(:puts).with("id: 4, name: Mary Cole, order date: 2023-01-05, item_id: 4")
        

            app = App.new('shop_manager_test', io, item_repository, order_repository)
            app.display_menu
           
        end
    end
    context "When app main display recieves the user input for option 3" do
        it "takes user input to add an item" do
            item_repository = ItemRepository.new
            order_repository = OrderRepository.new
            io = double :io
            
            expect(io).to receive(:puts).with("Shop Manager................")  
            expect(io).to receive(:puts).with("    [1]  view all items ")     
            expect(io).to receive(:puts).with("    [2]  view all orders")
            expect(io).to receive(:puts).with("    [3]  add new item")
            expect(io).to receive(:puts).with("    [4]  add new order")
            expect(io).to receive(:puts).with("    [5]  update item name")  
            expect(io).to receive(:puts).with("    [6]  update item price")
            expect(io).to receive(:puts).with("    [7]  update item quantity")   
    
            expect(io).to receive(:puts).with(".............................")   
            expect(io).to receive(:puts).with(" Select an option[ ]")
            expect(io).to receive(:gets).and_return('3')

            expect(io).to receive(:puts).with("Enter item name: ")
            expect(io).to receive(:gets).and_return('easel')
            expect(io).to receive(:puts).with("Enter item price: ")
            expect(io).to receive(:gets).and_return('50')
            expect(io).to receive(:puts).with("Enter item quantity: ")
            expect(io).to receive(:gets).and_return('6')

            app = App.new('shop_manager_test', io, item_repository, order_repository)
            app.display_menu
        end
    end
    context "When app main display recieves the user input for option 4" do
        it "takes user input to add an order" do
            item_repository = ItemRepository.new
            order_repository = OrderRepository.new
            io = double :io
            
            expect(io).to receive(:puts).with("Shop Manager................")  
            expect(io).to receive(:puts).with("    [1]  view all items ")     
            expect(io).to receive(:puts).with("    [2]  view all orders")
            expect(io).to receive(:puts).with("    [3]  add new item")
            expect(io).to receive(:puts).with("    [4]  add new order")
            expect(io).to receive(:puts).with("    [5]  update item name")  
            expect(io).to receive(:puts).with("    [6]  update item price")
            expect(io).to receive(:puts).with("    [7]  update item quantity")   
    
            expect(io).to receive(:puts).with(".............................")   
            expect(io).to receive(:puts).with(" Select an option[ ]")
            expect(io).to receive(:gets).and_return('4')

            expect(io).to receive(:puts).with("Enter customer name: ")
            expect(io).to receive(:gets).and_return('Mark White')
            expect(io).to receive(:puts).with("Enter order date: ")
            expect(io).to receive(:gets).and_return('2023-07-01')
            expect(io).to receive(:puts).with("Enter item_id: ")
            expect(io).to receive(:gets).and_return('3')

            app = App.new('shop_manager_test', io, item_repository, order_repository)
            app.display_menu
            
        end
    end
    context "When app main display recieves the user input for option 5" do
        it "takes user input to update an item" do
            item_repository = ItemRepository.new
            order_repository = OrderRepository.new
            io = double :io
            
            expect(io).to receive(:puts).with("Shop Manager................")  
            expect(io).to receive(:puts).with("    [1]  view all items ")     
            expect(io).to receive(:puts).with("    [2]  view all orders")
            expect(io).to receive(:puts).with("    [3]  add new item")
            expect(io).to receive(:puts).with("    [4]  add new order")
            expect(io).to receive(:puts).with("    [5]  update item name")  
            expect(io).to receive(:puts).with("    [6]  update item price")
            expect(io).to receive(:puts).with("    [7]  update item quantity")   
    
            expect(io).to receive(:puts).with(".............................")   
            expect(io).to receive(:puts).with(" Select an option[ ]")
            expect(io).to receive(:gets).and_return('5')

            expect(io).to receive(:puts).with("Enter item id: ")
            expect(io).to receive(:gets).and_return('1')

            expect(io).to receive(:puts).with("Enter new item name: ")
            expect(io).to receive(:gets).and_return('chalk')
            expect(io).to receive(:puts).with("Item updated")


            app = App.new('shop_manager_test', io, item_repository, order_repository)
            app.display_menu
        end
    end
    context "When app main display recieves the user input for option 6" do
        it "takes user input to update an item" do
            item_repository = ItemRepository.new
            order_repository = OrderRepository.new
            io = double :io
            
            expect(io).to receive(:puts).with("Shop Manager................")  
            expect(io).to receive(:puts).with("    [1]  view all items ")     
            expect(io).to receive(:puts).with("    [2]  view all orders")
            expect(io).to receive(:puts).with("    [3]  add new item")
            expect(io).to receive(:puts).with("    [4]  add new order")
            expect(io).to receive(:puts).with("    [5]  update item name")  
            expect(io).to receive(:puts).with("    [6]  update item price")
            expect(io).to receive(:puts).with("    [7]  update item quantity")   
    
            expect(io).to receive(:puts).with(".............................")   
            expect(io).to receive(:puts).with(" Select an option[ ]")
            expect(io).to receive(:gets).and_return('6')

            expect(io).to receive(:puts).with("Enter item id: ")
            expect(io).to receive(:gets).and_return('1')

            expect(io).to receive(:puts).with("Enter new item price: ")
            expect(io).to receive(:gets).and_return('11')
            expect(io).to receive(:puts).with("Item updated")

            app = App.new('shop_manager_test', io, item_repository, order_repository)
            app.display_menu
            
        end
    end
    context "When app main display recieves the user input for option 7" do
        it "takes user input to update an item" do
            item_repository = ItemRepository.new
            order_repository = OrderRepository.new
            io = double :io
            
            expect(io).to receive(:puts).with("Shop Manager................")  
            expect(io).to receive(:puts).with("    [1]  view all items ")     
            expect(io).to receive(:puts).with("    [2]  view all orders")
            expect(io).to receive(:puts).with("    [3]  add new item")
            expect(io).to receive(:puts).with("    [4]  add new order")
            expect(io).to receive(:puts).with("    [5]  update item name")  
            expect(io).to receive(:puts).with("    [6]  update item price")
            expect(io).to receive(:puts).with("    [7]  update item quantity")   
    
            expect(io).to receive(:puts).with(".............................")   
            expect(io).to receive(:puts).with(" Select an option[ ]")
            expect(io).to receive(:gets).and_return('7')

            expect(io).to receive(:puts).with("Enter item id: ")
            expect(io).to receive(:gets).and_return('3')
            expect(io).to receive(:puts).with("Enter new item quantity: ")
            expect(io).to receive(:gets).and_return('30')
            expect(io).to receive(:puts).with("Item updated")

            app = App.new('shop_manager_test', io, item_repository, order_repository)
            app.display_menu
        end
    end
  
 
   
  

end
