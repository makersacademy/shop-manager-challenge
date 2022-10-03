require "stocks_repository"

RSpec.describe StocksRepository do 

    def reset_stocks_table
        seed_sql = File.read('spec/shop_seeds.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager' })
        connection.exec(seed_sql)
    end
      
    describe StocksRepository do
        before(:each) do 
          reset_stocks_table
        end
    end 

    it "returns all the stock list" do 

        repo = StocksRepository.new
        stocks = repo.all

        expect(stocks.length).to eq(2)
        expect(stocks[0].id).to eq("1")   
        expect(stocks[0].name).to eq("Super Shark Vacuum Cleaner")  
        expect(stocks[0].price).to eq("99")   
        expect(stocks[0].quantity).to eq("30")
    end

    it "create a new stock entry" do

        repo = StocksRepository.new
        new_stock = Stocks.new

        new_stock.name = "Hello World! Badge"
        new_stock.price = "5"
        new_stock.quantity = "1"
        repo.create(new_stock)
        
        all_stocks = repo.all

        expect(all_stocks). to include(
        have_attributes(
        name: new_stock.name,
        price: new_stock.price,
        quantity: new_stock.quantity,
        )   
        )
    end
end 