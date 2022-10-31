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
    


    it "INTEGRATION app test 1" do
        kernaldouble = double :kernaldouble
        orderbook = OrdersRepo.new
        stocks = StockItemsRepo.new

        app1 = Application.new('shop2', kernaldouble, orderbook, stocks)

        expect(kernaldouble).to receive(:puts).with("Welcome to the shop management program!"\
            "\nWhat do you want to do?"\
            "\n   1 = list all shop items"\
            "\n   2 = create a new item"\
            "\n   3 = list all orders"\
            "\n   4 = create a new order"\
            "\n   5 = find a customer's order"\
            "\n   6 = view customers of a product"\
            "\n   7 = exit program")
        expect(kernaldouble).to receive(:gets).and_return("7")
            ###DO I NEED TO END EVERY TEST WITH INPUT 7??? Find this out.
        app1.run
        expect(orderbook.show_customer_orders.length).to eq 2

    end


end