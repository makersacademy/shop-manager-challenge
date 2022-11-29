require 'stock_repo'

RSpec.describe StockRepo do 
def reset_albums_table 
  seed_sql = File.read('spec/seeds_stock_repo.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager' })
  connection.exec(seed_sql)
end
before(:each) do 
  reset_albums_table
end 
it 'returns 1 input stock' do 
  repo = StockRepo.new 
  stocks = repo.all 
  
  expect(stocks.first.id).to eq('1')
  expect(stocks.first.item_name).to eq('Bread')
  expect(stocks.first.quantity).to eq('15')
  expect(stocks.first.order_no).to eq('5')
end 
end 