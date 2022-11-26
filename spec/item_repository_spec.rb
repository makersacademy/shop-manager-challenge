require 'item_repository'

def reset_items_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_database_test' })
  connection.exec(seed_sql)
end

describe ItemRepository do

  before(:each) do 
    reset_items_table
  end

  it 'gets all items' do 

    repo = ItemRepository.new

    items = repo.all
    
    expect(items.length).to eq 5
    
    expect(items[0].id).to eq '1'
    expect(items[0].name).to eq 'Semi Skimmed Milk: 2 Pints'
    expect(items[0].unit_price).to eq '1.30'
    expect(items[0].quantity).to eq '30'
    
    expect(items[2].id).to eq '3'
    expect(items[2].name).to eq 'Hovis Soft White Medium Bread: 800G'
    expect(items[2].unit_price).to eq '1.40'
    expect(items[2].quantity).to eq '10'
    
    expect(items[4].id).to eq '5'
    expect(items[4].name).to eq 'Walkers Baked Cheese & Onion 37.5G'
    expect(items[4].unit_price).to eq '2.40'
    expect(items[4].quantity).to eq '80'
  end 
end
