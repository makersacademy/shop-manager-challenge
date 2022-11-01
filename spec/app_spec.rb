$LOAD_PATH << "lib"
require 'orders'
require 'stocks'
require_relative '../app'
require 'database_connection'


RSpec.describe OrdersRepo do
    
    def reset_shop_table
        seed_sql = File.read('spec/reseed.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'shop2' })
        connection.exec(seed_sql)
    end

    before(:each) do 
        reset_shop_table
    end
    


    it "UNIT StocksRepo class app test 1" do
        kernaldouble = double :kernaldouble
        orderbook = double :ordersrepo
        stocks = StockItemsRepo.new
        app1 = Application.new('shop2', kernaldouble, orderbook, stocks)

        expect(kernaldouble).to receive(:puts).with("Welcome to the shop management program!"\
            "\nWhat do you want to do?"\
            "\n   1 = list all shop items"\
            "\n   2 = create a new item"\
            "\n   3 = delete an item"\
            "\n   4 = list all orders"\
            "\n   5 = create a new order"\
            "\n   6 = find a customer's order"\
            "\n   7 = view customers of a product"\
            "\n   8 = exit program")
        expect(kernaldouble).to receive(:gets).and_return("8")
        expect(kernaldouble).to receive(:print).with("Goodbye!!!!!")  

        app1.run
        expect(stocks.show_all_stock.length).to eq 2
    end

    it "INTEGRATION app test 2 all stock item table stuff" do
        kernaldouble = double :kernaldouble
        orderbook = OrdersRepo.new
        stocks = StockItemsRepo.new
        app1 = Application.new('shop2', kernaldouble, orderbook, stocks)

        expect(kernaldouble).to receive(:puts).with("Welcome to the shop management program!"\
            "\nWhat do you want to do?"\
            "\n   1 = list all shop items"\
            "\n   2 = create a new item"\
            "\n   3 = delete an item"\
            "\n   4 = list all orders"\
            "\n   5 = create a new order"\
            "\n   6 = find a customer's order"\
            "\n   7 = view customers of a product"\
            "\n   8 = exit program")
        expect(kernaldouble).to receive(:gets).and_return("3") 
        expect(kernaldouble).to receive(:puts).with("enter the id of the item to delete")
        expect(kernaldouble).to receive(:gets).and_return("1")
        expect(kernaldouble).to receive(:puts).with("item successfully deleted")
        expect(kernaldouble).to receive(:puts).with("Welcome to the shop management program!"\
            "\nWhat do you want to do?"\
            "\n   1 = list all shop items"\
            "\n   2 = create a new item"\
            "\n   3 = delete an item"\
            "\n   4 = list all orders"\
            "\n   5 = create a new order"\
            "\n   6 = find a customer's order"\
            "\n   7 = view customers of a product"\
            "\n   8 = exit program")
        expect(kernaldouble).to receive(:gets).and_return("2")
        expect(kernaldouble).to receive(:puts).with("enter your addition in format item-price-qty")
        expect(kernaldouble).to receive(:gets).and_return("gloves-100-100")
        expect(kernaldouble).to receive(:puts).with("gloves successfully added to catalogue")
        expect(kernaldouble).to receive(:puts).with("Welcome to the shop management program!"\
            "\nWhat do you want to do?"\
            "\n   1 = list all shop items"\
            "\n   2 = create a new item"\
            "\n   3 = delete an item"\
            "\n   4 = list all orders"\
            "\n   5 = create a new order"\
            "\n   6 = find a customer's order"\
            "\n   7 = view customers of a product"\
            "\n   8 = exit program")
        expect(kernaldouble).to receive(:gets).and_return("8")
        expect(kernaldouble).to receive(:print).with("Goodbye!!!!!")  
          
        app1.run
        expect(stocks.show_all_stock.length).to eq 2
        expect(stocks.show_all_stock[1][0]).to eq ("gloves")
    end


    it "INTEGRATION app test 3 all customer_order or orders table stuff" do
        kernaldouble = double :kernaldouble
        orderbook = OrdersRepo.new
        stocks = StockItemsRepo.new
        app1 = Application.new('shop2', kernaldouble, orderbook, stocks)

        expect(kernaldouble).to receive(:puts).with("Welcome to the shop management program!"\
            "\nWhat do you want to do?"\
            "\n   1 = list all shop items"\
            "\n   2 = create a new item"\
            "\n   3 = delete an item"\
            "\n   4 = list all orders"\
            "\n   5 = create a new order"\
            "\n   6 = find a customer's order"\
            "\n   7 = view customers of a product"\
            "\n   8 = exit program")
        expect(kernaldouble).to receive(:gets).and_return("5") 
        expect(kernaldouble).to receive(:puts).with("enter your addition in format name:date:itemid:qty")
        expect(kernaldouble).to receive(:gets).and_return("Robin:2022-10-10:1:7")
        expect(kernaldouble).to receive(:puts).with("Robin successfully added to orders")
        expect(kernaldouble).to receive(:puts).with("Welcome to the shop management program!"\
            "\nWhat do you want to do?"\
            "\n   1 = list all shop items"\
            "\n   2 = create a new item"\
            "\n   3 = delete an item"\
            "\n   4 = list all orders"\
            "\n   5 = create a new order"\
            "\n   6 = find a customer's order"\
            "\n   7 = view customers of a product"\
            "\n   8 = exit program")
        expect(kernaldouble).to receive(:gets).and_return("6")
        expect(kernaldouble).to receive(:puts).with("enter customer name")
        expect(kernaldouble).to receive(:gets).and_return("Robin")
        expect(kernaldouble).to receive(:puts).with("Robin ordered 7x of Dummy item on 2022-10-10")
        expect(kernaldouble).to receive(:puts).with("Welcome to the shop management program!"\
            "\nWhat do you want to do?"\
            "\n   1 = list all shop items"\
            "\n   2 = create a new item"\
            "\n   3 = delete an item"\
            "\n   4 = list all orders"\
            "\n   5 = create a new order"\
            "\n   6 = find a customer's order"\
            "\n   7 = view customers of a product"\
            "\n   8 = exit program")
        expect(kernaldouble).to receive(:gets).and_return("7")
        expect(kernaldouble).to receive(:puts).with("enter item name") 
        expect(kernaldouble).to receive(:gets).and_return("Extra dummy item")
        expect(kernaldouble).to receive(:puts).with("Extra dummy item bought by:")
        expect(kernaldouble).to receive(:puts).with("Jeff Jeffson on 1900-01-01")
        expect(kernaldouble).to receive(:puts).with("Jeffs Brother on 2021-04-20")
        expect(kernaldouble).to receive(:puts).with("Welcome to the shop management program!"\
            "\nWhat do you want to do?"\
            "\n   1 = list all shop items"\
            "\n   2 = create a new item"\
            "\n   3 = delete an item"\
            "\n   4 = list all orders"\
            "\n   5 = create a new order"\
            "\n   6 = find a customer's order"\
            "\n   7 = view customers of a product"\
            "\n   8 = exit program")
        expect(kernaldouble).to receive(:gets).and_return("8")
        expect(kernaldouble).to receive(:print).with("Goodbye!!!!!")  
          
        app1.run
        expect(stocks.show_all_stock.length).to eq 2
    end



    it "INTEGRATION app test 4 viewing stuff options 1 and 4" do
        kernaldouble = double :kernaldouble
        orderbook = OrdersRepo.new
        stocks = StockItemsRepo.new
        app1 = Application.new('shop2', kernaldouble, orderbook, stocks)

        expect(kernaldouble).to receive(:puts).with("Welcome to the shop management program!"\
            "\nWhat do you want to do?"\
            "\n   1 = list all shop items"\
            "\n   2 = create a new item"\
            "\n   3 = delete an item"\
            "\n   4 = list all orders"\
            "\n   5 = create a new order"\
            "\n   6 = find a customer's order"\
            "\n   7 = view customers of a product"\
            "\n   8 = exit program")
        expect(kernaldouble).to receive(:gets).and_return("1")
        expect(kernaldouble).to receive(:p).with([["Dummy item", "45", "20"], ["Extra dummy item", "22", "80"]])
        expect(kernaldouble).to receive(:puts).with("Welcome to the shop management program!"\
            "\nWhat do you want to do?"\
            "\n   1 = list all shop items"\
            "\n   2 = create a new item"\
            "\n   3 = delete an item"\
            "\n   4 = list all orders"\
            "\n   5 = create a new order"\
            "\n   6 = find a customer's order"\
            "\n   7 = view customers of a product"\
            "\n   8 = exit program")
        expect(kernaldouble).to receive(:gets).and_return("4")
        expect(kernaldouble).to receive(:p).with([["101", "Jeffs Brother", "2021-04-20"], ["100", "Jeff Jeffson", "1900-01-01"]])
        expect(kernaldouble).to receive(:puts).with("Welcome to the shop management program!"\
            "\nWhat do you want to do?"\
            "\n   1 = list all shop items"\
            "\n   2 = create a new item"\
            "\n   3 = delete an item"\
            "\n   4 = list all orders"\
            "\n   5 = create a new order"\
            "\n   6 = find a customer's order"\
            "\n   7 = view customers of a product"\
            "\n   8 = exit program")
        expect(kernaldouble).to receive(:gets).and_return("8")
        expect(kernaldouble).to receive(:print).with("Goodbye!!!!!")  

        app1.run
        expect(stocks.show_all_stock.length).to eq 2

    end
end