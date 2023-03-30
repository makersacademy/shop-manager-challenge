require 'item_repository'

def reset_items_table
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  seed_sql = File.read('spec/seeds_items.sql')
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_items_table
  end
  let(:repo) { ItemRepository.new }

  it 'returns the list of all items in an array' do
    items = repo.all
    expect(items.length).to eq 11
    expect(items[0].name).to eq "Soap"
    expect(items[0].unit_price).to eq 10
    expect(items[-1].name).to eq "Chicken"
  end

  it 'returns the list of all items and their prices in a formatted string array' do
    items = repo.price_list
    expect(items.length).to eq 11
    expect(items[0]).to eq "Item: 1, Name: Soap, Price: 10"
    expect(items[-1]).to eq "Item: 11, Name: Chicken, Price: 18"
  end

  it 'returns the list of all items and their stock in a formatted string array' do
    items = repo.inventory_stock_list
    expect(items.length).to eq 11
    expect(items[0]).to eq "Item: 1, Name: Soap, Quantity: 100"
    expect(items[-1]).to eq "Item: 11, Name: Chicken, Quantity: 40"
  end
end