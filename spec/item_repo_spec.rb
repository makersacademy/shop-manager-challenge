require 'item_repo'

def reset_tables
  seed_sql = File.read('spec/seeds_items_orders.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_tables
  end

  it "gets all items" do
    repo = ItemRepository.new
    items = repo.all
    
    expect(items.length).to eq 5
    
    expect(items[0].id).to eq '1'
    expect(items[0].name).to eq 'Hoover'
    expect(items[0].unit_price).to eq '100'
    expect(items[0].qty).to eq '20'
    
    expect(items[1].id).to eq '2'
    expect(items[1].name).to eq 'Washing Machine'
    expect(items[1].unit_price).to eq '400'
    expect(items[1].qty).to eq '30'  
  end

  it "finds an item" do
    repo = ItemRepository.new
    item = repo.find_item(4)
    
    expect(item.id).to eq '4'
    expect(item.name).to eq 'Tumble Dryer'
    expect(item.unit_price).to eq '279'
    expect(item.qty).to eq '44'  
  end

  it "creates an item" do
    repo = ItemRepository.new

    item = Item.new
    item.name = 'Dishwasher'
    item.unit_price = '429'
    item.qty = '7'
    
    repo.create(item)
    items = repo.all

    expect(items.length).to eq 6
    
    expect(items[0].id).to eq '1'
    expect(items[0].name).to eq 'Hoover'
    expect(items[0].unit_price).to eq '100'
    expect(items[0].qty).to eq '20'
    
    expect(items[5].id).to eq '6'
    expect(items[5].name).to eq 'Dishwasher'
    expect(items[5].unit_price).to eq '429'
    expect(items[5].qty).to eq '7'  
  end

  it "updates an item" do
    repo = ItemRepository.new

    item = Item.new
    item.name = 'Hoover'
    item.unit_price = '149'
    item.qty = '15'
    
    repo.update(1, item)
    items = repo.all.sort_by { |item| item.id.to_i }
    
    expect(items.length).to eq 5
    
    expect(items[0].id).to eq '1'
    expect(items[0].name).to eq 'Hoover'
    expect(items[0].unit_price).to eq '149'
    expect(items[0].qty).to eq '15'
    
    expect(items[1].id).to eq '2'
    expect(items[1].name).to eq 'Washing Machine'
    expect(items[1].unit_price).to eq '400'
    expect(items[1].qty).to eq '30'
  end

end
