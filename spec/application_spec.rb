require 'application'

def reset_students_table
    seed_sql = File.read('spec/items_orders_test.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
end

RSpec.describe Application do

    before(:each) do 
        reset_students_table
    end

    describe '#print_item_list' do
        it 'returns a string of item_ids item_name and item_price' do
            io = double(:io)
            app = Application.new('shop_manager_test', ItemRepository.new, OrderRepository.new, io)
            result = app.send(:print_item_list)
            expect(result).to eq "1 - Smart Watch: £250.00\n2 - USB C to USB adapter: £8.99\n3 - Wireless Earbuds: £24.64\n4 - Shower Head and Hose: £16.99"    
    
        end
    end
    describe '#print_order_list' do
        it "For each order: returns string of Order id/name/date followed by that person's orders" do
            io = double(:io)
            app = Application.new('shop_manager_test', ItemRepository.new, OrderRepository.new, io)
            result = app.send(:print_order_list)
            expect(result).to eq "\n1 - Jimothy on date: 2022-05-07\n       Smart Watch\n       USB C to USB adapter\n       Wireless Earbuds\n2 - Nick on date: 2022-04-25\n       Shower Head and Hose\n       Smart Watch"
        end
    end
    describe '#menu_choice_flow' do
        it 'returns error print if input_choice is not an expected entry, quits when quit is entered' do
            io = double(:io)
            expect(io).to receive(:puts).with("\n\n** Error - please input your command carefully ** \n\n")
            expect(io).to receive(:puts).with("\n\nPlease type either 'list items', 'add item', 'list orders' or 'add order'")
            expect(io).to receive(:puts).with("                     Type 'quit' to exit the manager                     ")
            expect(io).to receive(:gets).and_return("quit")
            app = Application.new('shop_manager_test', ItemRepository.new, OrderRepository.new, io)
            choice = 'abcd'
            expect(app.send(:menu_choice_flow, choice)).to eq nil
        end
    end

    describe '#run' do
        it 'Greets manager and initiates user_input_choice, quitting immediately' do
            io = double(:io)
            app = Application.new('shop_manager_test', ItemRepository.new, OrderRepository.new, io)
            expect(io).to receive(:puts).with("Welcome to the Shop Managing Software v17.34 by Nick Incorporated\n\n\n -----Please follow the instructions laid out below to manage your shop-----")
            expect(io).to receive(:puts).with("\n\nPlease type either 'list items', 'add item', 'list orders' or 'add order'")
            expect(io).to receive(:puts).with("                     Type 'quit' to exit the manager                     ")
            expect(io).to receive(:gets).and_return('quit')
            app.run
        end
    end

    describe '#user_input_choice' do
        it 'takes abcd from gets and returns error print if input_choice is not an expected entry, quits when quit is entered' do
            io = double(:io)
            expect(io).to receive(:puts).with("\n\nPlease type either 'list items', 'add item', 'list orders' or 'add order'").ordered
            expect(io).to receive(:puts).with("                     Type 'quit' to exit the manager                     ").ordered
            expect(io).to receive(:gets).and_return('abcd')
            expect(io).to receive(:puts).with("\n\n** Error - please input your command carefully ** \n\n").ordered
            expect(io).to receive(:puts).with("\n\nPlease type either 'list items', 'add item', 'list orders' or 'add order'").ordered
            expect(io).to receive(:puts).with("                     Type 'quit' to exit the manager                     ").ordered
            expect(io).to receive(:gets).and_return("quit")
            app = Application.new('shop_manager_test', ItemRepository.new, OrderRepository.new, io)
            app.send(:user_input_choice)
        end
    end
    describe '#run' do
        it 'Takes input to print list of items' do

            io = double(:io)

            expect(io).to receive(:puts).with("Welcome to the Shop Managing Software v17.34 by Nick Incorporated\n\n\n -----Please follow the instructions laid out below to manage your shop-----")
            expect(io).to receive(:puts).with("\n\nPlease type either 'list items', 'add item', 'list orders' or 'add order'")
            expect(io).to receive(:puts).with("                     Type 'quit' to exit the manager                     ")
            expect(io).to receive(:gets).and_return('list items')
            expect(io).to receive(:puts).with("1 - Smart Watch: £250.00\n2 - USB C to USB adapter: £8.99\n3 - Wireless Earbuds: £24.64\n4 - Shower Head and Hose: £16.99")

            expect(io).to receive(:puts).with("\n\nPlease type either 'list items', 'add item', 'list orders' or 'add order'")
            expect(io).to receive(:puts).with("                     Type 'quit' to exit the manager                     ")
            expect(io).to receive(:gets).and_return("quit")

            app = Application.new('shop_manager_test', ItemRepository.new, OrderRepository.new, io)
            app.run 
        end
        it 'Takes input to create order' do

            io = double(:io)

            expect(io).to receive(:puts).with("Welcome to the Shop Managing Software v17.34 by Nick Incorporated\n\n\n -----Please follow the instructions laid out below to manage your shop-----")
            expect(io).to receive(:puts).with("\n\nPlease type either 'list items', 'add item', 'list orders' or 'add order'")
            expect(io).to receive(:puts).with("                     Type 'quit' to exit the manager                     ")
            expect(io).to receive(:gets).and_return('add order')

            expect(io).to receive(:puts).with("Please type in the customer's name")
            expect(io).to receive(:gets).and_return('Test')
            expect(io).to receive(:puts).with("Please type in the item number of the items the customer wishes to order, separated by a comma ','.")
            expect(io).to receive(:gets).and_return('1')

            expect(io).to receive(:puts).with("\n\nPlease type either 'list items', 'add item', 'list orders' or 'add order'")
            expect(io).to receive(:puts).with("                     Type 'quit' to exit the manager                     ")
            expect(io).to receive(:gets).and_return("quit")

            app = Application.new('shop_manager_test', ItemRepository.new, OrderRepository.new, io)
            order_repo = OrderRepository.new
            app.run
            expect(order_repo.all.last.customer_name).to eq 'Test'
        end
    end
    describe '#create order' do
        it 'creates an order' do
            io = double(:io)
            expect(io).to receive(:puts).with("Please type in the customer's name")
            expect(io).to receive(:gets).and_return('Test')
            expect(io).to receive(:puts).with("Please type in the item number of the items the customer wishes to order, separated by a comma ','.")
            expect(io).to receive(:gets).and_return('1')

            app = Application.new('shop_manager_test', ItemRepository.new, OrderRepository.new, io)
            order_repo = OrderRepository.new
            app.send(:create_order) 
            expect(order_repo.all.last.customer_name).to eq 'Test'
        end
    end

    describe '#create item' do
        it 'adds an item from a gets input into the database' do
            io = double(:io)
            expect(io).to receive(:puts).with("Please type in the item's name\n")
            expect(io).to receive(:gets).and_return('Test item')
            expect(io).to receive(:puts).with("Please type in the cost of the item without a pound sign\n")
            expect(io).to receive(:gets).and_return('56.99')
            expect(io).to receive(:puts).with("Please type in the quantity of the items you have available to sell\n")
            expect(io).to receive(:gets).and_return('4')

            app = Application.new('shop_manager_test', ItemRepository.new, OrderRepository.new, io)
            item_repo = ItemRepository.new
            app.send(:create_item)
            expect(item_repo.all.last.item_name).to eq 'Test item'
        end
    end
end