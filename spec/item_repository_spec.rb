require 'item_repository'

def reset_tables
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_database_test' })
  connection.exec(seed_sql)
end

describe ItemRepository do

  before(:each) do 
    reset_tables
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

  it 'creates a new item object' do 

    repo = ItemRepository.new 

    item = Item.new
    
    item.name = 'Fanta Orange 500Ml'
    item.unit_price = '0.32'
    item.quantity = '40'
    
    repo.create(item)
    
    all_items = repo.all
    
    expect(all_items.length).to eq 6
    expect(all_items.last.id).to eq '6'
    expect(all_items.last.name).to eq 'Fanta Orange 500Ml'
    expect(all_items.last.unit_price).to eq '0.32'
    expect(all_items.last.quantity).to eq '40'
    

  end 
end
