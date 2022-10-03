require_relative '../lib/item_repository'

def reset_name_table
  seed_sql = File.read('spec/seed_tables.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_name_table
  end

  it "returns all items" do
    repo = ItemRepository.new
    
    items = repo.all
    expect(items.length).to eq 2
    expect(items.first.id).to eq '1'
  end

  it "creates an item" do
    repo = ItemRepository.new

    new_item = Item.new
    new_item.name = 'T-rex (untrained)'
    new_item.price = '3200'
    new_item.quantity = '16'
    
    repo.create(new_item)
    
    items = repo.all
    expect(items.length).to eq 3
    expect(items[2].id).to eq '3'
  end
end
