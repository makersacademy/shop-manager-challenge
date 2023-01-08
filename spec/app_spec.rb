require './app.rb'

def reset_all_tables
    seed_sql = File.read('spec/seeds_tests.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
end

RSpec.describe Application do
    before(:each) do 
        reset_all_tables
    end

    it 'takes user input and displays list of shop items' do
        fake_item_repository = ItemRepository.new
        fake_order_repository = OrderRepository.new
        fake_item1 = Item.new
        fake_item2 = Item.new
        io = double :io
        fake_item1 = double(:fake_item1, id: 1, name: "Super Shark Vacuum Cleaner", unit_price: 99, quantity: 30)
        fake_item2 = double(:fake_item2, id: 2, name: "Makerspresso Coffee Machine", unit_price: 69, quantity: 15)
        fake_item_repository = double(:fake_item_repository, all: [fake_item1, fake_item2])
        expect(io).to receive(:puts).with("Welcome to the shop management program!")
        expect(io).to receive(:puts).with("")
        expect(io).to receive(:puts).with("What do you want to do?")
        expect(io).to receive(:puts).with("  1 = list all shop items")
        expect(io).to receive(:puts).with("  2 = create a new item")
        expect(io).to receive(:puts).with("  3 = list all orders")
        expect(io).to receive(:puts).with("  4 = create a new order")
        expect(io).to receive(:puts).with("")
        expect(io).to receive(:gets).and_return("1")
        expect(io).to receive(:puts).with("")
        expect(io).to receive(:puts).with("Here's a list of all shop items:")
        expect(io).to receive(:puts).with(" #1 Super Shark Vacuum Cleaner - Unit price: 99 - Quantity: 30")
        expect(io).to receive(:puts).with(" #2 Makerspresso Coffee Machine - Unit price: 69 - Quantity: 15")
        application = Application.new('shop_manager_test', io, fake_item_repository, fake_order_repository)
        application.run
    end

    it 'takes user input and adds new item' do
        fake_item_repository = ItemRepository.new
        fake_order_repository = OrderRepository.new
        fake_item1 = Item.new
        fake_item2 = Item.new
        io = double :io
        fake_item1 = double(:fake_item1, id: 1, name: "Super Shark Vacuum Cleaner", unit_price: 99, quantity: 30)
        fake_item2 = double(:fake_item2, id: 2, name: "Makerspresso Coffee Machine", unit_price: 69, quantity: 15)
        expect(io).to receive(:puts).with("Welcome to the shop management program!")
        expect(io).to receive(:puts).with("")
        expect(io).to receive(:puts).with("What do you want to do?")
        expect(io).to receive(:puts).with("  1 = list all shop items")
        expect(io).to receive(:puts).with("  2 = create a new item")
        expect(io).to receive(:puts).with("  3 = list all orders")
        expect(io).to receive(:puts).with("  4 = create a new order")
        expect(io).to receive(:puts).with("")
        expect(io).to receive(:gets).and_return("2")
        expect(io).to receive(:puts).with("")
        expect(io).to receive(:print).with("What is the item name? ")
        expect(io).to receive(:gets).and_return("Black Rubber Duck")
        expect(io).to receive(:print).with("What is the item unit price? ")
        expect(io).to receive(:gets).and_return("5")
        expect(io).to receive(:print).with("What is the item quantity? ")
        expect(io).to receive(:gets).and_return("150")
        expect(io).to receive(:puts).with("This item has been added:")
        expect(io).to receive(:puts).with(" #3 Black Rubber Duck - Unit price: 5 - Quantity: 150")
        application = Application.new('shop_manager_test', io, fake_item_repository, fake_order_repository)
        application.run
        
        fake_item3 = Item.new
        fake_item1 = double(:fake_item3, id: 3, name: "Black Rubber Duck", unit_price: 5, quantity: 150)
        expect(io).to receive(:puts).with("Welcome to the shop management program!")
        expect(io).to receive(:puts).with("")
        expect(io).to receive(:puts).with("What do you want to do?")
        expect(io).to receive(:puts).with("  1 = list all shop items")
        expect(io).to receive(:puts).with("  2 = create a new item")
        expect(io).to receive(:puts).with("  3 = list all orders")
        expect(io).to receive(:puts).with("  4 = create a new order")
        expect(io).to receive(:puts).with("")
        expect(io).to receive(:gets).and_return("1")
        expect(io).to receive(:puts).with("")
        expect(io).to receive(:puts).with("Here's a list of all shop items:")
        expect(io).to receive(:puts).with(" #1 Super Shark Vacuum Cleaner - Unit price: 99 - Quantity: 30")
        expect(io).to receive(:puts).with(" #2 Makerspresso Coffee Machine - Unit price: 69 - Quantity: 15")
        expect(io).to receive(:puts).with(" #3 Black Rubber Duck - Unit price: 5 - Quantity: 150")
        application = Application.new('shop_manager_test', io, fake_item_repository, fake_order_repository)
        application.run
    end

    it 'takes user input and displays list of shop orders' do
        fake_item_repository = ItemRepository.new
        fake_order_repository = OrderRepository.new
        fake_order1 = Order.new
        fake_order2 = Order.new
        io = double :io
        fake_order1 = double(:fake_order1, id: 1, customer_name: "Mantas Volkauskas", order_date: '7 Jan 2023', item_id: 2)
        fake_order2 = double(:fake_order2, id: 2, customer_name: "Bob Boberto", order_date: '25 Dec 2022', item_id: 2)
        fake_order_repository = double(:fake_order_repository, all: [fake_order1, fake_order2])
        expect(io).to receive(:puts).with("Welcome to the shop management program!")
        expect(io).to receive(:puts).with("")
        expect(io).to receive(:puts).with("What do you want to do?")
        expect(io).to receive(:puts).with("  1 = list all shop items")
        expect(io).to receive(:puts).with("  2 = create a new item")
        expect(io).to receive(:puts).with("  3 = list all orders")
        expect(io).to receive(:puts).with("  4 = create a new order")
        expect(io).to receive(:puts).with("")
        expect(io).to receive(:gets).and_return("3")
        expect(io).to receive(:puts).with("")
        expect(io).to receive(:puts).with("Here's a list of all shop orders:")
        expect(io).to receive(:puts).with(" #1 Mantas Volkauskas - Order date: 7 Jan 2023 - Item ID: 2")
        expect(io).to receive(:puts).with(" #2 Bob Boberto - Order date: 25 Dec 2022 - Item ID: 2")
        application = Application.new('shop_manager_test', io, fake_order_repository, fake_order_repository)
        application.run
    end

    it 'takes user input and adds new order' do
        fake_item_repository = ItemRepository.new
        fake_order_repository = OrderRepository.new
        fake_order1 = Order.new
        fake_order2 = Order.new
        io = double :io
        fake_order1 = double(:fake_order1, id: 1, customer_name: "Mantas Volkauskas", order_date: '7 Jan 2023', item_id: 2)
        fake_order2 = double(:fake_order2, id: 2, customer_name: "Bob Boberto", order_date: '25 Dec 2022', item_id: 2)
        
        expect(io).to receive(:puts).with("Welcome to the shop management program!")
        expect(io).to receive(:puts).with("")
        expect(io).to receive(:puts).with("What do you want to do?")
        expect(io).to receive(:puts).with("  1 = list all shop items")
        expect(io).to receive(:puts).with("  2 = create a new item")
        expect(io).to receive(:puts).with("  3 = list all orders")
        expect(io).to receive(:puts).with("  4 = create a new order")
        expect(io).to receive(:puts).with("")
        expect(io).to receive(:gets).and_return("4")
        expect(io).to receive(:puts).with("")
        expect(io).to receive(:print).with("What is the order customer name? ")
        expect(io).to receive(:gets).and_return("Bugs Bunny")
        expect(io).to receive(:print).with("What is the order date? ")
        expect(io).to receive(:gets).and_return("8 Jan 2023")
        expect(io).to receive(:print).with("What is the order item ID? ")
        expect(io).to receive(:gets).and_return("1")
        expect(io).to receive(:puts).with("This order has been added:")
        expect(io).to receive(:puts).with(" #3 Bugs Bunny - Order date: 8 Jan 2023 - Item ID: 1")
        application = Application.new('shop_manager_test', io, fake_item_repository, fake_order_repository)
        application.run

        fake_item3 = Item.new
        fake_order2 = double(:fake_order2, id: 3, customer_name: "Bugs Bunny", order_date: '8 Jan 2023', item_id: 1)
        expect(io).to receive(:puts).with("Welcome to the shop management program!")
        expect(io).to receive(:puts).with("")
        expect(io).to receive(:puts).with("What do you want to do?")
        expect(io).to receive(:puts).with("  1 = list all shop items")
        expect(io).to receive(:puts).with("  2 = create a new item")
        expect(io).to receive(:puts).with("  3 = list all orders")
        expect(io).to receive(:puts).with("  4 = create a new order")
        expect(io).to receive(:puts).with("")
        expect(io).to receive(:gets).and_return("3")
        expect(io).to receive(:puts).with("")
        expect(io).to receive(:puts).with("Here's a list of all shop orders:")
        expect(io).to receive(:puts).with(" #1 Mantas Volkauskas - Order date: 7 Jan 2023 - Item ID: 2")
        expect(io).to receive(:puts).with(" #2 Bob Boberto - Order date: 25 Dec 2022 - Item ID: 2")
        expect(io).to receive(:puts).with(" #3 Bugs Bunny - Order date: 8 Jan 2023 - Item ID: 1")
        application = Application.new('shop_manager_test', io, fake_order_repository, fake_order_repository)
        application.run
    end
end    