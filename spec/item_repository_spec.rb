require_relative '../lib/item_repository'

def reset_shop_table
  seed_sql = File.read('spec/seeds_shop.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_shop_table
  end

  it 'returns all items in stock' do
    repo = ItemRepository.new
    stock = repo.all
    expect(stock.length).to eq 8
    expect(stock[0].name).to eq 'Socks'
    expect(stock[2].price).to eq '$12.00'
    expect(stock[5].quantity).to eq '90'
  end
end
