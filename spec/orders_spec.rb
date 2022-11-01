$LOAD_PATH << "lib"
require 'orders'
require 'stocks'
require 'pg'

RSpec.describe OrdersRepo do
    
    def reset_shop_table
        seed_sql = File.read('spec/reseed.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'shop2' })
        connection.exec(seed_sql)
    end

    before(:each) do 
        reset_shop_table
    end

    it "show_customer_orders works" do
        orderbook = OrdersRepo.new
        expect(orderbook.show_customer_orders.length).to eq 2
    end

    it "show order details works" do
        orderbook = OrdersRepo.new
        expect(orderbook.show_order_details.length).to eq 4
    end

    it "show order details single works" do
        orderbook = OrdersRepo.new
        expect(orderbook.show_order_details_single("Jeff Jeffson").values.length).to eq 2
    end


    it "adds new order works on all tables" do 
        orderbook = OrdersRepo.new
        orderbook.add_new_order('robin', '2022-10-31',2,10)
        expect(orderbook.show_customer_orders.length).to eq 3
        expect(orderbook.show_order_details.length).to eq 5 

    end


end




  

