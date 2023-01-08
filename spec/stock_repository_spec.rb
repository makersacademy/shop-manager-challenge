require_relative '../lib/stock_repository'
require_relative '../lib/stock'

RSpec.describe StockRepository do 

  def reset_stocks_table
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end
      
   
  before(:each) do 
    reset_stocks_table
  end
   
    it 'gets all stocks' do 
      repo = StockRepository.new

      stock = repo.all

      expect(stock.length).to eq 2

      expect(stock[0].id).to eq('1')
      expect(stock[0].item_name).to eq('item_1')
      expect(stock[0].unit_price).to eq('10')
      expect(stock[0].quantity).to eq('100')

      expect(stock[1].id).to eq('2')
      expect(stock[1].item_name).to eq('item_2')
      expect(stock[1].unit_price).to eq('22')
      expect(stock[1].quantity).to eq('150')
    end

    it 'gets a single stock' do 
        repo = StockRepository.new

        stock = repo.find(1)

        expect(stock.id).to eq('1')
        expect(stock.item_name).to eq('item_1')
        expect(stock.unit_price).to eq('10')
        expect(stock.quantity).to eq('100')
    end

    it 'creates a stock entry' do 
        repo = StockRepository.new

        stock = Stock.new
        stock.item_name = 'item_3'
        stock.unit_price = '27'
        stock.quantity = '200'

        repo.create(stock)

        stocks = repo.all
        last_stock = stocks.last
        expect(last_stock.item_name).to eq('item_3')
        expect(last_stock.unit_price).to eq('27')
        expect(last_stock.quantity).to eq('200')
    end
    
    it 'updates the stock' do 
        repo = StockRepository.new

        stock = repo.find(1)
        stock.item_name = 'updated_item'
        stock.unit_price = '99'
        stock.quantity = '100000'

        repo.update(stock)
        updated_stock = repo.find(1)
        expect(updated_stock.id).to eq('1')
        expect(updated_stock.item_name).to eq('updated_item')
        expect(updated_stock.unit_price).to eq('99')
        expect(updated_stock.quantity).to eq('100000')
    end

    it 'deletes the stock' do
        repo = StockRepository.new

        delete_stock = repo.delete('1')
        stocks = repo.all

        expect(stocks.length).to eq(1)

        expect(stocks.first.id).to eq('2')
        expect(stocks.first.item_name).to eq('item_2')
        expect(stocks.first.unit_price).to eq('22')
        expect(stocks.first.quantity).to eq('150')
    end

end 
