require_relative '../app'

def reset_tables
    seed_sql = File.read('spec/seeds_tables.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
end

RSpec.describe Application do
    before(:each) do 
        reset_tables
    end

    it "allows the user to get a list of items" do
        #test some stuff
        io = double(:io)
        app = Application.new(
            'shop_manager_test',
            io,
            ItemRepository.new,
            OrderRepository.new
          )
        expect(io).to receive(:system).with("clear")
        expect(io).to receive(:puts).with("Welcome to the shop management program!")
        expect(io).to receive(:puts).with(" ")
        expect(io).to receive(:puts).with("What would you like to do?")
        expect(io).to receive(:puts).with("1 - List all shop items")
        expect(io).to receive(:puts).with("2 - Create a new item")
        expect(io).to receive(:puts).with("3 - List all orders")
        expect(io).to receive(:puts).with("4 - Create a new order")
        expect(io).to receive(:puts).with(" ")
        expect(io).to receive(:puts).with("Enter your choice: ")
        expect(io).to receive(:gets).and_return("1\n")
        expect(io).to receive(:puts).with("[ENTER]")
        expect(io).to receive(:puts).with(" ")
        expect(io).to receive(:puts).with("Here is the list of all shop items:")
        expect(io).to receive(:puts).with([
            "* 1 - Tartan Paint - £6.75 - 30 in stock",
            "Ordered by Mavis",
            "* 2 - Hens Teeth - £15.45 - 3 in stock",
            "Ordered by Julie and Mavis",
            "* 3 - Rocking Horse Droppings - £45.95 - 1 in stock",
            "Ordered by Bob, Julie and Mavis",
            "* 4 - Fairy Dust - £200.85 - 0 in stock",
            "This has not been ordered by anyone",
        ].join("\n"))
        app.run
    end

    it "allows the user to get a list of orders" do
        #test some stuff
        io = double(:io)
        app = Application.new(
            'shop_manager_test',
            io,
            ItemRepository.new,
            OrderRepository.new
          )
        expect(io).to receive(:system).with("clear")
        expect(io).to receive(:puts).with("Welcome to the shop management program!")
        expect(io).to receive(:puts).with(" ")
        expect(io).to receive(:puts).with("What would you like to do?")
        expect(io).to receive(:puts).with("1 - List all shop items")
        expect(io).to receive(:puts).with("2 - Create a new item")
        expect(io).to receive(:puts).with("3 - List all orders")
        expect(io).to receive(:puts).with("4 - Create a new order")
        expect(io).to receive(:puts).with(" ")
        expect(io).to receive(:puts).with("Enter your choice: ")
        expect(io).to receive(:gets).and_return("3\n")
        expect(io).to receive(:puts).with("[ENTER]")
        expect(io).to receive(:puts).with(" ")
        expect(io).to receive(:puts).with("Here is the list of the shops orders:")
        expect(io).to receive(:puts).with([
            "* 1 - Ordered by Bob on 2022-10-20",
            "Items:",
            "   Rocking Horse Droppings - £45.95",
            "       Total due: £45.95",
            " ",
            "* 2 - Ordered by Julie on 2022-05-07",
            "Items:",
            "   Hens Teeth - £15.45",
            "   Rocking Horse Droppings - £45.95",
            "       Total due: £61.40",
            " ",
            "* 3 - Ordered by Mavis on 2021-08-10",
            "Items:",
            "   Tartan Paint - £6.75",
            "   Hens Teeth - £15.45",
            "   Rocking Horse Droppings - £45.95",
            "       Total due: £68.15",
        ].join("\n"))
        app.run
    end

    it "allows the user to create an item" do
        #test some stuff
        io = double(:io)
        i_repo = ItemRepository.new
        app = Application.new(
            'shop_manager_test',
            io,
            i_repo,
            OrderRepository.new
          )
        expect(io).to receive(:system).with("clear")
        expect(io).to receive(:puts).with("Welcome to the shop management program!")
        expect(io).to receive(:puts).with(" ")
        expect(io).to receive(:puts).with("What would you like to do?")
        expect(io).to receive(:puts).with("1 - List all shop items")
        expect(io).to receive(:puts).with("2 - Create a new item")
        expect(io).to receive(:puts).with("3 - List all orders")
        expect(io).to receive(:puts).with("4 - Create a new order")
        expect(io).to receive(:puts).with(" ")
        expect(io).to receive(:puts).with("Enter your choice: ")
        expect(io).to receive(:gets).and_return("2\n")
        expect(io).to receive(:puts).with("[ENTER]")
        expect(io).to receive(:puts).with(" ")
        expect(io).to receive(:puts).with("Creating an item:")
        expect(io).to receive(:puts).with("Enter the items name: ")
        expect(io).to receive(:gets).and_return("Unicorn Horn\n")
        expect(io).to receive(:puts).with("Enter the items price: ")
        expect(io).to receive(:gets).and_return("300.65\n")
        expect(io).to receive(:puts).with("Enter the number of items in stock: ")
        expect(io).to receive(:gets).and_return("1\n")
        expect(io).to receive(:puts).with(" ")
        expect(io).to receive(:puts).with("Item created")
        app.run
        items = i_repo.all.last
        expect(items.id).to eq '5'
        expect(items.name).to eq "Unicorn Horn"
        expect(items.price).to eq '300.65'
        expect(items.quantity).to eq '1'
        expect(items.orders).to eq []
    end

    it "allows the user to create an order" do
        #test some stuff
        io = double(:io)
        o_repo = OrderRepository.new
        app = Application.new(
            'shop_manager_test',
            io,
            ItemRepository.new,
            o_repo,
            
          )
        expect(io).to receive(:system).with("clear")
        expect(io).to receive(:puts).with("Welcome to the shop management program!")
        expect(io).to receive(:puts).with(" ")
        expect(io).to receive(:puts).with("What would you like to do?")
        expect(io).to receive(:puts).with("1 - List all shop items")
        expect(io).to receive(:puts).with("2 - Create a new item")
        expect(io).to receive(:puts).with("3 - List all orders")
        expect(io).to receive(:puts).with("4 - Create a new order")
        expect(io).to receive(:puts).with(" ")
        expect(io).to receive(:puts).with("Enter your choice: ")
        expect(io).to receive(:gets).and_return("4\n")
        expect(io).to receive(:puts).with("[ENTER]")
        expect(io).to receive(:puts).with(" ")
        expect(io).to receive(:puts).with("Creating an order:")
        expect(io).to receive(:puts).with("Enter your name: ")
        expect(io).to receive(:gets).and_return("Ian\n")
        expect(io).to receive(:puts).with("Enter the date: ")
        expect(io).to receive(:gets).and_return("2022-10-21\n")
        expect(io).to receive(:puts).with("Enter the item number: ")
        expect(io).to receive(:gets).and_return("1\n")
        expect(io).to receive(:puts).with("Enter the item number: ")
        expect(io).to receive(:gets).and_return("4\n")
        expect(io).to receive(:puts).with("Enter the item number: ")
        expect(io).to receive(:gets).and_return("3\n")
        expect(io).to receive(:puts).with("Enter the item number: ")
        expect(io).to receive(:gets).and_return("\n")
        expect(io).to receive(:puts).with(" ")
        expect(io).to receive(:puts).with("Order created")
        app.run
        order = o_repo.all.last
        expect(order.id).to eq '4'
        expect(order.customer_name).to eq "Ian"
        expect(order.date).to eq '2022-10-21'
        expect(order.items).to eq ['1', '4', '3']
    end
end
