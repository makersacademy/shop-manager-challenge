require 'user_interface.rb'

RSpec.describe UserInterface do
    def reset_all_repos
        seed_sql = File.read('spec/seeds.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'shop' })
        connection.exec(seed_sql)
    end
    before(:each) do 
        reset_all_repos
    end
    it "gives the user a menu" do
        io = double :io
        expect(io).to receive(:puts).with("Welcome to the shop management program!\n")
        expect(io).to receive(:puts).with("\nWhat do you want to do?")
        expect(io).to receive(:puts).with([
            "\t1 = list all shop items",
            "\t2 = create a new item",
            "\t3 = list all orders",
            "\t4 = create new order",
            "\t5 = exit"
        ].join("\n"))
        expect(io).to receive(:puts).with("Input an option [1 - 5]")
        # exit
        expect(io).to receive(:gets).and_return("5")
        # run
        ui = UserInterface.new(io)
        ui.run
    end
    it "creates an item" do
        io = double :io
        expect(io).to receive(:puts).with("Welcome to the shop management program!\n")
        expect(io).to receive(:puts).with("\nWhat do you want to do?")
        expect(io).to receive(:puts).with([
            "\t1 = list all shop items",
            "\t2 = create a new item",
            "\t3 = list all orders",
            "\t4 = create new order",
            "\t5 = exit"
        ].join("\n"))
        expect(io).to receive(:puts).with("Input an option [1 - 5]")
        expect(io).to receive(:gets).and_return("2")
        expect(io).to receive(:puts).with("\nCreate a new item...\n")
        expect(io).to receive(:puts).with("Item name:")
        expect(io).to receive(:gets).and_return("Test item")
        expect(io).to receive(:puts).with("Item unit price:")
        expect(io).to receive(:gets).and_return("45")
        expect(io).to receive(:puts).with("Item quantity:")
        expect(io).to receive(:gets).and_return("15")
        expect(io).to receive(:puts).with("The item has been added. Would you like to see a list of all shop items?")
        expect(io).to receive(:puts).with("[y/n]")
        expect(io).to receive(:gets).and_return("n")
        # exit
        expect(io).to receive(:puts).with("\nWhat do you want to do?")
        expect(io).to receive(:puts).with([
            "\t1 = list all shop items",
            "\t2 = create a new item",
            "\t3 = list all orders",
            "\t4 = create new order",
            "\t5 = exit"
        ].join("\n"))
        expect(io).to receive(:puts).with("Input an option [1 - 5]")
        expect(io).to receive(:gets).and_return("5")
        # run
        ui = UserInterface.new(io)
        ui.run
    end
    it "creates an order" do
        io = double :io
        expect(io).to receive(:puts).with("Welcome to the shop management program!\n")
        expect(io).to receive(:puts).with("\nWhat do you want to do?")
        expect(io).to receive(:puts).with([
            "\t1 = list all shop items",
            "\t2 = create a new item",
            "\t3 = list all orders",
            "\t4 = create new order",
            "\t5 = exit"
        ].join("\n"))
        expect(io).to receive(:puts).with("Input an option [1 - 5]")
        expect(io).to receive(:gets).and_return("4")
        expect(io).to receive(:puts).with("\nCreate a new order...\n")
        expect(io).to receive(:puts).with("Item ID:")
        expect(io).to receive(:gets).and_return("2")
        expect(io).to receive(:puts).with("Customer name:")
        expect(io).to receive(:gets).and_return("Jane Doe")
        expect(io).to receive(:puts).with("The order has been added. Would you like to see a list of all orders?")
        expect(io).to receive(:puts).with("[y/n]")
        expect(io).to receive(:gets).and_return("n")
        # exit
        expect(io).to receive(:puts).with("\nWhat do you want to do?")
        expect(io).to receive(:puts).with([
            "\t1 = list all shop items",
            "\t2 = create a new item",
            "\t3 = list all orders",
            "\t4 = create new order",
            "\t5 = exit"
        ].join("\n"))
        expect(io).to receive(:puts).with("Input an option [1 - 5]")
        expect(io).to receive(:gets).and_return("5")
        # run
        ui = UserInterface.new(io)
        ui.run
    end
end