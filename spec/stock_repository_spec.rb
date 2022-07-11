require 'stock_repository'

RSpec.describe StockRepository do 
    def reset_stocks_table
        seed_sql = File.read('spec/seeds.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager' })
        connection.exec(seed_sql)
    end
      
    before(:each) do 
        reset_stocks_table
    end

    it "returns all stocks" do
        repo = StockRepository.new
        stocks = repo.all
        expect(stocks.length).to eq 3

    end 
    it "returns a single stock" do 
        repo = StockRepository.new
        stock = repo.find(1)

        expect(stock.id).to eq "1" 
        expect(stock.name).to eq "Item1"
        expect(stock.price).to eq "1"

    end 

    it "creates new stock and returns nil" do 
        repo = StockRepository.new
        stock = Stock.new
        stock.id = "5"
        stock.name = 'E'
        stock.price = "5"
        stock.quantity = "10"
        
        repo.create(stock)

        stocks = repo.all
        expect(stocks).to include(
            have_attributes(
                id: stock.id,
                name: stock.name, 
                price: stock.price, 
                quantity: stock.quantity
            )
        )
    end 

    it "deletes stock" do 
        repo = StockRepository.new
        repo.delete(1)
        stocks = repo.all
        expect(stocks.length).to eq 2
    end

    it "cahnges name" do 
        repo = StockRepository.new
        repo.update(1, 'name', "new")
        stocks = repo.all
        expect(stocks[2].id).to eq "1"
        expect(stocks[2].name).to eq "new"
        expect(stocks[2].price).to eq "1"
    end

    it "changes price" do  
        repo = StockRepository.new
        repo.update(2, 'price', 3)
        stocks = repo.all
        expect(stocks[2].id).to eq "2"
        expect(stocks[2].name).to eq "Item2"
        expect(stocks[2].price).to eq "3"
    end

    it "changes quantity" do
        repo = StockRepository.new
        repo.update(2, 'quantity', 2)
        stocks = repo.all
        expect(stocks[2].id).to eq "2"
        expect(stocks[2].name).to eq "Item2"
        expect(stocks[2].price).to eq "2"
        expect(stocks[2].quantity).to eq "2"
    end 
end 