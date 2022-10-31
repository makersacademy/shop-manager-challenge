$LOAD_PATH << "lib"
require 'orders'
require 'stocks'
require 'pg'

RSpec.describe StockItemsRepo do
    
    def reset_shop_table
        seed_sql = File.read('spec/reseed.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'shop2' })
        connection.exec(seed_sql)
    end

    before(:each) do 
        reset_shop_table
    end

    it "show_all_stock works" do
        stock_list = StockItemsRepo.new
        expect(stock_list.show_all_stock.length).to eq 2
    end


    it "add_new_item works" do 
        stock_list = StockItemsRepo.new
        stock_list.add_new_item("Gloves", 2000, 19)
        expect(stock_list.show_all_stock.length).to eq 3
    end

    it "view_customers_who_bought works" do 
        stock_list = StockItemsRepo.new
        expect(stock_list.view_customers_who_bought("Dummy item").length).to eq 2
    end


end




  

